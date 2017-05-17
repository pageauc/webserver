# pi-timolo
### Raspberry (Pi) - Simple Web Server (little or no setup)
### Wiki https://github.com/pageauc/webserver    


### Description
This is a single file stand alone webserver that needs minimal or no setup. 
This webserver can be used to remotely view images, video, document, Etc. files
from other (LAN) network connected computers using a web browse. Directory links 
to files and subfolders are dynamically created and displayed in a right side 
listing that can be arranged and sorted via variables. Variables are contained 
in the script and allow customization of webserver display and configuration settings.

I use this in my pi-timolo and other projects
to allow easy browsing of image, video or other files.  This web server will 
read other file types like html or java script.
A sample calculator program is include in the calculator folder of the web root.

***Please Note***
You will need at least two entries in a folder
before the web server will display content.

This web server can display other types of content
but html files will be displayed full screen.
Web pages with javascript, css Etc will run.
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
 
### Quick Install
For Easy webserver-install.sh onto raspbian RPI. 

    curl -L https://raw.github.com/pageauc/webserver/master/source/webserver-install.sh | bash

From a computer logged into the RPI via SSH(Putty) or desktop terminal session  
* Use mouse to highlight curl command above, right click, copy.  
* Select RPI SSH(Putty) window, mouse right click, paste.   
The command will download and execute the GitHub webserver-install.sh script   
    
### Manual Install   
From logged in RPI SSH session or console terminal perform the following. You can review
the pi-timolo-install.sh script code before executing.

    cd ~
    wget https://raw.github.com/pageauc/pi-timolo/master/source/pi-timolo-install.sh
    chmod +x pi-timolo-install.sh
    ./pi-timolo-install.sh
    
### How to Run webserver.py
Default is motion only see config.py for detailed settings   
    
    cd ~/webserver
    ./webserver.sh   
 
### Customize Settings

### Reference Links  
Detailed pi-timolo Wiki https://github.com/pageauc/webserver 
 
Good Luck
Claude Pageau 
