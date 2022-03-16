#!/usr/bin/env bash
set -e
# https://developer.android.google.cn/studio/releases/emulator?hl=zh-cn

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update && sudo apt-get install build-essential lld git ninja-build tree gpg gpg-agent flex bison python python3 libpython3-dev python3-pip curl wget libgl1 libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev libgl1-mesa-glx libx11-dev freeglut3-dev locales qemu-kvm ccache lz4 libc6 adb unzip xcb libpcre2-16-0 cpu-checker tzdata crossbuild-essential-arm64 g++-aarch64-linux-gnu gcc-aarch64-linux-gnu -y

sudo localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
sudo locale-gen en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

mkdir -p ~/.bin
PATH="${HOME}/.bin:${PATH}"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo

MYDIR=$(pwd)

mkdir emu
cd emu
repo init -u https://android.googlesource.com/platform/manifest -b emu-master-dev --depth=1
repo sync -qcj 12
cd external/qemu
pip install absl-py
pip install urlfetch
python android/build/python/cmake.py --noqtwebengine --noshowprefixforinfo

set +e

echo Build emu done.
