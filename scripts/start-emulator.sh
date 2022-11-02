#!/usr/bin/env bash
set -euxo pipefail

echo "Starting emulator and waiting for boot to complete..."

nohup /Users/runner/Library/Android/sdk/emulator/emulator -avd ui-test-emulator -gpu swiftshader_indirect -no-audio -screen no-touch -no-boot-anim -camera-back none -camera-front none -partition-size 2048 -no-snapshot-save -qemu -m 2048 2>&1 &

"$ANDROID_HOME"/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'
echo "Emulator has finished booting"

#"$ANDROID_HOME"/platform-tools/adb shell 'su;setprop debug.hwui.renderer skiagl;stop;start'

"$ANDROID_HOME"/platform-tools/adb devices

# Take screenshots to verify
screencapture screenshot-of-emulator-1.jpg
"$ANDROID_HOME"/platform-tools/adb exec-out screencap -p > screenshot-of-emulator-2.png