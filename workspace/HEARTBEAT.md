# HEARTBEAT.md

每次心跳只做轻量检查：

- 确认 gateway 仍可启动或已在运行
- 确认配置没有明显语法错误
- 不要重复处理旧任务
- 如果没有新任务，回复 `HEARTBEAT_OK`
