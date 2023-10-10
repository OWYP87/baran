#/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Please provide 1 arg with a image version"
  echo "Example: $0 1.0.0"
  exit 1
else
  export IMAGE_VERSION="$1" 
fi

export AWS_PROFIL="swissborg"
export DOCKER_REGISTRY="363685691972.dkr.ecr.eu-west-1.amazonaws.com"
export COMPONENT="swissborg-app"
export DOCKER_IMAGE_URL="${DOCKER_REGISTRY}/${COMPONENT}"

aws ecr get-login-password --region eu-west-1 --profile swissborg  | docker login --username AWS --password-stdin ${DOCKER_REGISTRY}

docker build -f Dockerfile --tag ${COMPONENT}:${IMAGE_VERSION} .
docker tag ${COMPONENT}:${IMAGE_VERSION} ${DOCKER_IMAGE_URL}:${IMAGE_VERSION}
docker push ${DOCKER_IMAGE_URL=}:${IMAGE_VERSION}
