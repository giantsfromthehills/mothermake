export SHELL = /bin/bash
export GITHUB_ORG ?= "giantsfromthehills"

node_modules:
	yarn

.PHONY: test
test: node_modules
	yarn test

.PHONY: build
build: node_modules
	yarn build
	
.PHONY: lint
lint: node_modules
	yarn lint
