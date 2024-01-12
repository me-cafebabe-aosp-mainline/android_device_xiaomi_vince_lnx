DEVICE_IS_64BIT_ONLY := false
include device/generic/shared/product_type/generic_handheld_telephony.mk

$(call inherit-product, device/xiaomi/vince_lnx/device.mk)

PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

PRODUCT_NAME := aosp_vince_lnx
PRODUCT_DEVICE := vince_lnx
PRODUCT_BRAND := Xiaomi
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := Redmi 5 Plus
