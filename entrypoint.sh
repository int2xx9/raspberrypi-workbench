#!/bin/sh

echo "Cloning repositories..."
[ ! -d /work/firmware ] && git clone -b stable --depth=1 https://github.com/raspberrypi/firmware
[ ! -d /work/linux ] && git clone https://github.com/raspberrypi/linux
[ ! -d /work/tools ] && git clone https://github.com/raspberrypi/tools

[ $# -eq 0 ] && exec bash
exec "$@"

