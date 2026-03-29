# OpenClaw 技能管理
# 用法: .\scripts\skill-manager.ps1 [list|install|update|backup]

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("list", "install", "update", "backup")]
    [string]$Action,
    
    [string]$SkillName
)

$SkillsDir = "$env:USERPROFILE\.openclaw\skills"
$BackupDir = "$env:USERPROFILE\.openclaw-backups\skills"

function Get-InstalledSkills {
    if (!(Test-Path $SkillsDir)) {
        return @()
    }
    Get-ChildItem $SkillsDir -Directory | ForEach-Object {
        $skillName = $_.Name
        $skillMd = Join-Path $_.FullName "SKILL.md"
        $version = "unknown"
        if (Test-Path $skillMd) {
            $content = Get-Content $skillMd -Raw -ErrorAction SilentlyContinue
            if ($content -match "version:\s*(.+)") {
                $version = $matches[1].Trim()
            }
        }
        [PSCustomObject]@{
            Name = $skillName
            Path = $_.FullName
            Version = $version
        }
    }
}

function Backup-Skills {
    if (!(Test-Path $BackupDir)) {
        New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
    }
    
    $Date = Get-Date -Format "yyyy-MM-dd-HHmm"
    $BackupFile = Join-Path $BackupDir "skills-backup-$Date.json"
    
    $skills = Get-InstalledSkills
    $skills | ConvertTo-Json -Depth 3 | Out-File $BackupFile
    
    Write-Host "技能列表已备份到: $BackupFile" -ForegroundColor Green
}

switch ($Action) {
    "list" {
        Write-Host "已安装的技能:" -ForegroundColor Cyan
        $skills = Get-InstalledSkills
        if ($skills.Count -eq 0) {
            Write-Host "  (无)" -ForegroundColor Gray
        } else {
            $skills | ForEach-Object {
                Write-Host "  • $($_.Name) (v$($_.Version))" -ForegroundColor Green
            }
        }
    }
    
    "backup" {
        Backup-Skills
    }
    
    "install" {
        if (!$SkillName) {
            Write-Error "安装技能需要提供 -SkillName 参数"
            exit 1
        }
        Write-Host "安装技能: $SkillName" -ForegroundColor Cyan
        # 这里可以集成 clawhub 或其他安装源
        Write-Host "提示: 使用 'npx skills add <owner/repo@skill>' 安装技能" -ForegroundColor Yellow
    }
    
    "update" {
        Write-Host "检查技能更新..." -ForegroundColor Cyan
        # 这里可以集成更新逻辑
        Write-Host "提示: 使用 'npx skills update' 更新所有技能" -ForegroundColor Yellow
    }
}
