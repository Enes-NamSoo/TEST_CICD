

#!/bin/sh
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
echo "🟢${CONFIGURATION}🟢"

echo "🟢archive🟢"
find "${CI_ARCHIVE_PATH}" test_CICD.app.dSYM

echo "🟢derived🟢"
find ${CI_DERIVED_DATA_PATH} dSYMs -type d

set -e

if [[ -n $CI_ARCHIVE_PATH ]]; then
    echo "upload dSYMs..."
    "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
    "${CI_DERIVED_DATA_PATH}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/test_CICD/GoogleService-Info.plist" -p ios "$CI_ARCHIVE_PATH/dSYMs/${DWARF_DSYM_FILE_NAME}"
else
    echo "firebase crashlytics debug run..."
    "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
    "${BUILD_DIR%Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp "${PROJECT_DIR}/test_CICD/GoogleService-Info.plist" -p ios "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
    
    echo "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
fi

echo "finish crashlytics run"
echo "🟢🟢🟢🟢🟢🟢🟢🟢🟢"
