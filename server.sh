#! /bin/env bash

docker run --rm \
    -it \
    -p 8181:8181 \
    -v $PWD:/opa-playground \
    openpolicyagent/opa \
    run --server -c /opa-playground/config.yaml --log-level debug
