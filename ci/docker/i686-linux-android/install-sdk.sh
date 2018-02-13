#!/bin/sh
# Copyright 2016 The Rust Project Developers. See the COPYRIGHT
# file at the top-level directory of this distribution and at
# http://rust-lang.org/COPYRIGHT.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

set -ex

# Prep the SDK and emulator
#
# Note that the update process requires that we accept a bunch of licenses, and
# we can't just pipe `yes` into it for some reason, so we take the same strategy
# located in https://github.com/appunite/docker by just wrapping it in a script
# which apparently magically accepts the licenses.


mkdir sdk
curl https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | \
    tar xzf - -C sdk --strip-components=1

filter="platform-tools,android-21"
filter="$filter,sys-img-x86-android-21"

./accept-licenses.sh "android - update sdk -a --no-ui --filter $filter --no-https"

echo "no" | android create avd \
                --name x86-21 \
                --target android-21 \
                --abi x86

# mkdir sdk

# curl -o sdk-tools-linux-3859397.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
#     unzip sdk-tools-linux-3859397.zip && \
#     mv tools sdk/



# yes | sdkmanager --licenses --no_https
# sdkmanager tools platform-tools "build-tools;25.0.2" "platforms;android-21" "system-images;android-21;default;x86" --no_https

# echo "no" | avdmanager create avd \
#                 --force \
#                 --name x86-21 \
#                 --package "system-images;android-21;default;x86" \
#                 --abi x86 \
# --sdcard 256M
