# OpenClaw 故障排除指南

## 常见问题

### Gateway 无法启动

**症状**: 运行 `openclaw gateway start` 后无响应

**检查步骤**:
1. 检查端口占用: `netstat -ano | findstr 18789`
2. 查看日志: `cat $env:USERPROFILE\.openclaw\logs\gateway.log`
3. 尝试强制重启: `openclaw gateway restart --force`

**解决方案**:
```powershell
# 杀死占用端口的进程
$port = 18789
$process = netstat -ano | findstr ":$port" | findstr "LISTENING"
if ($process) {
    $pid = ($process -split '\s+')[-1]
    taskkill /F /PID $pid
}
```

---

### 模型返回错误

**症状**: API 调用失败或返回空响应

**检查步骤**:
1. 检查 API Key: `openclaw models status --check`
2. 查看配额使用情况
3. 尝试切换模型

---

### 技能无法加载

**症状**: 命令不存在或报错

**检查步骤**:
1. 确认技能已安装: `npx skills check`
2. 检查 SKILL.md 是否存在
3. 查看技能日志

---

### 配置文件损坏

**症状**: OpenClaw 无法启动或行为异常

**恢复步骤**:
1. 备份当前配置
2. 从示例恢复: `cp openclaw.example.json openclaw.json`
3. 逐步重新配置

---

## 日志位置

| 组件 | 路径 |
|------|------|
| Gateway | `$env:USERPROFILE\.openclaw\logs\gateway.log` |
| 会话 | `$env:USERPROFILE\.openclaw\logs\sessions\` |
| 技能 | 各技能目录下的 logs/ |

---

## 获取帮助

1. 查看文档: https://docs.openclaw.ai
2. 社区 Discord: https://discord.com/invite/clawd
3. 搜索 Solvr: https://solvr.dev
