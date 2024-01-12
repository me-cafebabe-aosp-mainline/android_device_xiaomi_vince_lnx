#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Initialize variables
DEVICE_MANIFEST_FILE :=

# Inherit from common
$(call inherit-product, device/qcom/mainline-common/device-common.mk)

# AAPT
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Dalvik heap
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Firmware
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/firmware/,$(TARGET_COPY_OUT_VENDOR)/firmware/)

# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/fstab/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(LOCAL_PATH)/configs/init/init.device.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.device.usb.rc

# Images
PRODUCT_BUILD_VENDOR_RAMDISK_IMAGE := true

# Kernel
PRODUCT_COPY_FILES += \
    device/xiaomi/vince_lnx-kernel/kernel:kernel

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Properties
include $(LOCAL_PATH)/properties.mk

# Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/fstab/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/init/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# VINTF
DEVICE_MANIFEST_FILE += \
    $(LOCAL_PATH)/configs/vintf/manifest.xml
