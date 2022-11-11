

#!/bin/sh
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"

if [ "${CONFIGURATION}" == "Release" ]; then
echo "🟢release!!!!"
else
echo "🟢debug!!!!" "${CONFIGURATION}"
fi


#set -e // 오류발생시 종료하는 옵션
if [[ -n $CI_ARCHIVE_PATH ]]; then
echo "Found valid archive path, trying to upload dSYMs."

    "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
    "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/test_CICD/GoogleService-Info.plist" -p ios "${CI_ARCHIVE_PATH}/dSYMs"
else
    echo "firebase crashlytics debug run..."
    "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
    "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/test_CICD/GoogleService-Info.plist" -p ios "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
fi

echo "finish crashlytics run"
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
