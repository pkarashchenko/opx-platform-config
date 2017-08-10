#!/bin/sh

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
#

# Platform specific script to trigger reset/shdutdown of all hw components
# in addition to the CPU.

i2c_bus=0
for f in /sys/bus/i2c/devices/*; do
    if [ "`cat $f/name`" = 'SMBus iSMT adapter at ffff84000' ]; then
        i2c_bus=`basename $f | sed 's/i2c-//'`
        break
    fi
done

function platform_reset {
    echo 'Platform RESET'
}

function platform_poweroff {
    echo 'Platform POWEROFF'
}

case "$1" in
    "poweroff")
        platform_poweroff
        ;;
    "reboot")
        platform_reset
        ;;
esac
