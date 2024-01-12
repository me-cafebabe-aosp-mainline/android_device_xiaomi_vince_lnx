#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common
include device/qcom/mainline-common/BoardConfigCommon.mk

USES_DEVICE_XIAOMI_VINCE_LNX := true
DEVICE_PATH := device/xiaomi/vince_lnx

# Architecture
include device/generic/shared/board_config/arch/arm64.mk
#TARGET_CPU_VARIANT := cortex-a53
#TARGET_2ND_CPU_VARIANT := cortex-a53

# Bootconfig
BOARD_BOOTCONFIG += \
    androidboot.boot_devices=soc@0/7824900.mmc \
    androidboot.selinux=permissive

# Kernel
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000 --tags_offset 0x00000100

BOARD_KERNEL_CMDLINE += \
    bootconfig

#BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(shell find device/xiaomi/vince_lnx-kernel/modules/ -name "*.ko")

# Partitions
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_BLOCK_DEVICES := cust oem system
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_CUST_DEVICE_SIZE := 872415232
BOARD_SUPER_PARTITION_OEM_DEVICE_SIZE := 268435456
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 3221225472
BOARD_SUPER_PARTITION_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_CUST_DEVICE_SIZE) + $(BOARD_SUPER_PARTITION_OEM_DEVICE_SIZE) + $(BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE) )
BOARD_USES_METADATA_PARTITION := true

DLKM_PARTITIONS := system_dlkm vendor_dlkm
SSI_PARTITIONS := product system system_ext
TREBLE_PARTITIONS := odm vendor
ALL_PARTITIONS := $(DLKM_PARTITIONS) $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

BOARD_SUPER_PARTITION_GROUPS := vince_dynamic_partitions
BOARD_VINCE_DYNAMIC_PARTITIONS_PARTITION_LIST := $(ALL_PARTITIONS)
BOARD_VINCE_DYNAMIC_PARTITIONS_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) - 4194304 )

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

include device/generic/shared/board_config/dynamic_partitions/inode_count.mk
include device/generic/shared/board_config/dynamic_partitions/reserved_size/small.mk

# Platform
TARGET_BOARD_PLATFORM := msm8953

# Ramdisk
BOARD_COMBINE_RAMDISK_IMAGES := true

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/configs/fstab/fstab.qcom

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor
