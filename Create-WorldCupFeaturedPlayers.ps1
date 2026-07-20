Import-Module ActiveDirectory

$CsvPath = "C:\Scripts\WorldCup\WorldCupFeaturedPlayers.csv"
$BaseOU = "OU=World Cup 2026,OU=JBLab,DC=jblab,DC=local"
$DefaultPassword = ConvertTo-SecureString "Welcome2026!" -AsPlainText -Force

Import-Csv $CsvPath | ForEach-Object {

    $FirstName = $_.FirstName.Trim()
    $LastName  = $_.LastName.Trim()
    $Username  = $_.Username.Trim()
    $Country   = $_.Country.Trim()

    $FullName = "$FirstName $LastName".Trim()
    $GroupName = "SG_${Country}_Players"

    $PlayersOU = Get-ADOrganizationalUnit `
        -LDAPFilter "(ou=Players)" `
        -SearchBase $BaseOU |
        Where-Object {
            $_.DistinguishedName -like "*OU=$Country,*"
        }

    if (-not $PlayersOU) {
        Write-Host "Players OU not found for $Country" -ForegroundColor Red
        return
    }

    $PlayerGroup = Get-ADGroup `
        -Filter "Name -eq '$GroupName'" `
        -ErrorAction SilentlyContinue

    if (-not $PlayerGroup) {
        Write-Host "Security group not found: $GroupName" -ForegroundColor Red
        return
    }

    $ExistingUser = Get-ADUser `
        -Filter "SamAccountName -eq '$Username'" `
        -ErrorAction SilentlyContinue

    if ($ExistingUser) {
        Write-Host "Player already exists: $Username" -ForegroundColor Yellow

        if (-not (Get-ADGroupMember $GroupName |
            Where-Object { $_.SamAccountName -eq $Username })) {

            Add-ADGroupMember -Identity $GroupName -Members $Username
            Write-Host "Added existing player to $GroupName" -ForegroundColor Cyan
        }

        return
    }

    $UserParameters = @{
        Name                  = $FullName
        DisplayName           = $FullName
        GivenName             = $FirstName
        SamAccountName        = $Username
        UserPrincipalName     = "$Username@jblab.local"
        Path                  = $PlayersOU.DistinguishedName
        AccountPassword       = $DefaultPassword
        Enabled               = $true
        ChangePasswordAtLogon = $true
    }

    if (-not [string]::IsNullOrWhiteSpace($LastName)) {
        $UserParameters["Surname"] = $LastName
    }

    New-ADUser @UserParameters

    Add-ADGroupMember `
        -Identity $GroupName `
        -Members $Username

    Write-Host `
        "Created player: $FullName and added to $GroupName" `
        -ForegroundColor Green
}