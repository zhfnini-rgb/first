param(
  [string]$TemplatePath = (Join-Path $PSScriptRoot "..\openclaw.telegram-kimi.example.json"),
  [string]$TargetConfigPath = (Join-Path $HOME ".openclaw\openclaw.json"),
  [string]$TargetWorkspacePath = (Join-Path $HOME ".openclaw\workspace")
)

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$dotenvPath = Join-Path $repoRoot ".env"
$workspaceTemplateDir = Join-Path $repoRoot "workspace"

function Load-DotEnvFile {
  param([string]$Path)

  if (-not (Test-Path -LiteralPath $Path)) {
    return
  }

  Get-Content -LiteralPath $Path | ForEach-Object {
    $line = $_.Trim()
    if (-not $line -or $line.StartsWith("#")) {
      return
    }

    $pair = $line -split "=", 2
    if ($pair.Count -ne 2) {
      return
    }

    $name = $pair[0].Trim()
    $value = $pair[1].Trim()
    if (-not $name) {
      return
    }

    [Environment]::SetEnvironmentVariable($name, $value, "Process")
  }

  Write-Host "Loaded environment variables from $Path"
}

$openclawCmd = Get-Command openclaw -ErrorAction SilentlyContinue
if (-not $openclawCmd) {
  Write-Error "openclaw was not found in PATH. Install it first, for example: npm install -g openclaw"
  exit 1
}

Load-DotEnvFile -Path $dotenvPath

$missing = @()
if (-not $env:MOONSHOT_API_KEY) {
  $missing += "MOONSHOT_API_KEY"
}
if (-not $env:TELEGRAM_BOT_TOKEN) {
  $missing += "TELEGRAM_BOT_TOKEN"
}
if ($missing.Count -gt 0) {
  Write-Warning ("Missing environment variables: " + ($missing -join ", "))
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $TargetConfigPath) | Out-Null
New-Item -ItemType Directory -Force -Path $TargetWorkspacePath | Out-Null

if (-not (Test-Path -LiteralPath $TargetConfigPath)) {
  Copy-Item -LiteralPath $TemplatePath -Destination $TargetConfigPath
  Write-Host "Created config template at $TargetConfigPath"
} else {
  Write-Host "Keeping existing config at $TargetConfigPath"
}

if (Test-Path -LiteralPath $workspaceTemplateDir) {
  Get-ChildItem -LiteralPath $workspaceTemplateDir -File | ForEach-Object {
    $target = Join-Path $TargetWorkspacePath $_.Name
    if (-not (Test-Path -LiteralPath $target)) {
      Copy-Item -LiteralPath $_.FullName -Destination $target
      Write-Host "Added workspace file $($_.Name)"
    }
  }
}

openclaw config validate
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}

openclaw gateway run --bind loopback --port 18789 --force
