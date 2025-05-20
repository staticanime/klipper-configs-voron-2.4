#!/bin/bash
cd ~/klipper

echo -e -n "\e[0;31mStopping Klipper Service. "
echo -e -n '\e[0;0m'

sudo systemctl stop klipper
sudo systemctl status klipper

################################################################################

#git pull

################################################################################

# Flash main MCU - BTT Manta M8P
make clean KCONFIG_CONFIG=klipper-btt-manta-m8p-v2.0.config
make menuconfig KCONFIG_CONFIG=klipper-btt-manta-m8p-v2.0.config
make -j 4 KCONFIG_CONFIG=klipper-btt-manta-m8p-v2.0.config

echo -e -n "\e[0;33mBTT Manta M8P MCU firmware built, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

if test -e /dev/serial/by-id/usb-Klipper_stm32h723xx_300034000F51313236343430-if00; then
  make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32h723xx_300034000F51313236343430-if00 KCONFIG_CONFIG=klipper-btt-manta-m8p-v2.0.config
fi
sleep 5
if test -e /dev/serial/by-id/usb-katapult_stm32h723xx_300034000F51313236343430-if00; then
  make flash FLASH_DEVICE=/dev/serial/by-id/usb-katapult_stm32h723xx_300034000F51313236343430-if00 KCONFIG_CONFIG=klipper-btt-manta-m8p-v2.0.config
fi

echo -e -n "\e[0;33mBTT Manta M8P MCU firmware flashed, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

################################################################################

# Flash secondary MCU - Mellow SB2040 Pro
make clean KCONFIG_CONFIG=klipper-mellow-sb2040-pro-v3.config
make menuconfig KCONFIG_CONFIG=klipper-mellow-sb2040-pro-v3.config
make -j 4 KCONFIG_CONFIG=klipper-mellow-sb2040-pro-v3.config

echo -e -n "\e[0;33mMellow SB2040 Pro V3 MCU firmware built, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

python3 ~/katapult/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 606d62131587

echo -e -n "\e[0;33mMellow SB2040 Pro V3 MCU firmware flashed, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

################################################################################

# Flash Host MCU - Raspberry Pi
make clean KCONFIG_CONFIG=klipper-raspberry-pi.config
make menuconfig KCONFIG_CONFIG=klipper-raspberry-pi.config
make -j 4 KCONFIG_CONFIG=klipper-raspberry-pi.config

echo -e -n "\e[0;33mRaspberry Pi MCU firmware flashed, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

make flash KCONFIG_CONFIG=klipper-raspberry-pi.config

echo -e -n "\e[0;33mRaspberry Pi MCU firmware flashed, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

################################################################################

echo -e -n "\e[0;32mStarting Klipper Service."
echo -e -n '\e[0;0m'
sudo systemctl start klipper
sudo systemctl status klipper

exit 0
