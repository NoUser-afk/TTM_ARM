param(
    [Parameter(Mandatory = $true)]
    [string[]]$Path,

    [string]$TestBranch = "test"
)

$ErrorActionPreference = "Stop"

$currentBranch = git branch --show-current
if ($currentBranch -notmatch "^release/") {
    throw "Current branch is '$currentBranch'. Switch to a release/* branch before taking files from test."
}

foreach ($item in $Path) {
    git checkout $TestBranch -- $item
}

Write-Host "Copied selected path(s) from $TestBranch into $currentBranch:" -ForegroundColor Green
$Path | ForEach-Object { Write-Host "  $_" }
Write-Host ""
Write-Host "Review with: git diff --stat prod..HEAD; git diff -- $($Path -join ' ')" -ForegroundColor Cyan
