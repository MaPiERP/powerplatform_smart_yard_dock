param(
  [string]$EnvUrl   = "https://org4d258410.crm4.dynamics.com/",
  [string]$Solution = "SmartYardDock",
  [string]$RepoRoot = (Resolve-Path .)
)
& ".\scripts\Export-Unpack.ps1" -EnvUrl $EnvUrl -Solution $Solution -RepoRoot $RepoRoot
