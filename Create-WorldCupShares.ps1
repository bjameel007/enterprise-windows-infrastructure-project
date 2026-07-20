Import-Module ActiveDirectory

$CsvPath = "C:\Scripts\WorldCup\WorldCupGroups.csv"
$RootPath = "C:\WorldCupShares"

if (-not (Test-Path $RootPath)) {
    New-Item -Path $RootPath -ItemType Directory
}

Import-Csv $CsvPath | ForEach-Object {

    $Country = $_.Country
    $FolderPath = "$RootPath\${Country}_Playbook"
    $ShareName = "${Country}_Playbook"
    $GroupName = "SG_${Country}_Players"

    if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
        Write-Host "Security group not found: $GroupName" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $FolderPath)) {
        New-Item -Path $FolderPath -ItemType Directory
        Write-Host "Created folder: $FolderPath" -ForegroundColor Green
    }
    else {
        Write-Host "Folder already exists: $FolderPath" -ForegroundColor Yellow
    }

    if (-not (Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue)) {
        New-SmbShare -Name $ShareName -Path $FolderPath -FullAccess "Everyone"
        Write-Host "Created share: \\dc01\$ShareName" -ForegroundColor Green
    }
    else {
        Write-Host "Share already exists: $ShareName" -ForegroundColor Yellow
    }

    icacls $FolderPath /inheritance:d | Out-Null

    icacls $FolderPath /remove "Users" "Authenticated Users" "Everyone" "Domain Users" 2>$null | Out-Null

    icacls $FolderPath /grant "SYSTEM:(OI)(CI)F" | Out-Null
    icacls $FolderPath /grant "Administrators:(OI)(CI)F" | Out-Null
    icacls $FolderPath /grant "${GroupName}:(OI)(CI)M" | Out-Null

    Write-Host "Applied NTFS permissions for $ShareName" -ForegroundColor Cyan
}