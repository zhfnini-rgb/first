# OpenClaw 健康检查
# 用法: .\scripts\health-check.ps1

param(
    [switch]$AutoRestart
)

$ErrorActionPreference = "Stop"

Write-Host "OpenClaw 健康检查" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan

$Checks = @()

# 检查 1: Gateway 是否运行
$GatewayRunning = $false
try {
    $response = Invoke-RestMethod -Uri "http://localhost:18789/status" -Method GET -TimeoutSec 5
    if ($response.status -eq "ok") {
        $GatewayRunning = $true
        Write-Host "✓ Gateway 运行正常" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Gateway 未响应" -ForegroundColor Red
}
$Checks += @{ Name = "Gateway"; Status = $GatewayRunning }

# 检查 2: 配置文件是否存在
$ConfigExists = Test-Path "$env:USERPROFILE\.openclaw\openclaw.json"
if ($ConfigExists) {
    Write-Host "✓ 配置文件存在" -ForegroundColor Green
} else {
    Write-Host "✗ 配置文件缺失" -ForegroundColor Red
}
$Checks += @{ Name = "Config"; Status = $ConfigExists }

# 检查 3: 工作空间是否存在
$WorkspaceExists = Test-Path "$env:USERPROFILE\.openclaw\workspace"
if ($WorkspaceExists) {
    Write-Host "✓ 工作空间存在" -ForegroundColor Green
} else {
    Write-Host "✗ 工作空间缺失" -ForegroundColor Red
}
$Checks += @{ Name = "Workspace"; Status = $WorkspaceExists }

# 检查 4: 日志目录
$LogsExist = Test-Path "$env:USERPROFILE\.openclaw\logs"
if ($LogsExist) {
    $LogSize = (Get-ChildItem "$env:USERPROFILE\.openclaw\logs" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    Write-Host "✓ 日志目录存在 ($([math]::Round($LogSize, 2)) MB)" -ForegroundColor Green
} else {
    Write-Host "✗ 日志目录缺失" -ForegroundColor Red
}
$Checks += @{ Name = "Logs"; Status = $LogsExist }

# 自动重启
if (-not $GatewayRunning -and $AutoRestart) {
    Write-Host "`n正在尝试重启 Gateway..." -ForegroundColor Yellow
    & "$PSScriptRoot\start-openclaw.ps1"
}

# 总结
$Failed = $Checks | Where-Object { -not $_.Status }
if ($Failed) {
    Write-Host "`n检查完成，发现问题: $($Failed.Count) 个" -ForegroundColor Red
    exit 1
} else {
    Write-Host "`n所有检查通过 ✓" -ForegroundColor Green
    exit 0
}
