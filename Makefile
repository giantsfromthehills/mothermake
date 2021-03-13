export SHELL = /bin/bash
export GITHUB_ORG ?= "giantsfromthehills"

VERSION_TAG = $(shell git rev-parse --short HEAD)
GIT_ROOT = $(shell git rev-parse --show-toplevel)

SEMGREP_RULES_DIR ?= $(GIT_ROOT)/semgrep-rules
SRC ?= $(GIT_ROOT)/packages

SEMGREP := docker run --rm -v "$(SEMGREP_RULES_DIR):/rules" -v "$(SRC):/src" returntocorp/semgrep --config=/rules /src

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

$(SEMGREP_RULES_DIR):
	@mkdir $(SEMGREP_RULES_DIR)

.PHONY: semgrep
semgrep: $(SEMGREP_RULES_DIR)
	$(SEMGREP)
