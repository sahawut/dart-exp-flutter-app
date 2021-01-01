#!/usr/bin/env bash

. android/bin/export

cd $ANDROID_HOME/emulator
emulator -avd test_avd_29 &