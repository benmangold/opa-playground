# opa-playgroud

## makefile commands

requires curl,  make, docker

`make` - print make targets

`make install` - install opa and conftest binaries in project root. requries curl

`make test` - run `conftest docker` policy tests. requires docker

## opa-docker

requires docker

```bash
./opa-docker/command.sh help # pass one-word commands to opa in docker
./opa-docker/command.sh "run --server --log-level debug" # pass complex commands to opa in docker
./opa-docker/shell.sh # open interactive opa shell in docker
./opa-docker/server.sh # open local opa server in docker. runs in terminal
./opa-docker/server-detached.sh # open local opa server in docker. runs in background

```

server is configured via `./opa-docker/config.yaml`

## conftest-docker

requires docker

running rego policies against github action workflows

```bash
./conftest-docker/test.sh # run github actions policy tests in docker
```

