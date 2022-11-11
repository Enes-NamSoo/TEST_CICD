

#!/bin/sh
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"

echo "tree install.."
apt install tree

tree -L 2 -f -N

#set -e // 오류발생시 종료하는 옵션
if [[ -n $CI_ARCHIVE_PATH ]];
then
echo "Found valid archive path, trying to upload dSYMs."

if [ "${CONFIGURATION}" == "RELEASE" ]; then
echo "firebase crashlytics Release run..."
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${CI_PROJECT_FILE_PATH}/GoogleService-Info.plist" -p ios "$CI_ARCHIVE_PATH/dSYMs"

else

echo "firebase crashlytics debug run..."
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
chmod +x "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${CI_PROJECT_FILE_PATH}/GoogleService-Info.plist" -p ios "$CI_ARCHIVE_PATH/dSYMs"
fi
fi

echo "finish crashlytics run"
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
