#!/bin/bash

if [ -z ${ROOT} ]; then
	ROOT=`cd .. && pwd`
fi
UBOOT=${ROOT}/uboot
TOOL=${ROOT}/toolchain/bin/arm-linux-gnueabi-
OUTPUT=${ROOT}/output

clear
#make -C ${UBOOT} CROSS_COMPILE=${TOOL} clean 
echo -e "\e[1;31m Configure OrangePi 2G-IOT or i96 \e[0m"
make -s -C ${UBOOT} CROSS_COMPILE=${TOOL} clean 
make -s -C ${UBOOT} CROSS_COMPILE=${TOOL} rda8810_config
echo -e "\e[1;31m Compiling Uboot \e[0m"
make -s -C ${UBOOT} CROSS_COMPILE=${TOOL} pdl=1 PDL 
cp -rf ${UBOOT}/pdl*.bin ${ROOT}/output

# Wirte command
# sudo dd bs=512 seek=256 if=${ROOT}/output/u-boot.rda of=/dev/sdx

whiptail --title "OrangePi Build System" \
	--msgbox "Comiple finish! uboot pdl1.bin and pdl2.bin path: ${ROOT}/output/" \
			        12 60 0 --ok-button Continue
