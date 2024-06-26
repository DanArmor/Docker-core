#!/bin/bash

set -e

USERNAME="www-data"
GROUPNAME="www-data"

LUID=${USER_ID:-0}
LGID=${GROUP_ID:-0}

if [ $LUID -eq 0 ]; then
    LUID=65534
fi

if [ $LGID -eq 0 ]; then
    LGID=65534
fi

groupadd -o -g $LGID $GROUPNAME >/dev/null 2>&1 ||
groupmod -o -g $LGID $GROUPNAME >/dev/null 2>&1
useradd -o -u $LUID -g $GROUPNAME -s /bin/ash $USERNAME >/dev/null 2>&1 ||
usermod -o -u $LUID -g $GROUPNAME -s /bin/ash $USERNAME >/dev/null 2>&1
mkhomedir_helper $USERNAME

mkdir -p /var/www/bearpass
chown -R $USERNAME:$GROUPNAME /var/www/bearpass

crond -f