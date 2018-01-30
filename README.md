# Manuell Mozilla-firefox_updater
Manuell updater for Firefox (57) in debian parallel to the (old) firefox package.

## Requirement
- At best the debian package and all dependencies (e.g. firefox-esr)
- wget
- root access

## How to
1. Download script and desktop file
2. move desktop file to 

> /usr/share/applicatios

to create a system-wide applications link.

3. store script where you like it & make it executable

> \# chmod +x scripts/update-firefox57.sh

4. run script (as root)

> \# ./scripts/update-firefox57.sh


