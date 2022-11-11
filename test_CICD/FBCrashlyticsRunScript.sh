

#!/bin/sh
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
#set -e // 오류발생시 종료하는 옵션
if [[ -n $CI_ARCHIVE_PATH ]];
then
echo "Found valid archive path, trying to upload dSYMs."

if [ "${CONFIGURATION}" == "Release" ]; then
echo "firebase crashlytics Release run..."
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/GoogleService-Info.plist" -p ios "$CI_ARCHIVE_PATH/dSYMs"

elif [ "${CONFIGURATION}" == "Inhouse" ]; then
echo "firebase crashlytics Inhouse run..."
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
#chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/Resources/GoogleService-Info-RC.plist" -p ios "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
else

echo "firebase crashlytics debug run..."
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/GoogleService-Info.plist" -p ios "$CI_ARCHIVE_PATH/dSYMs"
fi
fi

echo "finish crashlytics run"
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
