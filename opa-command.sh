#! /bin/env bash

docker run --rm \
    -it \
    -v $PWD:/opa-playground \
    openpolicyagent/opa \
    $1