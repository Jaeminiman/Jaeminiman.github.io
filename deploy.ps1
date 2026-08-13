# One-shot deploy for https://jaeminiman.github.io   (Windows / PowerShell)
# Run from inside this folder:   .\deploy.ps1

$ErrorActionPreference = 'Stop'
$Repo  = 'Jaeminiman.github.io'
$Name  = 'Jaemin Shin'
$Email = 'wpals113@snu.ac.kr'

Set-Location $PSScriptRoot

# --- prerequisites -----------------------------------------------------------
$missing = @()
foreach ($t in 'git','gh') {
  if (-not (Get-Command $t -ErrorAction SilentlyContinue)) { $missing += $t }
}
if ($missing.Count -gt 0) {
  Write-Host ""
  Write-Host "Missing: $($missing -join ', ')" -ForegroundColor Yellow
  Write-Host "Install, then CLOSE and REOPEN PowerShell and run this script again:"
  if ($missing -contains 'git') { Write-Host "  winget install --id Git.Git -e" }
  if ($missing -contains 'gh')  { Write-Host "  winget install --id GitHub.cli -e" }
  Write-Host ""
  exit 1
}

# --- log in ------------------------------------------------------------------
gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Signing in to GitHub..." -ForegroundColor Cyan
  gh auth login
}

# --- commit ------------------------------------------------------------------
if (-not (Test-Path .git)) { git init -q }
git add -A
git -c user.name="$Name" -c user.email="$Email" commit -qm "Personal homepage" 2>&1 | Out-Null
git branch -M main

# --- create + push -----------------------------------------------------------
Write-Host "Creating $Repo and pushing..." -ForegroundColor Cyan
gh repo create $Repo --public --source=. --remote=origin --push

# <user>.github.io repos enable Pages automatically; nudge the first build anyway.
gh api -X POST "repos/{owner}/$Repo/pages" -f "source[branch]=main" -f "source[path]=/" 2>&1 | Out-Null

Write-Host ""
Write-Host "Done. Live at https://jaeminiman.github.io in about a minute." -ForegroundColor Green
Write-Host ""
