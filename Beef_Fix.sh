#!/bin/bash

if [ "$UID" != "0" ]; then
    echo "MUST BE ROOT"
    exit 0
else
    echo -ne "Updating Repository: " && apt-get update > /dev/null 2>&1 && echo -e "\t\tOK"
    echo -ne "Removing Installed Version: " && apt-get purge beef-xss -y > /dev/null 2>&1 && echo -e "\tOK"
    echo -ne "Cloning New Version of Beef: " && cd /opt/ && git clone https://github.com/beefproject/beef.git > /dev/null 2>&1 && echo -e "\tOK"
    echo -ne "Installing Dependencies: " && apt-get install bundler libsqlite3-dev -y > /dev/null 2>&1 && echo -e "\tOK"
    echo -ne "Bundle Installer Running: " && cd beef/ && bundle install > /dev/null 2>&1 && echo -e "\tOK"
    echo -ne "Finished With Installation: " && echo -e "\tRun Executable in /opt/beef/"
    exit 0
fi
