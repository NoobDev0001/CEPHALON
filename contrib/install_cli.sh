 #!/usr/bin/env bash

 # Execute this file to install the cephalon cli tools into your path on OS X

 CURRENT_LOC="$( cd "$(dirname "$0")" ; pwd -P )"
 LOCATION=${CURRENT_LOC%Cephalon-Qt.app*}

 # Ensure that the directory to symlink to exists
 sudo mkdir -p /usr/local/bin

 # Create symlinks to the cli tools
 sudo ln -s ${LOCATION}/Cephalon-Qt.app/Contents/MacOS/cephalond /usr/local/bin/cephalond
 sudo ln -s ${LOCATION}/Cephalon-Qt.app/Contents/MacOS/cephalon-cli /usr/local/bin/cephalon-cli
