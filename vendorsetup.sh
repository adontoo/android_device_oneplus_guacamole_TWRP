#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="guacamole"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export LC_ALL="C"
 	export ALLOW_MISSING_DEPENDENCIES=true
	export OF_USE_GREEN_LED=1
	
	# "guacamole" Specific
	export FOX_AB_DEVICE=1
	export TARGET_DEVICE_ALT="guacamoleb,guacamolec,OnePlus7Pro,OnePlus7ProNR"
	export FOX_TARGET_DEVICES="guacamole,guacamoleb,guacamolec,OnePlus7Pro,OnePlus7ProNR"
	export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_TWRP_COMPATIBILITY_MODE=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export OF_NO_MIUI_PATCH_WARNING=1
	export OF_FBE_METADATA_MOUNT_IGNORE=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
 	export FOX_USE_LZ4_BINARY=1
  	export FOX_USE_ZSTD_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
	export OF_QUICK_BACKUP_LIST="/boot;/data;"
	export OF_PATCH_AVB20=1
	export FOX_DELETE_AROMAFM=1
	export FOX_ENABLE_APP_MANAGER=1
	export FOX_USE_SPECIFIC_MAGISK_ZIP=/tmp/misc/Magisk-v27.0.zip

	# OTA
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
    
   	 # R12.1 Settings
	export FOX_VERSION="R12.1"
	export OF_MAINTAINER="Adontoo"
	export OF_MAINTAINER_AVATAR="/tmp/misc/Adontoo.jpg"
	export OF_MAGISK="/tmp/misc/Magisk-v27.0.zip"
	export FOX_BUILD_TYPE="Stable-Unofficial"

	# Screen Settings
	export OF_SCREEN_H=2340
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
	export OF_ALLOW_DISABLE_NAVBAR=0

	# Avatar Settings
    if [ -n "$OF_MAINTAINER_AVATAR" ]; then
        if [ ! -f "$OF_MAINTAINER_AVATAR" ]; then
              # some colour codes
              RED='\033[0;31m'
              GREEN='\033[0;32m'
              ORANGE='\033[0;33m'
              BLUE='\033[0;34m'
              PURPLE='\033[0;35m'
              echo -e "${RED}-- File \"$OF_MAINTAINER_AVATAR\" not found  ...${NC}"
              echo -e "${ORANGE}-- Downloading...${NC}"
              mkdir -p /tmp/misc
              curl https://github.com/adontoo/pixelos_manifest/blob/icon/snippets/icon.jpg >> $OF_MAINTAINER_AVATAR
              echo -e "${BLUE}-- Successfully Downloaded the Avatar Image \"$OF_MAINTAINER_AVATAR\" ...${NC}"
              echo -e "${PURPLE}-- Using A Custom Maintainer Avatar from the Downloaded Image \"$OF_MAINTAINER_AVATAR\" ...${NC}"
              echo -e "${GREEN}-- Done!"
        fi
    fi
    
    	# Check if Magisk.zip exist。
    if [ -n "$FOX_USE_SPECIFIC_MAGISK_ZIP" ]; then
    	if [ ! -f "$OF_MAGISK" ]; then
              # some colour codes
              RED='\033[0;31m'
              GREEN='\033[0;32m'
              ORANGE='\033[0;33m'
              BLUE='\033[0;34m'
              PURPLE='\033[0;35m'
              echo -e "${RED}-- File \"$OF_MAGISK\" not found  ...${NC}"
              echo -e "${ORANGE}-- Downloading...${NC}"
              wget -O /tmp/misc/Magisk-v27.0.zip https://github.com/topjohnwu/Magisk/releases/download/v27.0/Magisk-v27.0.apk
              echo -e "${BLUE}-- Successfully Downloaded the Magisk.zip File \"$OF_MAGISK\" ...${NC}"
              echo -e "${PURPLE}-- Using A Custom Magisk.zip from the Downloaded file \"$OF_MAGISK\" ...${NC}"
              echo -e "${GREEN}-- Done!"
     	fi
    fi

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
#
 
