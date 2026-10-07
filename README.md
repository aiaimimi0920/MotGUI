# MotGUI

Mot 桌面客户端与图形交互工程，独立仓库：https://github.com/aiaimimi0920/MotGUI 。

工程入口为 `project.godot`。本仓库保存旧 Godot 客户端、资源、插件加载器与历史模板；具体插件已迁至 [MotPlugin](https://github.com/aiaimimi0920/MotPlugin)，不在本仓库重复维护。

**当前仅完成结构迁移，不保证可以直接运行。** 旧插件的 `res://` 路径、加载与打包方式尚未适配；旧工程也依赖定制引擎和历史服务，不能直接用普通 Godot 批量重存资源。

- [开发状态与限制](docs/DEVELOPMENT.md)
- [历史文档与恢复证据说明](docs/HISTORY.md)
- [历史中文说明](docs/legacy/README_ZH.md)
- [历史英文说明](docs/legacy/README_EN.md)

本项目不实现通用协议规范本身，也不把旧 `core/` 目录当作新 [MotCore](https://github.com/aiaimimi0920/MotCore) 的实现。所有项目内部文档在本仓库维护。
