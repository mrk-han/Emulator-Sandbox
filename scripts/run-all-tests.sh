#!/usr/bin/env bash
set -euxo pipefail

adb logcat -c
adb logcat *:E &
./gradlew connectedDebugAndroidTest