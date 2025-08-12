param([Parameter(Mandatory=$true)][string]$SiteUrl)
Connect-PnPOnline -Url $SiteUrl -Interactive
if(-not (Get-PnPList -Identity "SmartYard_Visits" -ErrorAction SilentlyContinue)){ New-PnPList -Title "SmartYard_Visits" -Template GenericList | Out-Null }
if(-not (Get-PnPList -Identity "SmartYard_Docks" -ErrorAction SilentlyContinue)){ New-PnPList -Title "SmartYard_Docks" -Template GenericList | Out-Null }
