Import-Module ActiveDirectory

$Countries = @("CapeVerde","Norway","Argentina","France")
$RootPath = "C:\WorldCupShares"

foreach ($Country in $Countries) {

    $FolderPath = "$RootPath\${Country}_Playbook"
    $PlayersGroup = "SG_${Country}_Players"
    $CoachesGroup = "SG_${Country}_Coaches"

    if (-not (Test-Path $FolderPath)) {
        Write-Host "Folder not found: $FolderPath" -ForegroundColor Red
        continue
    }

    if (-not (Get-ADGroup -Filter "Name -eq '$CoachesGroup'" -ErrorAction SilentlyContinue)) {
        Write-Host "Coach group not found: $CoachesGroup" -ForegroundColor Red
        continue
    }

    icacls $FolderPath /grant "${CoachesGroup}:(OI)(CI)F" | Out-Null

    Write-Host "Granted Full Control to $CoachesGroup on $FolderPath" -ForegroundColor Green
}