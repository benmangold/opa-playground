#! /bin/env bash

cd "$(dirname "$0")"

source .env

docker run --rm \
    -d \
    -p 8181:8181 \
    -v $PWD:/$VOLUME_MOUNT_TARGET \
    $OPA_DOCKER_IMAGE \
    run --server -c $VOLUME_MOUNT_TARGET/config.yaml

docker ps | grep $OPA_DOCKER_IMAGE;