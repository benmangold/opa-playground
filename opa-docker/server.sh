#! /bin/env bash

cd "$(dirname "$0")"

source .env

docker run --rm \
    -it \
    -p 8181:8181 \
    -v $PWD:$VOLUME_MOUNT_TARGET \
    $OPA_DOCKER_IMAGE \
    run --server -c $VOLUME_MOUNT_TARGET/config.yaml --log-level debug
