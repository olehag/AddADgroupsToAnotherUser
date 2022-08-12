$olduser = $null
$newuser = $null
$user = $null

#Do while til bruker er funnet i AD.
do {
    $user = Read-Host "Kopier grupper fra Prewin2k"
    $olduser = Get-ADUser $user
} while (
    ($null -eq $olduser)
)
$olduser.Name

#Do while til bruker er funnet i AD.
do {
    $user = Read-Host "Kopier grupper til Prewin2k"
    $newuser = Get-ADUser $user
} while (
    ($null -eq $newuser)
)
$newuser.Name

#Do loop for bekreftelse.
do {
    $confirm = Read-Host "Legg til alle grupper fra $($olduser.name) til $($newuser.name)? `n -- y/n -- "
    if ($confirm -eq "y")
    {
        $ADgroups = (Get-ADUser $olduser -Properties MemberOf).MemberOf
        #foreach Group in $olduser, add member $newuser
        foreach ($group in $adgroups) {
            Add-Adgroupmember -Identity $group -Members $newuser
        }
    }

} while (
    ($confirm -ne "y") -and ($confirm -ne "n"))