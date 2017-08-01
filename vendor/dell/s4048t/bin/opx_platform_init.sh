#!/bin/bash
# Copyright (c) 2015 Dell Inc.
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

# Register and initializes PCA954x mux
echo pca9548 0x70 > /sys/bus/i2c/devices/i2c-0/new_device

#SMBus Controller 2.0 SPGT register to 0x00000005 to tune 80KHz frequency
/usr/bin/pcisysfs.py --set --val 0x00000005 --offset 0x300 --res "/sys/devices/pci0000:00/0000:00:13.0/resource0"

# Now create a file to hold the firmware versions.
FIRMWARE_VERSION_FILE=/var/log/firmware_versions
rm -rf ${FIRMWARE_VERSION_FILE}
echo "BIOS: `dmidecode -s system-version `" > $FIRMWARE_VERSION_FILE
for f in /sys/bus/i2c/devices/*; do
    if [ "`cat $f/name`" = 'i2c-0-mux (chan_id 0)' ]; then
        b=`basename $f | sed 's/i2c-//'`
        # Get System CPLD version
        echo "System CPLD: $((`i2cget -y $b 0x31 8` & 0xf))" >> $FIRMWARE_VERSION_FILE
        # Get Master CPLD version
        echo "Master CPLD: $((`i2cget -y $b 0x32 0x12` & 0xf))" >> $FIRMWARE_VERSION_FILE
        break
    fi
done
