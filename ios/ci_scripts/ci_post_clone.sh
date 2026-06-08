#!/bin/bash
set -e

echo "--- Installing Node.js ---"
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE
brew install node

echo "--- Installing CocoaPods ---"
brew install cocoapods

echo "--- Installing npm dependencies ---"
cd "$CI_PRIMARY_REPOSITORY_PATH"
npm install

echo "--- Running Expo Prebuild ---"
# Override CI env var: Xcode Cloud sets CI='TRUE' (uppercase) which breaks expo's boolean parsing
CI="true" npx expo prebuild --platform ios

echo "--- Installing CocoaPods dependencies ---"
cd ios
pod install
