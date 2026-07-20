Import-Module ActiveDirectory

$CsvPath = "C:\Scripts\WorldCup\WorldCupTeams.csv"
$BaseOU = "OU=World Cup 2026,OU=JBLab,DC=jblab,DC=local"
$SubOUs = @("Players", "Coaches", "Computers", "Groups")

Import-Csv $CsvPath | ForEach-Object {

    $GroupOU = "OU=$($_.Group),$BaseOU"
    $CountryOUName = $_.Country
    $CountryOUPath = "OU=$CountryOUName,$GroupOU"

    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$CountryOUPath)" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $CountryOUName -Path $GroupOU
        Write-Host "Created country OU: $CountryOUName under $($_.Group)" -ForegroundColor Green
    }
    else {
        Write-Host "Country OU already exists: $CountryOUName" -ForegroundColor Yellow
    }

    foreach ($SubOU in $SubOUs) {
        $SubOUPath = "OU=$SubOU,$CountryOUPath"

        if (-not (Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$SubOUPath)" -ErrorAction SilentlyContinue)) {
            New-ADOrganizationalUnit -Name $SubOU -Path $CountryOUPath
            Write-Host "Created sub OU: $SubOU under $CountryOUName" -ForegroundColor Cyan
        }
        else {
            Write-Host "Sub OU already exists: $SubOU under $CountryOUName" -ForegroundColor Yellow
        }
    }
}