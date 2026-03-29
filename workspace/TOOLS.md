# TOOLS.md

## 常用命令

- `openclaw --version`
- `openclaw config validate`
- `openclaw channels status --probe`
- `openclaw gateway run --bind loopback --port 18789 --force`

## Telegram 排查

- 先看 gateway 是否在 `127.0.0.1:18789` 监听
- 再看 `openclaw channels status --probe`
- 如果只是 Bonjour 或 mDNS 报警，不一定影响 Telegram
- 不要把真实 bot token 写进仓库

## 配置习惯

- 密钥优先放 `.env` 或系统环境变量
- 改配置后先跑 `openclaw config validate`
- 面向用户的回复优先中文
