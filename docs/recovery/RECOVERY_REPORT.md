# 三来源工程归并记录

日期：2026-10-06。范围只涵盖用户指定的三个来源及它们的分支，不声称已搜索其他磁盘、用户数据中的 PCK 或其他服务端仓库。

## 已联网核实的来源

| 来源 | 分支 | 当前提交 |
| --- | --- | --- |
| `https://github.com/aiaimimi0920/mimi` | `main` | `a268d2da75f4a2d8ebc3b1c3cc7575d4f16b6d03` |
| 同上 | `plugin` | `84ae7d64fc05beb0ced811afcc194abc8f726b9d` |
| 同上 | `tools` | `60a41822333983f3ab2fa40bbac5514423928750` |
| `http://192.168.15.200:8418/yamiyu/VMe` | `local_main` | `93ce0589fb504722231c0b3deba01eea6b165e26` |
| 同上 | `local_plugin` | `945687032807c50c4fdaf030a1407dfca92edc6b` |
| 同上 | `main` | `07ed9095dba301e92d7b449e50c4f046c45a5a95` |
| 同上 | `plugin` | `923191abb694f2f2e14a5e83db37d0b526f9cc2f` |
| `Z:\project\VMe` | `local_main` 工作副本 | `93ce0589fb504722231c0b3deba01eea6b165e26` 加未提交修改 |

两个远程均实际完成 mirror clone，并通过 `git fsck --connectivity-only`。提交 SHA 与本地保存的对应 remote refs 一致，树比较不是仅依据旧缓存。

## 为什么这样合并

1. 内网 `main` 是 `local_main` 的祖先，内网 `plugin` 是 `local_plugin` 的祖先。较旧分支里被后续删除或升级的代码不做机械复活。
2. GitHub 和内网有清理历史造成的提交图差异；主分支代码树只相差三份 `~` 前缀临时 DLL，没有需要从 GitHub 另外移植的业务代码。采用本地工作副本，保留其未提交变化。
3. GitHub `plugin` 与内网 `local_plugin` 相比，后者新增京东/淘宝 Python 服务和 Godot 适配层；共有文件的唯一文本修改只是 `free_ai_adapter` 删除两行空白。其余差异是赞助文件及图标链接类型。因此采用 `local_plugin` 的全部三个插件源码目录，共 806 个文件。
4. 本地被忽略的 `plugin/`、`external_service_adapter/`、`external_service/` 只有空目录与 `.gitkeep`，没有漏掉的本地插件源码。源码由远程插件分支补齐。
5. 本地 28 个已跟踪文件修改全部保留：京东/淘宝启动测试、Godot 4.4 配置、UID/导入参数等变化。另保留 186 个未跟踪 UID 和本地 PSD 资源。编辑器重存导致的定制主题属性丢失疑点只记录，不擅自还原或判定正确。
6. GitHub tools 分支的 Python 工具及 protobuf 定义保存在 `tools/legacy/`。旧引擎 EXE、Spout DLL 留在外部镜像中，没有把过时运行工具塞入新源码根目录。

## 本次主动修改

- `.gitignore`：不再忽略三个插件源码目录与 `export_presets.cfg`，增加缓存、编译产物和 `.env` 的排除规则，防止新仓库再次漏掉源码。
- `external_service/music_adapter/v1_0_1/api/musicdl/musicdlapi/musicdl.py`：历史百度语音默认配置改读环境变量。
- `external_service/music_adapter/v1_0_1/api/musicdl/musicdlapi/modules/sources/qianqian.py`：历史请求签名 secret 改读环境变量。
- 新增恢复说明和逐文件来源清单。没有重构业务、升级依赖或更改 Godot 脚本逻辑。

原主程序 LGPL-3.0 LICENSE 原样保留。插件分支根目录原有 MIT 声明另存为 `PLUGIN_BRANCH_LICENSE`，第三方插件内部许可均保留；不能据此把全部项目重新声明成单一 MIT 项目。

## 验证及未通过运行验收的事项

- 复制后逐文件 SHA-256 与选定来源核对；只有上面明确列出的三个已有文件主动改变。交付后再次核对全部文件。
- 本地选取文件在整理过程中哈希未变化；没有对旧仓库执行 checkout、reset、stash、提交或 push。
- 806 个插件文件完整纳入。Python 共 124 个文件通过当前 Python 的静态编译检查，不执行模块、不生成 pyc。
- 凭据调整的 6 项局部检查通过：语音环境变量读取、显式参数兼容、缺失配置失败，以及签名两种路径和缺失配置失败；未发起网络请求。交付文件内不再出现识别出的 4 个原始硬编码值。
- 没有单个文件超过 GitHub 常规 100 MiB 上限；尚未推送，不能将此作为远程推送成功证明。
- 静态资源扫描发现原有缺口：25 个可选平台/精度的原生库声明没有对应文件；8 个旧服务模板仍引用已淘汰的 `free_ai_adapter/v1_0_0` 设置脚本；`file_list` 的一个序列化设置仍含旧版图标路径。这些没有通过引擎验证，也没有为凑齐资源而伪造文件。
- Python `.spec` 中存在旧绝对路径，至少一处 `VMe_Plugin/.../v1_0_0/free_ai` 已不存在；缺少 requirements/锁文件。相关服务、平台后端、模型缓存和定制引擎源码并未由这些来源完整提供。
- 没有运行 Godot 编辑器/应用、没有完成打包、没有验证历史外部接口存活。资源已恢复与业务可运行是两件事。

## 外部保全位置

`C:\Users\Public\nas_home\AI\GameEditor\linshi\mot-recovery-20261006`

包括 `mimi.git`、`vme-server.git` 两份完整远程镜像、`local-working-tree.patch`、本地状态、历史编辑器快照、分支导出 tar、来源清单、排除清单及验证结果。这里包含未脱敏历史代码，只用于本地追溯，不应发布。参考镜像 `*-verified.git` 依赖本地对象目录；保全以独立的上述两份完整 mirror 为准。

原始 `Z:\project\VMe` 和两处远程都没有修改。最终目录不带旧 Git 元数据，也没有创建或绑定新的 GitHub 仓库。
