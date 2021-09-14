## This is Flask service.
###### This service recieves JSON via HTTP POST method and returns corresponding answer.
###### The GET method also will be handled. It will be the the web page with the description of this service.

### The operating stage:
* main.yaml is playbook, that deploys this service to remote debian vm
* playbook runs from root user, and disables password login, so be shure, that you have rsa keys on remote vm
* also playbook closes all ports, except 22 and 80, disables root login and installs all needed dependencies
* files directory contains all necessary files to copy to remote vm
