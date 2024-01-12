PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/aosp_vince_lnx.mk \

$(foreach build_type, user userdebug eng, \
    $(eval COMMON_LUNCH_CHOICES += aosp_vince_lnx-$(build_type)))
