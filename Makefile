.PHONY: test

help:
	@echo
	@echo "🛣  APP"
	@echo
	@echo "index:     	route - index"
	@echo "start:     	start app"
	@echo
	@echo "🛠  TOOLING"
	@echo
	@echo "fmt:     	auto format code using Black"
	@echo "lint:    	lint using flake8"
	@echo "repl:    	debug using bpython"
	@echo "secure:  	security check using Bandit"
	@echo
	@echo "📊 TESTING"
	@echo
	@echo "cov:     	view HTML coverage report in browser"
	@echo "test:    	run unit tests, view basic coverage report in terminal"
	@echo
	@echo "📦 DEPENDENCIES"
	@echo
	@echo "freeze:   	freeze dependencies into requirements.txt"
	@echo "install:   	install dependencies from requirements.txt"
	@echo "reset:   	remove any installed pkg *not* in requirements.txt"
	@echo

start:
	python3 helloworld.py

index:
	qiu -po 5000 -pa index

cov:test
	coverage html; open htmlcov/index.html

fmt:
	black src test

lint:
	flake8 src

freeze:
	pip freeze > requirements.txt

install:
	pip install -r requirements.txt

reset:
	@echo "🔍 - DISCOVERING UNSAVED PACKAGES\n"
	pip freeze > pkgs-to-rm.txt
	@echo
	@echo "📦 - UNINSTALL ALL PACKAGES\n"
	pip uninstall -y -r pkgs-to-rm.txt
	@echo
	@echo "♻️  - REINSTALL SAVED PACKAGES\n"
	pip install -r requirements.txt
	@echo
	@echo "🗑  - UNSAVED PACKAGES REMOVED\n"
	diff pkgs-to-rm.txt requirements.txt | grep '<'
	@echo
	rm pkgs-to-rm.txt
	@echo

repl:
	bpython

secure:
	bandit -r src

test:
	coverage run --source='src' -m pytest -v && coverage report -m
