sudo service klipper stop
cd ~/klipper
git pull

make clean KCONFIG_CONFIG=config.btt
make menuconfig KCONFIG_CONFIG=config.btt
make KCONFIG_CONFIG=config.btt
read -p "BTT Octopus MCU firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32f446xx_380033000A51373330333137-if00 KCONFIG_CONFIG=config.btt
read -p "BTT Octopus MCU firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make KCONFIG_CONFIG=config.rpi
read -p "Raspberry Pi MCU firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash KCONFIG_CONFIG=config.rpi
read -p "Raspberry Pi MCU firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

sudo service klipper start