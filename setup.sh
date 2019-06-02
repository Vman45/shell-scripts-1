#!/bin/bash

read -e -p "Enter Branch [master]/dev: " -i "master" branch

#check for distro

echo -e "\n>> Checking Distro\n"
. /etc/os-release
echo -e "Distrubution Name = $NAME \n"

#Preparing Dialog
if [ $ID = "fedora" ]
    then
    if [ $(dnf -q list installed dialog &>/dev/null && echo "1" || echo "0") -eq 0 ] 
    then
        sudo dnf -y -q install dialog
    fi
    if [ $(dnf -q list installed openssh-server &>/dev/null && echo "1" || echo "0") -eq 0 ] 
    then
        sudo dnf -y -q install openssh-server
    fi
fi

if [ $ID = "ubuntu" ]
then
    if [ $(dpkg-query -W -f='${Status}' dialog 2>/dev/null | grep -c "ok installed") -eq 0 ] 
    then
        sudo apt-get -y install -qq dialog
    fi
    if [ $(dpkg-query -W -f='${Status}' openssh-sever 2>/dev/null | grep -c "ok installed") -eq 0] 
    then
        sudo apt-get -y install -qq openssh-server
    fi
fi


Selection Dialog
cmd=(dialog --separate-output --checklist "Select Packages to Install:" 22 76 16)
options=(1 "Google Chrome" on    # any option can be set to default to "on"
         2 "Rocketchat" on
         3 "SublimeText" on
         4 "Docker-CE" on
         5 "Docker Repo" off
         6 "MongoDB " off )d
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

chrome="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-chrome_$distro.sh"
rocketchat="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-rocketchat_$distro.sh"
sublime="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-sublime_$distro.sh"
docker="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-docker_$distro.sh"
gitclone="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/git_clone.sh"
mongodb="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-mongo_$distro.sh"

for choice in $choices
do
    case $choice in
        1)
            /bin/bash -c "$(curl -sL $chrome)"
            echo -e "---------------------------------------------------- \n"
            ;;
        2)
            /bin/bash -c "$(curl -sL $rocketchat)"
            echo -e "---------------------------------------------------- \n"
            ;;
        3)
            /bin/bash -c "$(curl -sL $sublime)"
            echo -e "---------------------------------------------------- \n"
            ;;
        4)
            /bin/bash -c "$(curl -sL $docker)"
            echo -e "---------------------------------------------------- \n"
            ;;
        5)  
            /bin/bash -c "$(curl -sL $gitclone)"
            echo -e "---------------------------------------------------- \n"
            ;;
        6)  
            /bin/bash -c "$(curl -sL $mongodb)"
            echo -e "---------------------------------------------------- \n"
    esac
done