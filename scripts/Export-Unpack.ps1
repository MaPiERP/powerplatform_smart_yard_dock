param(
  [string]$EnvUrl      = "https://org4d258410.crm4.dynamics.com/",
  [string]$Solution    = "SmartYardDock",
  [string]$RepoRoot    = "C:\projects\powerplatform_smart_yard_dock"
)

$ErrorActionPreference = "Stop"
$pkgDir = Join-Path $RepoRoot "build\pkg"
$srcDir = Join-Path $RepoRoot "powerapps\SmartYardDock"
$verFile = Join-Path $RepoRoot "VERSION.txt"

Write-Host "==> Checking tools..." -ForegroundColor Cyan
pac --version | Out-Null
git --version | Out-Null

Write-Host "==> Selecting org..." -ForegroundColor Cyan
pac auth select --url $EnvUrl | Out-Null

Write-Host "==> Ensuring folders..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $pkgDir, $srcDir | Out-Null

[string]$ver = (Get-Content $verFile -ErrorAction Stop).Trim()
if (-not $ver) { throw "VERSION.txt is empty." }

$zipName = "$($Solution)_$((Get-Date).ToString('yyyyMMdd_HHmmss'))_unmanaged.zip"
$zipPath = Join-Path $pkgDir $zipName

Write-Host "==> Exporting solution $Solution to $zipPath ..." -ForegroundColor Cyan
pac solution export --name $Solution --path $zipPath --managed false --overwrite

Write-Host "==> Unpacking to $srcDir ..." -ForegroundColor Cyan
pac solution unpack --zipfile $zipPath --folder $srcDir --processCanvasApps true --allowDelete true

Write-Host "==> Git commit & tag v$ver ..." -ForegroundColor Cyan
Set-Location $RepoRoot
git add .
git commit -m "release: v$ver export & unpack from DEV" --allow-empty
git tag -f "v$ver"
git push origin main
git push origin "v$ver" --force

Write-Host "==> Done. Release tag: v$ver" -ForegroundColor Green
