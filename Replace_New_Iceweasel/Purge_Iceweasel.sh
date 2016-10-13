#!/bin/bash

#echo "alias chrome=\"xhost + > /dev/null && su chrome -c chromium > /dev/null 2>&1\"" >> ~/.bashrc

Repository_Check ()
{
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' chromium|grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        echo -e "\tNOT INSTALLED"
        echo -ne "Installing Browser:" && apt-get install chromium chromium-l10n -y > /dev/null 2>&1 && echo -e "\t\t\tDONE"
    else echo -e "\tINSTALLED"
    fi
}

Old_Software_Delete ()
{
    apt-get remove firefox-esr -y > /dev/null 2>&1
    apt-get remove iceweasel -y > /dev/null 2>&1
}

User_Check ()
{
    USER_OK=$(cat /etc/passwd | cut -d ":" -f1 | grep "chromeuser")
    if [ "" == "$USER_OK" ]; then
        useradd -m chromeuser
        echo -e "\t\tADDED"
    else echo -e "\t\tOK"
    fi
}

Browser_Detection ()
{
    Browser_Open=$(ps aux | grep -E 'iceweasel|firefox|firefox-esr'| grep -v grep | awk '{print $2}')
    if [ "" != "$Browser_Open" ]; then
        echo -e "\tCURRENT SESSION ENABLED"
        echo -ne "Killing Browser Process:" && kill -9 $Browser_Open && echo -e "\t\tDONE"
    else echo -e "\tDONE"
    fi
}

Bash_Update ()
{
    if [[ "" == "$(grep "chrome" /root/.bashrc)" ]]; then
        xhost +SI:localuser:chromeuser > /dev/null 2&>1
        xhost - > /dev/null 2&>1
        echo "alias chrome=\"su chromeuser -c chromium > /dev/null 2>&1\"" >> /root/.bashrc
    fi
}

echo -ne "Updating Repositories:" && apt-get update > /dev/null 2>&1 && echo -e "\t\t\tDONE"
echo -ne "Checking for Open Browser Session:" && Browser_Detection
echo -ne "Checking for Previous Installations:" && Repository_Check
echo -ne "Removing Incompatible Browsers:" && Old_Software_Delete && echo -e "\t\tDONE"
echo -ne "Checking for User Account:" && User_Check
echo -ne "Updating BASHRC" && Bash_Update && source /root/.bashrc && echo -e "\t\t\t\tOK"
echo ""
echo -ne "COMPLETE:" && echo -e "\t\t\t\tType \"chrome &\" in your terminal to execute."
