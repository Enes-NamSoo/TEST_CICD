

#!/bin/sh

curl -Ls https://install.tuist.io | bash

echo "tuist generate..."
tuist clean --path ..
tuist fetch --path ..
tuist generate --path ..


tuist init --platform ios

tuist generate

echo "tuist finish..."
