# 备份 OpenClaw 配置
# 用法: .\scripts\backup-openclaw.ps1

$BackupDir = "$env:USERPROFILE\.openclaw-backups"
$SourceDir = "$env:USERPROFILE\.openclaw"
$Date = Get-Date -Format "yyyy-MM-dd-HHmm"
$BackupName = "openclaw-backup-$Date"
$BackupPath = Join-Path $BackupDir $BackupName

Write-Host "正在备份 OpenClaw 配置..." -ForegroundColor Cyan

# 创建备份目录
if (!(Test-Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
}

# 复制关键文件
$ItemsToBackup = @(
    "openclaw.json",
    ".env",
    "workspace\AGENTS.md",
    "workspace\SOUL.md",
    "workspace\USER.md",
    "workspace\MEMORY.md",
    "workspace\TOOLS.md",
    "workspace\HEARTBEAT.md"
)

New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null

foreach ($item in $ItemsToBackup) {
    $source = Join-Path $SourceDir $item
    if (Test-Path $source) {
        $dest = Join-Path $BackupPath $item
        $destDir = Split-Path $dest -Parent
        if (!(Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }
        Copy-Item $source $dest -Recurse -Force
        Write-Host "  ✓ $item" -ForegroundColor Green
    }
}

# 压缩备份
$ZipPath = "$BackupPath.zip"
Compress-Archive -Path $BackupPath -DestinationPath $ZipPath -Force
Remove-Item $BackupPath -Recurse -Force

Write-Host "备份完成: $ZipPath" -ForegroundColor Green

# 清理旧备份 (保留最近10个)
Get-ChildItem $BackupDir -Filter "openclaw-backup-*.zip" | 
    Sort-Object CreationTime -Descending | 
    Select-Object -Skip 10 | 
    Remove-Item -Force
