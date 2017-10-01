#!/bin/bash

# Functions
function abort {
    echo -e "\033[31mERROR:\033[0m $1"
    exit "${2:-1}"
}

# Params
IP=${1:-192.168.0.1}
USER=${2:-admin}
read -s -p "Enter password: " PASSWORD
echo
echo

echo "Logging in to your router..."
curl --silent "http://$IP/login.php" --data "ACTION_POST=LOGIN&FILECODE=&VERIFICATION_CODE=&LOGIN_USER=$USER&LOGIN_PASSWD=$PASSWORD&login=Log+In+&VER_CODE=" > /dev/null

echo "Rebooting the router..."
[[ $(curl --silent "http://$IP/sys_cfg_valid.xgi?&exeshell=submit%20REBOOT") != *'401 Not Authorized'* ]] || abort "401 Not Authorized"

echo "Done"