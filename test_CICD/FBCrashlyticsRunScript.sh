

#!/bin/sh
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"

echo "find..."
find .. GoogleService-Info.plist -type f

echo "🟢 find... project path "
find ${CI_PROJECT_FILE_PATH} firebase-ios-sdk -type d

echo "🟢 find... build path "
find ${BUILD_DIR%Build} firebase-ios-sdk -type d

echo "🟢 find... derived path "
find ${CI_DERIVED_DATA_PATH} firebase-ios-sdk -type d

echo "🟢 find... back path "
find .. firebase-ios-sdk -type d

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
