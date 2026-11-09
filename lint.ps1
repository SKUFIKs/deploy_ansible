# Runs the same checks as CI before pushing.
# Usage (from repo root):  .\lint.ps1
# If the execution policy blocks it:
#   powershell -ExecutionPolicy Bypass -File .\lint.ps1

$ErrorActionPreference = 'Stop'
$distro = 'Ubuntu-24.04'

Write-Host '==> pre-commit (yamllint, ansible-lint, YAML hygiene)'
wsl -d $distro -- pre-commit run --all-files
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host '==> ansible-playbook --syntax-check'
wsl -d $distro -- ansible-playbook -i inventory.ini playbook.yml --syntax-check
exit $LASTEXITCODE
