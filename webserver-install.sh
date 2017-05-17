#!/bin/bash
# Convenient webserver-install.sh script written by Claude Pageau 17-May-2017
ver="1.0"
APP_DIR='webserver'  # Default folder install location

cd ~
if [ -d "$APP_DIR" ] ; then
  STATUS="Upgrade"
  echo "Upgrade $APP_DIR Files"
else  
  echo "New $APP_DIR Install"
  STATUS="New Install"
  mkdir -p $APP_DIR
  mkdir -p $APP_DIR/www/media
  echo "$APP_DIR Folder Created"
fi 

cd $APP_DIR
INSTALL_PATH=$( pwd )

echo " Downloading Files"
wget -O www/webserver.txt https://raw.github.com/pageauc/webserver/master/webserver.txt
wget -O settings_new.py -q --show-progress https://raw.github.com/pageauc/webserver/master/settings.py
if [ $? -ne 0 ] ;  then
  wget -O settings.py https://raw.github.com/pageauc/webserver/master/settings.py
  wget -O webserver.py https://raw.github.com/pageauc/webserver/master/webserver.py
  wget -O webserver.sh https://raw.github.com/pageauc/webserver/master/webserver.sh  
  wget -O webserver-install.sh https://raw.github.com/pageauc/webserver/master/webserver-install.sh
  wget -O Readme.md https://raw.github.com/pageauc/webserver/master/Readme.md
else
  wget -O settings.py -q --show-progress https://raw.github.com/pageauc/webserver/master/settings.py
  wget -O webserver.py -q --show-progress https://raw.github.com/pageauc/webserver/master/webserver.py
  wget -O webserver.sh -q --show-progress https://raw.github.com/pageauc/webserver/master/webserver.sh
  wget -O webserver-install.sh -q --show-progress https://raw.github.com/pageauc/webserver/master/webserver-install.sh  
  wget -O Readme.md -q --show-progress https://raw.github.com/pageauc/webserver/master/Readme.md
fi
  
echo " Done Download"
echo "-------------------------------------------------------------"
echo " Make Required Files Executable"
echo ""
chmod +x *py
chmod -x settings*py
chmod +x *sh 
echo " Done Permissions"
echo "-------------------------------------------------------------"
echo ""  

cd $DIR
# Check if webserver-install.sh was launched from webserver folder
if [ "$DIR" != "$INSTALL_PATH" ]; then
  if [ -e 'webserver-install.sh' ]; then
    echo "$STATUS Cleanup webserver-install.sh"
    rm webserver-install.sh
  fi
fi

echo "-----------------------------------------------"
echo " $STATUS Complete"
echo "-----------------------------------------------"

echo "Good Luck Claude ..."
echo "Bye"

