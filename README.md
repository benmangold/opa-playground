# opa-playground

playing around with open policy agent in docker

open a local opa server or an opa shell

requires docker

## scripts

`server.sh` - open local opa server in docker.  runs on `localhost:8081`. `$PWD` is mounted to `/opa-playground`.  `config.yaml` is used to configure the opa.

```bash
./server.sh
# server starts and logs to current terminal

```

`shell.sh` - open an opa shell in docker.

```bash
./shell.sh
OPA 0.28.0 (commit 3fbcd71, built at 2021-04-27T13:51:01Z)

Run 'help' to see a list of commands and check for updates.

> 

```

`opa-command.sh` - run a command against opa binary in Docker. first argument is passed to opa binary in docker.

```bash
./opa-command.sh help

./opa-command.sh run

./opa-command.sh "run --server -c /opa-playground/config.yaml --log-level debug"

```

## ideas

### procedure for applying polcies for yaml github workflows

policy = must pin versions on upstream workflows.  all `uses` keys must have a `value` that includes `@*`.

example workflows:

Simple one step

```yaml
# https://github.com/marketplace/actions/docker-login
name: ci

on:
  push:
    branches: master

jobs:
  login:
    runs-on: ubuntu-latest
    steps:
      - name: Login to Docker Hub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

```

Two step, one action untagged

```yaml
# https://github.com/marketplace/actions/docker-login
name: ci

on:
  push:
    branches: master

jobs:
  login:
    runs-on: ubuntu-latest
    steps:
      - name: Login to Docker Hub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      # Configures the node version used on GitHub-hosted runners
      - uses: actions/setup-node
        with:
        # The Node.js version to configure
        node-version: 12


```

1) Turn yaml workflow into JSON for OPA input data:

```json
{
   "name": "ci",
   "on": {
      "push": {
         "branches": "master"
      }
   },
   "jobs": {
      "login": {
         "runs-on": "ubuntu-latest",
         "steps": [
            {
               "name": "Login to Docker Hub",
               "uses": "docker/login-action@v1",
               "with": {
                  "username": "${{ secrets.DOCKERHUB_USERNAME }}",
                  "password": "${{ secrets.DOCKERHUB_TOKEN }}"
               }
            }
         ]
      }
   }
}

```

```json
{
   "name": "ci",
   "on": {
      "push": {
         "branches": "master"
      }
   },
   "jobs": {
      "login": {
         "runs-on": "ubuntu-latest",
         "steps": [
            {
               "name": "Login to Docker Hub",
               "uses": "docker/login-action@v1",
               "with": {
                  "username": "${{ secrets.DOCKERHUB_USERNAME }}",
                  "password": "${{ secrets.DOCKERHUB_TOKEN }}"
               }
            },
            {
               "uses": "actions/setup-node",
               "with": null,
               "node-version": 12
            }
         ]
      }
   }
}
```


[Magic yaml > json site](https://www.convertjson.com/yaml-to-json.htm)

This JSON is configured as `Input Data (JSON)` in the opa server ui.

### working queries

These queries can be configured as `Query` in the opa ui

Verifying upstream GitHub Actions are pinned with a tag

```rego
jobs := input["jobs"][_]["steps"][_]["uses"]

pins := re_match("@.*", jobs)

```

name := input.name

name == "ci"

stepsArray := input.jobs.login

stepsArray[0]

### use conftest to parse yaml


### misc

random rego snippets

```rego
name := input.name

name == "ci"

steps = input.jobs.login.steps[0]

agents := input.jobs[_]["runs-on"]

```