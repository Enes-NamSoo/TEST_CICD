

#!/bin/sh
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
echo "🟢${CONFIGURATION}🟢"

echo "🟢${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}🟢"
echo "🟢${CI_DERIVED_DATA_PATH}/Build/Intermediates.noindex/ArchiveIntermediates/test_CICD/BuildProductsPath/Release-iphoneos/${DWARF_DSYM_FILE_NAME}🟢"

set -e

if [[ -n $CI_ARCHIVE_PATH ]]; then
    echo "upload dSYMs..."
    if [ -d ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME} ] then
        "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
        "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/test_CICD/GoogleService-Info.plist" -p ios "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
    else
        echo "dSYMs is not found"
    fi
else
    echo "firebase crashlytics debug run..."
    "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
    "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/test_CICD/GoogleService-Info.plist" -p ios "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
fi

echo "finish crashlytics run"
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
