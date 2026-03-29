# Windows Quickstart

## 1. Clone this repo

```powershell
git clone https://github.com/zhfnini-rgb/first.git
cd first
```

## 2. Install OpenClaw

```powershell
npm install -g openclaw
```

## 3. Prepare environment variables

1. Copy `.env.example` to `.env`
2. Replace the placeholders with your real values

Recommended variables:

- `MOONSHOT_API_KEY`
- `TELEGRAM_BOT_TOKEN`

## 4. Start OpenClaw

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-openclaw.ps1
```

What the script does:

- loads `.env` into the current PowerShell process
- if `~/.openclaw/openclaw.json` does not exist, copies `openclaw.telegram-kimi.example.json`
- copies missing starter files from `workspace/` into `~/.openclaw/workspace`
- validates the config
- starts the gateway on `127.0.0.1:18789`

## 5. Check status

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\status-openclaw.ps1
```

## Notes

- Real secrets should stay in `.env` or your system environment variables, not in git
- If you already have an existing `~/.openclaw/openclaw.json`, the start script will keep it and will not overwrite it
- The template config disables mDNS discovery by default, so local Bonjour noise is reduced
