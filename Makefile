
.DEFAULT_GOAL := help

# default target, prints help info

help:
	@ echo """ \
	welcome to opa-playground \n \n \
	make install             = install opa and conftest binaries in project root. requires curl \n \
	make opa-server          = start opa server at localhost:8181 in current terminal. requires docker \n \
	make opa-server-detached = start opa server at localhost:8181 in background. requires docker \n \
	\
	"""

# installing binaries, not actually used

install: install-opa install-conftest

install-conftest:
	mkdir tmp; \
	curl -L -o tmp/conftest.tar.gz https://github.com/open-policy-agent/conftest/releases/download/v0.24.0/conftest_0.24.0_Linux_x86_64.tar.gz; \
	cd tmp; tar xvf conftest.tar.gz; cd ..; \
	mv tmp/conftest ./conftest; \
	chmod 755 ./conftest; \
	rm -rf tmp; \
	./conftest --help;

install-opa:
	curl -L -o opa https://openpolicyagent.org/downloads/v0.28.0/opa_linux_amd64; \
	chmod 755 ./opa; \
	./opa --help;

# local opa server

opa-server:
	./opa-docker/server.sh

opa-server-detached:
	./opa-docker/server-detached.sh;

# local conftest tests

test:
	./conftest-docker/test.sh
