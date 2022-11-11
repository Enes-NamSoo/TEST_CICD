

#!/bin/sh
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"

echo "${CONFIGURATION}"

echo "🟢 find... derived path "
find "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk" upload-symbols


#set -e // 오류발생시 종료하는 옵션
if [[ -n $CI_ARCHIVE_PATH ]];
then
echo "Found valid archive path, trying to upload dSYMs."

echo "firebase crashlytics debug run..."
chmod +x "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
chmod +x "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "../${CI_PRODUCT}/GoogleService-Info.plist" -p ios "${CI_ARCHIVE_PATH}/dSYMs"

"${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
"${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "../${CI_PRODUCT}/GoogleService-Info.plist" -p ios "${CI_ARCHIVE_PATH}/dSYMs"

fi

echo "finish crashlytics run"
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
