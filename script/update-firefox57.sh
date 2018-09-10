#!/bin/bash
# =============================== #
#	script from		  #
#	jonny			  #
#	mail:jonny@riotcat.org	  #
#	10.9.18			  #
# =============================== #


VERSION=/tmp/ff_update.link
TARGET=/tmp/
NEW=$(curl -s "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=de")

#checking for parameter
while [[ $# -gt 0 ]]; do
	case $1 in
		-f|--force-override)
			shift
			FORCE=YES
			;;
		-nc|--no-check)
			shift
			NOCHECK=YES
			;;
		-h|--help)
			shift
			HELP=YES
			;;
		*)
			shift
			UNKOWN=YES
			;;
	esac
done

if [ "$HELP" == YES ] || [ "$UNKOWN" == YES ]; then
	if [ "$UNKOWN" == YES ]; then
		echo "Parameter unkown!"
	fi
	echo -e "USAGE:\n$0 [-f|--force-override] [-nc|--no-check] [-h|--help]\n\n\
	-f  | --force-override    Force to override bin, even if it's running. Attention(!) Firefox may crash\n\
	-nc | --no-check          Skips check if Firefox was downloaded recently\n\
	-h  | --help              Shows this help message\n\n\
	Manual Update for Mozilla Firefox using https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=de and installing to /opt/firefox.\n\nHelp via https://github.com/JonnyTischbein/mozilla-firefox_updater"
	exit 0
fi

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
	if [ "$NOCHECK" != YES ]; then
		echo "Firefox already up-to-date!"
		exit -1
	else
		echo "Forcing update.."
	fi
fi

#getting URL and Targetname
URL=$(cat $VERSION | grep -E -o "http.*.bz2")
TARGET=$TARGET$(cat $VERSION | grep -o -e "firefox-.*.bz2")

#download new package
if [ ! -d "$TARGET" ]; then
	wget -O $TARGET $URL
fi

#move old firefox bin in case it is running
if [ "$FORCE" == YES ]; then
	mv /opt/firefox/firefox /opt/firefox/firefox.oldi
fi

#extract and overwrite to /opt/firefox-update
tar xjfv $TARGET -C /opt/ --overwrite
