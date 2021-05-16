#! /bin/env bash

cd "$(dirname "$0")"

docker run --rm -v $(pwd):/project openpolicyagent/conftest verify --policy pinned-actions.rego

docker run --rm -v $(pwd):/project openpolicyagent/conftest test *.yml --policy pinned-actions.rego
