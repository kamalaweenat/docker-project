# Conatiner and image name both are the same name
CONTAINER_NAME="AlpCon" 
IMAGE_NAME="alp_img" 
PUPLIC_DIR="/home/$USER/docker_output" # Path to the volume dir in your linux system for mapping 


docker container stop "$CONTAINER_NAME"
docker rm "$CONTAINER_NAME"

sudo rm -rf "$PUPLIC_DIR"
docker voulume prune

docker rmi "$IMAGE_NAME"
