#/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Please provide 1 arg with a image version"
  echo "Example: $0 1.0.0"
  exit 1
else
  export IMAGE_VERSION="$1" 
fi

export DOCKER_REGISTRY="szalasartur"
export COMPONENT="python-app"
export DOCKER_IMAGE_URL="${DOCKER_REGISTRY}/${COMPONENT}"

# update version and build docker image

VERSION=$1 # get version from the args
GIT_HASH=$(git rev-parse --short HEAD )

# update version.txt
echo "Version is: $VERSION" > version.txt
echo "Git hash is: $GIT_HASH" >> version.txt

# there is no login - we assume user already had logged into docker registry the main one https://hub.docker.com/

docker build -f Dockerfile --tag ${COMPONENT}:${IMAGE_VERSION} .
docker tag ${COMPONENT}:${IMAGE_VERSION} ${DOCKER_IMAGE_URL}:${IMAGE_VERSION}
docker push ${DOCKER_IMAGE_URL=}:${IMAGE_VERSION}
