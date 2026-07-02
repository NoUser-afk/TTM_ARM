param(
    [string]$ProdBranch = "prod",
    [string]$TestBranch = "test"
)

$ErrorActionPreference = "Stop"

git fetch origin --prune | Out-Null

Write-Host "Comparing ${ProdBranch}..${TestBranch}" -ForegroundColor Cyan
Write-Host ""

Write-Host "Changed files:" -ForegroundColor Cyan
git diff --name-status --find-renames "$ProdBranch..$TestBranch"

Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
git diff --stat --find-renames "$ProdBranch..$TestBranch"
