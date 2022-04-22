# DockerProj

### Docker Project:

Writing a Dockerfile that creates a new image based on Alpine Linux and calling it AlpCon.

Building a script that checks if AlpCon container is running,<br> 
if the container is not running then start it. 
<br><br> 
This script will do the following operations on the container:

1. Download a python file from a git repository.
2. Runs the python program which writes the result to a simple text file in the 
public directory.
3. Waits for 10 seconds.. if the python file is still running, kill it and print failed
test.
4. Stop the container.

***How to run it:***

First of all clone the project to your local file system:

`$ https://github.com/kamalaweenat/docker-project.git`

In your terminal run the script file - install_env.sh

`$ ./con_ctl.sh`

Or 

`$ bash con_ctl.sh`

the script will install the environment

