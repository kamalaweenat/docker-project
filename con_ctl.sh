#!/usr/bin/env bash

# Conatiner and image name both are the same name
CONTAINER_NAME="AlpCon" 
IMAGE_NAME="alp_img" 
PUPLIC_DIR="/home/$USER/docker_output" # path to the volume dir in your linux system for mapping 
OUTPUT_DIR="output" # The Directory name in container of the python output - also use for volume 
OUTPUT_FILE="python_out" # the python output file name
GITHUB_URL="https://github.com/kamal85f/DockerProj.git" # repo url from github
GIT_DIR="/DockerProj" # Git dir name inside the container - all files are pulled inside this folder 
PYTHON_SCRIPT="succeed.py" # python script succeed print
#PYTHON_SCRIPT="wait.py" # python script which waits for 20 seconds
SEC_WAIT=10 # how many seconds need to wait till python script finishs running

# First of all check docker is exist in the machine
if ! type "docker" > /dev/null; then
  echo "[Docker does not exist, try to install it first..]"
  exit 1
fi


# Check if image does not exist otherwise build it..
result=$( docker images -q "$IMAGE_NAME" )

if [[ -n "$result" ]]; then
  echo "[Image $IMAGE_NAME exists before there is no need for build..]"
else
  echo "[Image $IMAGE_NAME does not exist, so it will be created:]"
  docker build -t "$IMAGE_NAME" .
  #docker build --build-arg ALPINE_VER=3.15.0 -t "$IMAGE_NAME" .
fi


# Check if the container is running otherwise run it
if [ "$( docker container inspect -f '{{.State.Running}}' $CONTAINER_NAME )" == "true" ]; then
	echo "[Container [$CONTAINER_NAME] is running before, there is no need ot run it..]"		

else
	# if it's not running, check if there is a container before and start it
	if [ $( docker ps -a | grep "$CONTAINER_NAME" | wc -l ) -gt 0 ]; then
		echo "[$CONTAINER_NAME container exists hence it will be starting]"
		docker start "$CONTAINER_NAME"	
			
	# if it's the first time you run this image	
	else 
		echo "[$CONTAINER_NAME container does not exist hence it will be running..]"		
		docker run -d --name "$CONTAINER_NAME" -v "$PUPLIC_DIR":"/$OUTPUT_DIR" "$IMAGE_NAME"  tail -f /dev/null	
		docker exec -it "$CONTAINER_NAME" sh -c "mkdir -p $OUTPUT_DIR; chmod 777 $OUTPUT_DIR"	
		docker exec -it "$CONTAINER_NAME" git clone "$GITHUB_URL"
				
	fi	
fi

echo "[Execute GIT pull command]"
docker exec -it -w "$GIT_DIR" "$CONTAINER_NAME" sh -c "git pull; chmod +x *"

echo "[Running python '/$GIT_DIR/$PYTHON_SCRIPT' script]"
# run script in background because we want to measure how many seconds elapsed
docker exec -d -w "$GIT_DIR" "$CONTAINER_NAME" python3 "$PYTHON_SCRIPT" "/$OUTPUT_DIR/$OUTPUT_FILE"

echo "[Starting timer for '$SEC_WAIT' seconds]"
# Run timer in the container and check if it takes time more than SEC_WAIT seconds
docker exec -it -w "$GIT_DIR" "$CONTAINER_NAME" sh -c "./timer.sh $SEC_WAIT"

echo "[Trying to stop the container..]"
docker stop "$CONTAINER_NAME"

echo "[$CONTAINER_NAME container is stopped]"









