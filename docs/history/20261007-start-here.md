# 项目恢复与开发入口

这是一份供重新开发使用的 MiMi / VMe 合并源码快照，整理于 2026-10-06。当前目录名为 Mot，但没有擅自重命名项目内部标识。

源码已在新仓库 https://github.com/aiaimimi0920/Mot 建立独立历史，没有继承旧仓库的 Git 历史。2026-10-07 已建立 `mot_gui`、`mot_core`、`g2a`、`mot_plugin` 四个一级目录，详见 [项目总说明](README.md) 和 [目录迁移记录](docs/PROJECT_LAYOUT.md)。

## 从哪里开始

- Godot 工程入口：`mot_gui/project.godot`。
- 主场景与启动逻辑：`mot_gui/core/system/main.tscn`、`mot_gui/core/system/main.gd`。
- 功能插件：`mot_gui/plugin/`。
- Godot 服务适配层：`mot_gui/external_service_adapter/`。
- Python 外部服务：`mot_gui/external_service/`。
- 旧插件目前仍保留在完整 Godot 工程中；`mot_plugin/` 是后续独立开发的入口，不是已经完成物理拆分的代码目录。
- 原有说明：`mot_gui/README_ZH.md`、`mot_gui/README.md`。它们保留的是历史说明，不能当作当前部署状态。
- 来源、取舍及验证范围：`docs/recovery/RECOVERY_REPORT.md`。
- 初始恢复时的逐文件来源与 SHA-256：`docs/recovery/source-manifest.json`。这是迁移前的历史快照，当前路径映射见目录迁移记录。

## 当前交付边界

**源码归并已完成，不代表旧程序已经在当前环境运行通过。** 本轮没有运行 Godot、安装 Python 依赖、启动外部服务或访问历史业务接口。

当前配置记录 Godot 4.4，但旧文档明确依赖定制引擎，资源中仍有 `ColorScheme` 等定制类型；历史 tools 分支的编辑器二进制也不能直接认定与当前源码兼容。不要直接让普通 Godot 批量重存资源。

启动逻辑仍保留历史认证、插件下载及京东/淘宝测试调用。恢复运行前应先决定如何处理旧平台地址、用户数据目录和自动联网行为。原程序更新入口虽然已注释，插件下载路径仍然存在。

`mot_gui/export_presets.cfg` 与 `mot_gui/backup_export_presets.cfg` 保留历史模板配置，相对导出路径已调整以保持原输出位置，但仍包含旧机器上的定制模板路径；它们不是已验证的打包入口。Python `.spec` 同样依赖历史环境，当前没有可复现的依赖版本清单。

## 敏感配置

为避免将历史硬编码值带入新仓库，两处 Python 文件改为读取以下环境变量：

- `MOT_BAIDU_SPEECH_APP_ID`
- `MOT_BAIDU_SPEECH_API_KEY`
- `MOT_BAIDU_SPEECH_SECRET_KEY`
- `MOT_QIANQIAN_SIGNING_SECRET`

只有调用相应语音/签名功能时才需要这些变量；缺少时抛出 `KeyError`，不再使用历史默认凭据。语音接口显式传入 `baiduspeech_params` 的路径保持不变。没有新增 `.env` 自动加载功能。历史值的归属、有效性未验证；应使用自己合法取得的配置，历史凭据若属于你应考虑轮换。

## 保留与排除

保留了原始许可证、场景、模型、图片、音频、脚本 UID 和现有 GDExtension 原生依赖。因此这里不是仅含 `.gd`/`.py` 的残缺目录，也不是编译后的应用发行包。

未带入 `.git`、`.godot` 缓存、`.history`、临时 DLL、`.lib`/`.exp` 编译产物或旧 Godot EXE。原始工程未修改，完整远程镜像与恢复证据保存在单独临时目录，见恢复报告；不要把该临时目录上传到新仓库。

下一步宜先做定制引擎及离线启动兼容性恢复，再开展新功能；本次没有擅自进行这些开发改造。
