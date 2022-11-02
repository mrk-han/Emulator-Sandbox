#!/usr/bin/env bash
set -euxo pipefail

adb logcat -c
adb logcat *:E &
./gradlew app:connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.training.thrive.vet."$SINGLE_TEST_TO_RUN"