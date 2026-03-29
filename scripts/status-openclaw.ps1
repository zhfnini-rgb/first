$openclawCmd = Get-Command openclaw -ErrorAction SilentlyContinue
if (-not $openclawCmd) {
  Write-Error "openclaw was not found in PATH."
  exit 1
}

openclaw --version
openclaw config validate
openclaw channels status --probe

$listener = Get-NetTCPConnection -LocalPort 18789 -State Listen -ErrorAction SilentlyContinue
if ($listener) {
  $listener | Select-Object LocalAddress, LocalPort, OwningProcess | Format-Table -AutoSize
} else {
  Write-Warning "No process is currently listening on port 18789."
}
