#!/bin/bash
# CI 环境导入 iOS 签名证书与描述文件
set -euo pipefail
cd "$(dirname "$0")/.."

CERT_P12="证书/7MTTK_证书文件（密码1）.p12"
CERT_PASS="1"
PROFILE_FILE="证书/7MTTK_描述文件.mobileprovision"
PROFILE_UUID="c5d1159d-6eb0-4b5c-9ce6-d699d9eb4ffa"
KC_NAME="bbj-build.keychain"
KC_PASS="bbj-ci-2026"

# 临时钥匙串
security create-keychain -p "$KC_PASS" "$KC_NAME" 2>/dev/null || true
security import "$CERT_P12" -k "$KC_NAME" -P "$CERT_PASS" -T /usr/bin/codesign -T /usr/bin/security
security set-key-partition-list -S apple-tool:,apple: -s -k "$KC_PASS" "$KC_NAME" >/dev/null
OLD_KEYCHAINS=$(security list-keychains -d user | tr -d '"')
security list-keychains -d user -s "$KC_NAME" $OLD_KEYCHAINS
security set-keychain-settings -t 3600 "$KC_NAME"

# 安装描述文件（新旧两个目录都放，兼容 Xcode 版本差异）
mkdir -p "$HOME/Library/MobileDevice/Provisioning Profiles" "$HOME/Library/Developer/Xcode/UserData/Provisioning Profiles"
cp "$PROFILE_FILE" "$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_UUID.mobileprovision"
cp "$PROFILE_FILE" "$HOME/Library/Developer/Xcode/UserData/Provisioning Profiles/$PROFILE_UUID.mobileprovision"

echo "签名材料已就绪"
