#!/bin/bash

ver="1.00"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

pyconfigfile="./settings.py"
filename_conf="./settings.conf"
filename_temp="./settings.conf.temp"

#------------------------------------------------------------------------------
function do_anykey ()
{
   echo ""
   echo "######################################"
   echo "#          Review Output             #"
   echo "######################################"
   read -p "  Press Enter to Return to Main Menu"
}

#------------------------------------------------------------------------------
function init_status ()
{
  if [ -z "$( pgrep -f $DIR/webserver.py )" ]; then
     WEB_1="START"
     WEB_2="webserver.py in background"
  else
     webserver_pid=$( pgrep -f $DIR/webserver.py )
     WEB_1="STOP"
     WEB_2="webserver.py - PID is $webserver_pid"
  fi
}

#------------------------------------------------------------------------------
function do_webserver ()
{
  if [ -z "$( pgrep -f $DIR/webserver.py )" ]; then
     ./webserver.sh start
     if [ -z "$( pgrep -f $DIR/webserver.py )" ]; then
        whiptail --msgbox "Failed to Start webserver.py   Please Investigate Problem." 20 70
     else
       myip=$(ifconfig | grep 'inet ' | grep -v 127.0.0 | cut -d " " -f 12 | cut -d ":" -f 2 )
       myport=$( grep "web_server_port" settings.py | cut -d "=" -f 2 | cut -d "#" -f 1 | awk '{$1=$1};1' )
       whiptail --msgbox --title "Webserver Access" "Access web server from another network computer web browser using url http://$myip:$myport" 15 50
     fi
  else
     $DIR/webserver.sh stop
     if [ ! -z "$( pgrep -f $DIR/webserver.py )" ]; then
        whiptail --msgbox "Failed to Stop webserver.py   Please Investigate Problem." 20 70
     fi
  fi
  do_main_menu
}

#------------------------------------------------------------------------------
function do_webserver_config ()
{
    if [ -e $DIR/settings.py ] ; then
        /bin/nano $DIR/settings.py
    else
        whiptail --msgbox "ERROR - $DIR/settings.py File Not Found. Please Investigate." 20 65 1
    fi
}


#--------------------------------------------------------------------
function do_edit_save ()
{
  if (whiptail --title "Save $var=$newvalue" --yesno "$comment\n $var=$newvalue   was $value" 8 65 --yes-button "Save" --no-button "Cancel" ) then
    value=$newvalue

    rm $filename_conf  # Initialize new conf file
    while read configfile ;  do
      if echo "${configfile}" | grep --quiet "${var}" ; then
         echo "$var=$value         #$comment" >> $filename_conf
      else
         echo "$configfile" >> $filename_conf
      fi
    done < $pyconfigfile
    cp $filename_conf $pyconfigfile
  fi
  do_settings_menu
}

#--------------------------------------------------------------------
function do_edit_variable ()
{
  choice=$(cat $filename_temp | grep $SELECTION)

  var=$(echo $choice | cut -d= -f1)
  value=$(echo $choice | cut -d= -f2)
  comment=$( cat $filename_conf | grep $var | cut -d# -f2 )

  echo "${value}" | grep --quiet "True"
  # Exit status 0 means anotherstring was found
  # Exit status 1 means anotherstring was not found
  if [ $? = 0 ] ; then
     newvalue=" False"
     do_edit_save
  else
     echo "${value}" | grep --quiet "False"
     if [ $? = 0 ] ; then
        newvalue=" True"
        do_edit_save
     elif  [ $? = 1 ] ; then
        newvalue=$(whiptail --title "Edit $var (Enter Saves or Tab)" \
                               --inputbox "$comment\n $var=$value" 10 65 "$value" \
                               --ok-button "Save" 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ ! "$newvalue" = "" ] ; then   # Variable was changed
           if [ $exitstatus -eq 1 ] ; then  # Check if Save selected otherwise it was cancelled
              do_edit_save
           elif [ $exitstatus -eq 0 ] ; then
             echo "do_edit_variable - Cancel was pressed"
             if echo "${value}" | grep --quiet "${newvalue}" ; then
                do_settings_menu
             else
                do_edit_save
             fi
           fi
        fi
     fi
  fi
  do_settings_menu
}

#--------------------------------------------------------------------
function do_edit_menu ()
{
  clear
  echo "Copy $filename_conf from $pyconfigfile  Please Wait ...."
  cp $pyconfigfile $filename_conf
  echo "Initialize $filename_temp  Please Wait ...."
  cat $filename_conf | grep = | cut -f1 -d# | tr -s [:space:] >$filename_temp
  echo "Initializing Settings Menu Please Wait ...."
  menu_options=()
  while read -r number text; do
    menu_options+=( ${number//\"} "${text//\"}" )
  done < $filename_temp

  SELECTION=$( whiptail --title "webserver Settings Menu" \
                       --menu "Arrow/Enter Selects or Tab" 0 0 0 "${menu_options[@]}" --ok-button "Edit" 3>&1 1>&2 2>&3 )
  RET=$?
  if [ $RET -eq 1 ] ; then
    do_settings_menu
  elif [ $RET -eq 0 ]; then
    cp $pyconfigfile $filename_conf
    cat $filename_conf | grep = | cut -f1 -d# | tr -s [:space:] >$filename_temp
    do_edit_variable
  fi
}

#------------------------------------------------------------------------------
function do_nano_main ()
{
  cp $pyconfigfile $filename_conf
  nano $filename_conf
  if (whiptail --title "Save Nano Edits" --yesno "Save nano changes to $filename_conf\n or cancel all changes" 8 65 --yes-button "Save" --no-button "Cancel" ) then
    cp $filename_conf $pyconfigfile
  fi
}

#------------------------------------------------------------------------------
function do_settings_menu ()
{
  SET_SEL=$( whiptail --title "Settings Menu" --menu "Arrow/Enter Selects or Tab Key" 0 0 0 --ok-button Select --cancel-button Back \
  "a " "Menu Edit webserver settings.py" \
  "b " "nano Edit settings.py" \
  "c " "View settings.py" \
  "d " "Back to Main Menu" 3>&1 1>&2 2>&3 )

  RET=$?
  if [ $RET -eq 1 ]; then
    clear
    rm -f $filename_temp
    rm -f $filename_conf
    do_main_menu
  elif [ $RET -eq 0 ]; then
    case "$SET_SEL" in
      a\ *) do_edit_menu
            do_settings_menu ;;
      b\ *) do_nano_main
            do_settings_menu ;;
      c\ *) more -d settings.py
            do_anykey
            do_settings_menu ;;
      d\ *) clear
            rm -f $filename_temp
            rm -f $filename_conf
            do_main_menu ;;
      *) whiptail --msgbox "Programmer error: unrecognized option" 20 60 1 ;;
    esac || whiptail --msgbox "There was an error running selection $SELECTION" 20 60 1
  fi

}

#------------------------------------------------------------------------------
function do_upgrade ()
{
  if (whiptail --title "GitHub Upgrade webserver" --yesno "Upgrade webserver files from GitHub" 8 65 --yes-button "upgrade" --no-button "Cancel" ) then
    curl -L https://raw.github.com/pageauc/webserver/master/webserver-install.sh | bash
    do_anykey
  fi
}

#------------------------------------------------------------------------------
function do_about ()
{
  whiptail --title "About" --msgbox " \
                webserver.py
    Manage webserver operation and settings

          written by Claude Pageau

           for more information

    View Readme.md (use menubox.sh help option)
    or
    visit web repo at https://github.com/pageauc/webserver
    Raise a github issue for issues or questions

\
" 0 0 0
}

#------------------------------------------------------------------------------
function do_main_menu ()
{
  init_status
  SELECTION=$(whiptail --title "Webserver Main Menu" --menu "Arrow/Enter Selects or Tab Key" 0 0 0 --cancel-button Quit --ok-button Select \
  "a $WEB_1" "$WEB_2" \
  "b SETTINGS" "Edit/View webserver Settings" \
  "c HELP" "View Readme.md" \
  "d UPGRADE" "Files From GitHub.com" \
  "e ABOUT" "This Program" \
  "q QUIT" "Exit menubox.sh"  3>&1 1>&2 2>&3)

  RET=$?
  if [ $RET -eq 1 ]; then
    exit 0
  elif [ $RET -eq 0 ]; then
    case "$SELECTION" in
      a\ *) do_webserver ;;
      b\ *) do_settings_menu ;;
      c\ *) more -d Readme.md
            do_anykey ;;
      d\ *) do_upgrade ;;
      e\ *) do_about ;;
      q\ *) clear
            exit 0 ;;
         *) whiptail --msgbox "Programmer error: unrecognized option" 20 60 1 ;;
    esac || whiptail --msgbox "There was an error running selection $SELECTION" 20 60 1
  fi
}

#------------------------------------------------------------------------------
#                                Main Script
#------------------------------------------------------------------------------
if [ $# -eq 0 ] ; then
  while true; do
     do_main_menu
  done
fi