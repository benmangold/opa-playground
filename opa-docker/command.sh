#! /bin/env bash

cd "$(dirname "$0")"

source .env

docker run --rm \
    -it \
    -v $PWD:/opa-playground \
    $OPA_DOCKER_IMAGE \
    $1