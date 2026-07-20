Import-Module ActiveDirectory

$CsvPath = "C:\Scripts\WorldCup\WorldCupGroups.csv"
$BaseOU = "OU=World Cup 2026,OU=JBLab,DC=jblab,DC=local"

Import-Csv $CsvPath | ForEach-Object {

    $Country = $_.Country
    $GroupsOU = "OU=Groups,OU=$Country"

    # Find the Groups OU for this country
    $CountryGroupsOU = Get-ADOrganizationalUnit -LDAPFilter "(ou=Groups)" -SearchBase $BaseOU |
        Where-Object { $_.DistinguishedName -like "*OU=$Country,*" }

    if ($CountryGroupsOU) {

        foreach ($Type in @("Players","Coaches")) {

            $GroupName = "SG_${Country}_$Type"

            if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {

                New-ADGroup `
                    -Name $GroupName `
                    -SamAccountName $GroupName `
                    -GroupScope Global `
                    -GroupCategory Security `
                    -Path $CountryGroupsOU.DistinguishedName

                Write-Host "Created $GroupName" -ForegroundColor Green
            }
            else {
                Write-Host "$GroupName already exists" -ForegroundColor Yellow
            }
        }
    }
    else {
        Write-Host "Groups OU not found for $Country" -ForegroundColor Red
    }
}