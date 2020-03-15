#!/bin/bash

# Clone
git clone https://github.com/flutter/samples.git --depth 1; cd samples/animations || exit

# Test
flutter test

# Build
# $1: debug,release
flutter build apk --target-platform android-arm64 --"$1"

# Deploy
#
# Debug: build/app/outputs/apk/debug/app-debug.apk
# Release: build/app/outputs/apk/release/app-release.apk
