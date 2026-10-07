# 一级目录整理记录

日期：2026-10-07。基线提交：`812b5f56f77b19626340de1b713838117009da17`。

## 本轮范围

建立 `mot_gui`、`mot_core`、`g2a`、`mot_plugin` 四个职责边界，以完整迁移旧 Godot 工程作为第一步。不开发新功能，不升级引擎或依赖，不拆分旧插件运行时。

## 路径映射

- 原根目录的 `addons/`、`core/`、`external_service/`、`external_service_adapter/`、`game_settings/`、`gui/`、`models/`、`modules/`、`plugin/`、`resources/`、`update/`、`viewer/` 全部移到 `mot_gui/` 下。
- `project.godot`、两个导出配置、音频总线布局、图标及对应导入配置移到 `mot_gui/` 下。
- 原 `README.md`、`README_ZH.md` 移到 `mot_gui/` 下，增加历史说明提示。根目录 `README.md` 改为新项目总入口。
- `.git`、`.gitattributes`、`.gitignore`、`LICENSE`、`START_HERE.md`、`docs/`、`tools/` 留在仓库根目录；`mot_gui/LICENSE` 保存相同许可副本。

`docs/recovery/` 是 2026-10-06 初始恢复时的历史证据，保持原样。其来源清单与 SHA-256 对应整理前快照，不是当前树的完整性清单；查找其路径时应用上述映射。不要通过重写历史哈希来伪装证据没有发生迁移。

## 最小配套修改

- Godot 工程根变为 `mot_gui/`；内部 `res://` 路径保持不变，未修改 GDScript、场景或资源业务内容。
- 两个导出配置的 `export_path` 从 `../VMe_Export/MiMi.exe` 调整为 `../../VMe_Export/MiMi.exe`，保持原有解析后的输出位置。未执行导出，也未创建该外部目录。
- 根 `.gitignore` 的四条显式临时 DLL 路径增加 `/mot_gui/` 前缀；通用缓存和私有配置忽略规则继续适用于子目录。
- 更新入口文档及历史工具说明。旧引擎绝对路径、外部服务构建路径不在本轮修复。

## 验证方法与限制

迁移前记录全部已跟踪文件 SHA-256 和静态 `res://` 缺失集合；迁移后逐文件核对，除明确列出的配置和文档外要求字节一致。对比相同资源扫描结果，并对 Python 文件做静态编译检查，不运行模块或生成 pyc。

本轮不运行 Godot、旧更新器、外部服务或历史链接脚本。静态校验不能证明引擎可运行；原恢复阶段发现的资源缺口、定制引擎要求、历史网络行为及依赖不完整问题仍然存在。

旧插件物理抽离、智能核心实现及正式协议设计均未在本轮完成。`mot_plugin/README.md` 明确列出当前源码入口，避免形成两份维护源。
