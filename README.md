# OpenClaw Telegram + Kimi Starter

这是一个面向 Windows 场景的 OpenClaw 实战模板仓库，默认围绕 `Telegram + Kimi` 搭建，适合用来快速起一个可运行、可扩展、可继续定制的个人 AI 助手环境。

## 这个仓库解决什么问题

很多人装上 OpenClaw 之后，真正卡住的不是“能不能装”，而是：

- 配置文件怎么组织
- Telegram bot 怎么接进来
- Kimi 怎么作为默认模型接入
- 工作区文件该怎么写
- Windows 上怎么快速启动和检查状态

这个仓库就是把这些常见起步步骤整理成一个最小可用模板，尽量做到 clone 下来后稍微改一下就能跑。

## 仓库里现在有什么

- `openclaw.telegram-kimi.example.json`: 面向 `Telegram + Kimi` 的实用配置模板
- `openclaw.example.json`: 更基础的 OpenClaw 配置示例
- `.env.example`: 环境变量模板，避免把真实密钥写进仓库
- `scripts/start-openclaw.ps1`: Windows 启动脚本
- `scripts/status-openclaw.ps1`: Windows 状态检查脚本
- `workspace/AGENTS.md`: 工作区级 agent 规则
- `workspace/TOOLS.md`: 常用命令和排查说明
- `workspace/HEARTBEAT.md`: 轻量心跳检查模板
- `QUICKSTART-WINDOWS.md`: Windows 快速开始说明

## 适合谁

这个模板比较适合：

- 想把 Telegram bot 接到 OpenClaw 的人
- 想默认使用 Kimi 的人
- 想先在 Windows 本地跑通，再慢慢扩展的人
- 想把 OpenClaw 配置、脚本、工作区说明放进 GitHub 管理的人

## 快速开始

1. 克隆仓库
2. 安装 OpenClaw
3. 按 `.env.example` 填写你自己的密钥
4. 运行 `scripts/start-openclaw.ps1`
5. 用 `scripts/status-openclaw.ps1` 检查状态

更完整的步骤见 [QUICKSTART-WINDOWS.md](https://github.com/zhfnini-rgb/first/blob/main/QUICKSTART-WINDOWS.md)。

## 设计原则

- 默认可跑，不追求一开始就很复杂
- 优先中文说明
- 尽量减少把真实凭据写进仓库的风险
- 优先保留后续扩展空间，例如多 agent、自动化脚本、社媒工作流

## 后续可以继续补充

- 多 agent 模板
- 双 Telegram bot 路由模板
- Tieba / 社媒自动化脚本
- GitHub Actions 或部署说明
- 更完整的 OpenClaw 工作区规范
