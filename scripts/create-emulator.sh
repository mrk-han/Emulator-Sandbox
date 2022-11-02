#!/usr/bin/env bash
set -euxo pipefail

# Install AVD files
echo "y" | /Users/runner/Library/Android/sdk/cmdline-tools/latest/bin/sdkmanager --install "system-images;android-30;google_atd;x86"
echo "y" | /Users/runner/Library/Android/sdk/cmdline-tools/latest/bin/sdkmanager --licenses

# Create emulator
/Users/runner/Library/Android/sdk/cmdline-tools/latest/bin/avdmanager --verbose create avd --force --name "ui-test-emulator" --package "system-images;android-30;google_atd;x86" --tag "google_atd" --abi "x86" --device "Nexus One"
/Users/runner/Library/Android/sdk/emulator/emulator -list-avds
/Users/runner/Library/Android/sdk/emulator/emulator -accel-check 2>&1 | tee "$GITHUB_WORKSPACE"/haxm-check-"$GITHUB_RUN_NUMBER".txt
if false; then
emulator_config=~/.android/avd/ui-test-emulator.avd/config.ini
cat "$emulator_config" || :
# The following madness is to support empty OR populated config.ini files,
# the state of which is dependant on the version of the emulator used (which we don't control),
# so let's be defensive to be safe.
# Replace existing config (NOTE we're on MacOS so sed works differently!)
sed -i .bak 's/hw.lcd.density=.*/hw.lcd.density=420/' "$emulator_config"
sed -i .bak 's/hw.lcd.height=.*/hw.lcd.height=1920/' "$emulator_config"
sed -i .bak 's/hw.lcd.width=.*/hw.lcd.width=1080/' "$emulator_config"
# Or, add new config
if ! grep -q "hw.lcd.density" "$emulator_config"; then
  echo "hw.lcd.density=420" >> "$emulator_config"
fi
if ! grep -q "hw.lcd.height" "$emulator_config"; then
  echo "hw.lcd.height=1920" >> "$emulator_config"
fi
if ! grep -q "hw.lcd.width" "$emulator_config"; then
  echo "hw.lcd.width=1080" >> "$emulator_config"
fi
echo "Emulator settings ($emulator_config)"
cat "$emulator_config"
fi