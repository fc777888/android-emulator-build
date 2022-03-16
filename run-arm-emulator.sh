#!/usr/bin/env bash
set -e
# https://developer.android.google.cn/studio/releases/emulator?hl=zh-cn
# https://github.com/google/android-emulator-container-scripts/issues/192

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update && sudo apt-get install build-essential lld git ninja-build tree gpg gpg-agent flex bison python python3 libpython3-dev python3-pip curl wget libgl1 libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev libgl1-mesa-glx libx11-dev freeglut3-dev locales qemu-kvm ccache lz4 libc6 adb unzip xcb libpcre2-16-0 cpu-checker tzdata crossbuild-essential-arm64 g++-aarch64-linux-gnu gcc-aarch64-linux-gnu -y

mkdir -p ~/.bin
PATH="${HOME}/.bin:${PATH}"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo

MYDIR=$(pwd)

wget https://github.com/fc777888/llvm-build/releases/download/latest/sdk-repo-linux_aarch64-emulator-8293352.zip

unzip sdk-repo-linux_aarch64-emulator-8293352.zip

emulator/emulator --version

emulator/emulator @Pixel2 -verbose -gpu swiftshader_indirect -grpc 8554 -skip-adb-auth -shell-serial file:1.txt -qemu -cpu max -machine gic-version=max

set +e

echo Build emu done.
