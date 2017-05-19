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
  mkdir -p $APP_DIR/www
  echo "$APP_DIR Folder Created"
fi 

cd $APP_DIR
INSTALL_PATH=$( pwd )

# Remember where this script was launched from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "-------------------------------------------------------------"
echo "      webserver-install.sh script ver $ver"
echo "-------------------------------------------------------------"
echo " Downloading Files"
wget -O settings.py -q --show-progress https://raw.github.com/pageauc/webserver/master/settings.py
if [ $? -ne 0 ] ;  then
  wget -O settings.py https://raw.github.com/pageauc/webserver/master/settings.py
  wget -O menubox.sh https://raw.github.com/pageauc/webserver/master/menubox.sh 
  wget -O webserver.py https://raw.github.com/pageauc/webserver/master/webserver.py
  wget -O webserver.sh https://raw.github.com/pageauc/webserver/master/webserver.sh  
  wget -O webserver-install.sh https://raw.github.com/pageauc/webserver/master/webserver-install.sh
  wget -O Readme.md https://raw.github.com/pageauc/webserver/master/Readme.md
  wget -O www/webserver.txt https://raw.github.com/pageauc/webserver/master/www/webserver.txt 
  wget -O www/calculator.zip https://raw.github.com/pageauc/webserver/master/www/calculator.zip
  wget -O www/images.zip https://raw.github.com/pageauc/webserver/master/www/images.zip
else
  wget -O menubox.sh -q --show-progress https://raw.github.com/pageauc/webserver/master/menubox.sh 
  wget -O webserver.py -q --show-progress https://raw.github.com/pageauc/webserver/master/webserver.py
  wget -O webserver.sh -q --show-progress https://raw.github.com/pageauc/webserver/master/webserver.sh
  wget -O webserver-install.sh -q --show-progress https://raw.github.com/pageauc/webserver/master/webserver-install.sh  
  wget -O Readme.md -q --show-progress https://raw.github.com/pageauc/webserver/master/Readme.md
  wget -O www/webserver.txt -q --show-progress https://raw.github.com/pageauc/webserver/master/www/webserver.txt
  wget -O www/calculator.zip -q --show-progress https://raw.github.com/pageauc/webserver/master/www/calculator.zip
  wget -O www/images.zip -q --show-progress https://raw.github.com/pageauc/webserver/master/www/images.zip  
fi
echo " Done Downloads"
echo "-------------------------------------------------------------"
echo " Make Required Files Executable"
echo ""
chmod +x *py
chmod -x settings*py
chmod +x *sh 
echo " Done Permissions"
echo "-------------------------------------------------------------"
echo ""  

cd www
unzip -o calculator.zip
unzip -o images.zip
rm calculator.zip
rm images.zip

cd $DIR
# Check if webserver-install.sh was launched from webserver folder
if [ "$DIR" != "$INSTALL_PATH" ]; then
  if [ -e 'webserver-install.sh' ]; then
    echo "$STATUS Cleanup webserver-install.sh"
    rm webserver-install.sh
  fi
fi

echo "-----------------------------------------------"
echo " $STATUS Complete to $INSTALL_PATH"
echo ""
echo "Instructions to Run this Webserver"
echo ""
echo "    cd ~/webserver"
echo "    ./menubox.sh"
echo ""
echo "This will display a whiptail menu of options"
echo "-----------------------------------------------"

echo "Good Luck Claude ..."
echo "Bye"

