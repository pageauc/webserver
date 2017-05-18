# webserver.py
### Raspberry Pi - Simple python Stand Alone Local Network Web Server 

### Description
This is a single file stand alone python webserver that needs minimal or no setup. 
This webserver can be used to remotely view images, video, documents, html, java, Etc. 
files from (LAN) local area network connected computers using a web browse. Directory links 
to files and subfolders are dynamically created and displayed in a right side 
listing that can be arranged and sorted via variables. Variables are contained 
in the settings.py file and allow customization of webserver display and configuration settings.

I use webserver.py in my pi-timolo and other projects
to allow easy browsing of image, video or other files.  

This web server can display other types of content
but html files will be displayed full screen.
Web pages with javascript, css Etc will run. A sample calculator program is 
include in the calculator folder of the www web root. 
If a folder has an index.html it will take over 
the browser tab. 

If a folder is selected on the right pane listing
the folder contents will appear in a new browser tab.
You cannot navigate back to the previous folder from
this new tab so when you are done with the folder
tab just close it.  You can navigate through a
folder structure but remember each folder will
open a new tab.	 

This browser can only access local raspberry pi
files. It cannot access internet web pages.

***Please Note***
You will need at least two entries in a folder
before the web server will display content.
 
### Quick Install
For Easy webserver-install.sh onto raspbian RPI. 

    curl -L https://raw.github.com/pageauc/webserver/master/webserver-install.sh | bash

From a computer logged into the RPI via SSH(Putty) or desktop terminal session  
* Use mouse to highlight curl command above, right click, copy.  
* Select RPI SSH(Putty) window, mouse right click, paste.   
The command will download and execute the GitHub webserver-install.sh script   
    
### Manual Install   
From logged in RPI SSH session or console terminal perform the following. You can review
the webserver-install.sh script code before executing.

    cd ~
    wget https://raw.github.com/pageauc/webserver/master/webserver-install.sh
    chmod +x webserver-install.sh
    ./webserver-install.sh
    
### How to Run webserver.py
    
    cd ~/webserver
    ./webserver.py

A message will be displayed indicating the ip address:port to enter in
a browser url bar.  This will access the webserver files in the server web root. 

If you want to run the webserver.py as a background daemon then use webserver.sh
If no parameter is specified it will display the PID or indicate webserver.py is
not running. 

To Start webserver.py as a background daemon

    cd ~/webserver
    ./webserver.sh start    

To Stop webserver.py

    cd ~/webserver
    ./webserver.sh stop    
     
### Customize Settings

The webserver.py variables are stored in the settings.py file.  These can be
edited using the nano editor to customize for your particular needs if required
   
Edit settings.py file using nano editor per the following commands

    cd ~/webserver
    nano settings.py

ctrl-x y to exit nano editor and save changes
    
### Reference Links  
webserver wiki - https://github.com/pageauc/pi-timolo/wiki/Access-images-via-webserver
github repo - https://github.com/pageauc/webserver

 
Good Luck
Claude Pageau 
