# OpenClaw 命令速查表

## 核心命令

| 命令 | 说明 |
|------|------|
| `openclaw status` | 查看整体状态 |
| `openclaw gateway start` | 启动 Gateway |
| `openclaw gateway stop` | 停止 Gateway |
| `openclaw gateway restart` | 重启 Gateway |
| `openclaw models list` | 列出可用模型 |
| `openclaw models status` | 检查模型状态 |

## 会话管理

| 命令 | 说明 |
|------|------|
| `/new` 或 `/reset` | 开始新会话 |
| `/status` | 查看当前会话状态 |
| `/reasoning` | 切换推理模式 |

## 技能管理

| 命令 | 说明 |
|------|------|
| `npx skills find <关键词>` | 搜索技能 |
| `npx skills add <仓库>` | 安装技能 |
| `npx skills check` | 检查已安装技能 |
| `npx skills update` | 更新所有技能 |

## GitHub 集成

| 命令 | 说明 |
|------|------|
| `gh auth login` | 登录 GitHub |
| `gh repo view <repo>` | 查看仓库 |
| `gh issue list` | 列出 Issues |
| `gh pr list` | 列出 PRs |

## 本仓库脚本

| 脚本 | 说明 |
|------|------|
| `.\scripts\start-openclaw.ps1` | 启动 OpenClaw |
| `.\scripts\status-openclaw.ps1` | 查看状态 |
| `.\scripts\backup-openclaw.ps1` | 备份配置 |
| `.\scripts\health-check.ps1` | 健康检查 |
| `.\scripts\skill-manager.ps1` | 技能管理 |

## 快速诊断

```powershell
# 一键检查
.\scripts\health-check.ps1

# 自动重启如果挂了
.\scripts\health-check.ps1 -AutoRestart

# 备份配置
.\scripts\backup-openclaw.ps1

# 查看技能列表
.\scripts\skill-manager.ps1 list
```
