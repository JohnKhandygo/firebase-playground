#!/usr/bin/env bash

VERSION='3.22.3'

BASE_DIR=$1

# see https://docs.flutter.dev/get-started/install/linux/web
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
curl "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$VERSION-stable.tar.xz" -o "/tmp/flutter_linux-stable.tar.xz"
tar -xf /tmp/flutter_linux-stable.tar.xz -C $BASE_DIR
