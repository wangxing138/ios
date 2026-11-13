# 宝宝剑 iOS 云打包仓库

把本文件夹全部内容上传到 GitHub 私有仓库，Actions 会自动在云端 Mac 上打出 `宝宝剑-1.0.3.ipa`（Ad-Hoc 签名，绑定 UDID 尾号 79801E 的 iPhone）。

## 操作步骤（网页上完成，不需要装任何软件）

1. 登录 [github.com](https://github.com) → 右上角 `+` → `New repository`
   - 名称随意（如 `baobaojian-ios`），选 **Private**，其余都不勾，点 `Create repository`
2. 在新仓库页面点 **uploading an existing file** 链接
3. 把本文件夹里的这些内容**全部拖进上传区**（支持直接拖文件夹）：
   - `.github` 文件夹
   - `ios` 文件夹
   - `证书` 文件夹
   - `ci` 文件夹
   - `package.json`、`package-lock.json`
4. 拖完点 `Commit changes` —— 上传完成后 Actions 会**自动开始编译**（也可到 `Actions` 标签页手动点 `Run workflow`）
5. 等 10~20 分钟，出现绿勾后点进去，页面底部 **Artifacts** 下载 `baobaojian-ipa-1.0.3`，解压得到 ipa

## 安装到 iPhone

用爱思助手 / AltStore / Xcode 把 ipa 装进那台注册过的 iPhone（UDID 尾号 79801E），首次在「设置→通用→VPN与设备管理」信任「james peters (7PDQ3UCV44)」。

## 红线提醒

- 仓库必须保持 **Private** —— 里面有你的 iOS 签名证书私钥。
- 拿到 ipa 后，建议到仓库 `Settings → Danger Zone → Delete this repository` 删掉；证书文件也请妥善保管，勿外传。
- 失败排查：进入失败的 run 看红叉步骤日志；最常见是证书导入（重跑即可）或 pod 安装网络抖动（Re-run all jobs）。

## 签名信息速查

| 项 | 值 |
| --- | --- |
| 包名 | app.quinoa5315.wave4636 |
| 团队 | 7PDQ3UCV44（james peters） |
| 描述文件 | 00008110-00010D640E79801EUXZK30（Ad-Hoc，1 台设备） |
| p12 密码 | 1 |
| 有效期 | 描述文件/证书均至 2027-11 |
