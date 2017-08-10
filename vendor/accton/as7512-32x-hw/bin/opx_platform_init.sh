#!/bin/bash
# Copyright (c) 2017 Cavium Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# THIS CODE IS PROVIDED ON AN  *AS IS* BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT
# LIMITATION ANY IMPLIED WARRANTIES OR CONDITIONS OF TITLE, FITNESS
# FOR A PARTICULAR PURPOSE, MERCHANTABLITY OR NON-INFRINGEMENT.
#
# See the Apache Version 2.0 License for specific language governing
# permissions and limitations under the License.

. /etc/opx/opx-environment.sh

i2c_bus=0
for f in /sys/bus/i2c/devices/*; do
    if [ "`cat $f/name`" = 'SMBus iSMT adapter at ffff84000' ]; then
        i2c_bus=`basename $f | sed 's/i2c-//'`
        break
    fi
done

exit 0

if [ $i2c_bus -eq 0 ]; then
    echo pca9548 0x76 > /sys/bus/i2c/devices/i2c-1/new_device
    echo pca9548 0x71 > /sys/bus/i2c/devices/i2c-0/new_device
    echo pca9548 0x72 > /sys/bus/i2c/devices/i2c-0/new_device
    echo pca9548 0x73 > /sys/bus/i2c/devices/i2c-0/new_device
    echo pca9548 0x74 > /sys/bus/i2c/devices/i2c-0/new_device
    echo pca9548 0x75 > /sys/bus/i2c/devices/i2c-0/new_device

#    echo as7512_32x_fan 0x66 > /sys/bus/i2c/devices/i2c-2/new_device
#    echo lm75 0x48 > /sys/bus/i2c/devices/i2c-3/new_device
#    echo lm75 0x49 > /sys/bus/i2c/devices/i2c-3/new_device
#    echo lm75 0x4a > /sys/bus/i2c/devices/i2c-3/new_device
#    echo max6657 0x4c > /sys/bus/i2c/devices/i2c-15/new_device
#    echo as7512_32x_psu 0x53 > /sys/bus/i2c/devices/i2c-11/new_device
#    echo ym2651 0x5b > /sys/bus/i2c/devices/i2c-11/new_device
#    echo as7512_32x_psu 0x50 > /sys/bus/i2c/devices/i2c-10/new_device
#    echo ym2651 0x58 > /sys/bus/i2c/devices/i2c-10/new_device
#    echo accton_i2c_cpld 0x60 > /sys/bus/i2c/devices/i2c-1/new_device
#    echo accton_i2c_cpld 0x62 > /sys/bus/i2c/devices/i2c-1/new_device
#    echo accton_i2c_cpld 0x64 > /sys/bus/i2c/devices/i2c-1/new_device
else
    echo pca9548 0x76 > /sys/bus/i2c/devices/i2c-0/new_device
    echo pca9548 0x71 > /sys/bus/i2c/devices/i2c-1/new_device
    echo pca9548 0x72 > /sys/bus/i2c/devices/i2c-1/new_device
    echo pca9548 0x73 > /sys/bus/i2c/devices/i2c-1/new_device
    echo pca9548 0x74 > /sys/bus/i2c/devices/i2c-1/new_device
    echo pca9548 0x75 > /sys/bus/i2c/devices/i2c-1/new_device

#    echo as7512_32x_fan 0x66 > /sys/bus/i2c/devices/i2c-2/new_device
#    echo lm75 0x48 > /sys/bus/i2c/devices/i2c-3/new_device
#    echo lm75 0x49 > /sys/bus/i2c/devices/i2c-3/new_device
#    echo lm75 0x4a > /sys/bus/i2c/devices/i2c-3/new_device
#    echo max6657 0x4c > /sys/bus/i2c/devices/i2c-15/new_device
#    echo as7512_32x_psu 0x53 > /sys/bus/i2c/devices/i2c-11/new_device
#    echo ym2651 0x5b > /sys/bus/i2c/devices/i2c-11/new_device
#    echo as7512_32x_psu 0x50 > /sys/bus/i2c/devices/i2c-10/new_device
#    echo ym2651 0x58 > /sys/bus/i2c/devices/i2c-10/new_device
#    echo accton_i2c_cpld 0x60 > /sys/bus/i2c/devices/i2c-0/new_device
#    echo accton_i2c_cpld 0x62 > /sys/bus/i2c/devices/i2c-0/new_device
#    echo accton_i2c_cpld 0x64 > /sys/bus/i2c/devices/i2c-0/new_device
fi

# Now create a file to hold the firmware versions.
FIRMWARE_VERSION_FILE=/var/log/firmware_versions
rm -rf ${FIRMWARE_VERSION_FILE}
# Get product name
echo "PRODUCT: `dmidecode -s system-product-name `" > $FIRMWARE_VERSION_FILE
# Get BIOS version
echo "BIOS: `dmidecode -s system-version `" > $FIRMWARE_VERSION_FILE
