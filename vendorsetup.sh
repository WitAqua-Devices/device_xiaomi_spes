#!/bin/bash

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
END="\033[0m"

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${YELLOW}• $1 already exists. Skipping cloning...${END}"
        return 1
    fi
    return 0
}

echo -e "${YELLOW}Applying patches and cloning device source...${END}"

echo -e "${GREEN}• Removing conflicting Pixel headers from hardware/google/pixel/kernel_headers/Android.bp...${END}"
rm -rf hardware/google/pixel/kernel_headers/Android.bp

echo -e "${GREEN}• Removing conflicting LineageOS compat module from hardware/lineage/compat/Android.bp...${END}"
rm -rf hardware/lineage/compat/Android.bp

if [ -f device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/legacy-ims/hal_rcsservice.te ]; then
    echo -e "${GREEN}Switching back to legacy imsrcsd sepolicy...${END}"
    rm -rf device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/ims/imsservice.te
    cp device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/legacy-ims/hal_rcsservice.te device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/ims/hal_rcsservice.te
else
    echo -e "${YELLOW}• Please check your ROM source; the file for legacy imsrcsd sepolicy does not exist. Skipping this step...${END}"
fi

echo -e "${YELLOW}All patches have been successfully applied; your device sources are now ready!${END}"
