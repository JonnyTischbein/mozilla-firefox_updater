#!/bin/bash
# =============================== #
#       script from               #
#       jonny                     #
#       mail:jonny@riotcat.org    #
#       30.1.18                   #
# =============================== #


VERSION=/tmp/ff_update.link
TARGET=/tmp/
NEW=$(curl -s "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=de")

#checking if an old version was downloaded before
if [ -e $VERSION ]
then
        OLD=$(cat $VERSION)
else
        touch $VERSION
fi

#checking if a new version is available
if [ "$NEW" != "$OLD" ]
then
        echo $NEW > $VERSION
        echo "Updateing firefox.."
else
        echo "Firefox already up-to-date!"
        exit -1
fi

#getting URL and Targetname
URL=$(cat $VERSION | grep -E -o "http.*.bz2")
TARGET=$TARGET$(cat $VERSION | grep -o -e "firefox-.*.bz2")

#download new package
wget -O $TARGET $URL

#extract and overwrite to /opt/firefox
tar xjfv $TARGET -C /opt/ --overwrite
