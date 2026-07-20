Import-Module ActiveDirectory

$CsvPath = "C:\Scripts\WorldCup\WorldCupCoaches.csv"
$BaseOU = "OU=World Cup 2026,OU=JBLab,DC=jblab,DC=local"
$DefaultPassword = ConvertTo-SecureString "Welcome2026!" -AsPlainText -Force

Import-Csv $CsvPath | ForEach-Object {

    $FirstName = $_.FirstName
    $LastName = $_.LastName
    $Username = $_.Username
    $Country = $_.Country
    $FullName = "$FirstName $LastName".Trim()
    $GroupName = "SG_${Country}_Coaches"

    $CoachesOU = Get-ADOrganizationalUnit -LDAPFilter "(ou=Coaches)" -SearchBase $BaseOU |
        Where-Object { $_.DistinguishedName -like "*OU=$Country,*" }

    if (-not $CoachesOU) {
        Write-Host "Coaches OU not found for $Country" -ForegroundColor Red
        return
    }

    if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
        Write-Host "Security group not found: $GroupName" -ForegroundColor Red
        return
    }

    if (Get-ADUser -Filter "SamAccountName -eq '$Username'" -ErrorAction SilentlyContinue) {
        Write-Host "Coach already exists: $Username" -ForegroundColor Yellow
    }
    else {
        New-ADUser `
            -Name $FullName `
            -GivenName $FirstName `
            -Surname $LastName `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@jblab.local" `
            -Path $CoachesOU.DistinguishedName `
            -AccountPassword $DefaultPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        Add-ADGroupMember -Identity $GroupName -Members $Username

        Write-Host "Created coach: $FullName and added to $GroupName" -ForegroundColor Green
    }
}