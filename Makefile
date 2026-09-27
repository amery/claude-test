.PHONY: all check env-check

all: check

check:
	node --check src/cart.js

env-check:
	sh scripts/env-check.sh
