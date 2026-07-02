param(
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [string]$ProdBranch = "prod"
)

$ErrorActionPreference = "Stop"

if ($Name -notmatch "^release/") {
    $Name = "release/$Name"
}

git fetch origin --prune | Out-Null
git switch $ProdBranch
git pull --ff-only
git switch -c $Name

Write-Host "Created release branch: $Name" -ForegroundColor Green
Write-Host "Move approved files with: .\scripts\take-from-test.ps1 -Path <path>" -ForegroundColor Green
