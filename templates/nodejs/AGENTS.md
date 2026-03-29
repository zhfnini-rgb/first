# AGENTS.md

你正在一个以 Node.js / JavaScript / TypeScript 为主的项目中工作。

## 目标

- 优先保持项目可构建、可测试、可维护
- 优先遵循仓库现有包管理器和脚本约定
- 修改后优先给出最小可验证方案

## 工作规则

- 优先识别当前仓库使用的是 `pnpm`、`npm` 还是 `bun`
- 有 lockfile 就沿用对应包管理器，不要混用
- 优先复用现有脚本：`test`、`build`、`lint`、`check`
- 不要无故大面积格式化整个仓库
- 不要把依赖升级和业务修复混在一起

## 代码偏好

- 优先小函数、清晰命名、稳定类型
- TypeScript 尽量避免 `any`
- 优先抽公共逻辑，而不是复制实现
- 涉及复杂分支时加简短注释

## 常用验证

- `pnpm test` / `npm test`
- `pnpm build` / `npm run build`
- `pnpm lint` / `npm run lint`
- 对于单文件改动，优先跑最直接相关的命令

## 输出要求

- 用中文解释修改内容
- 说明执行了什么验证
- 如果命令未执行，要说明原因
