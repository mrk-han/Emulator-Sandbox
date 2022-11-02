#!/usr/bin/env bash
set -euxo pipefail

ffmpeg -f avfoundation -i 0 -t 480 "$GITHUB_WORKSPACE"-"$GITHUB_RUN_NUMBER"-movie.mov