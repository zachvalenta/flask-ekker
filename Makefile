.PHONY: test

help:
	@echo
	@echo "🍶  FLASK"
	@echo
	@echo "flask:     	start app"
	@echo "routes:     	list all routes"
	@echo "index:     	route - index"
	@echo "clouds:     	route - static asset"
	@echo "404:     	route - error page"
	@echo "add:     	route - form page"
	@echo "seed:     	open repl w/ database seeded"
	@echo
	@echo "🛠  TOOLING"
	@echo
	@echo "fmt:     	auto format code using Black"
	@echo "lint:    	lint using flake8"
	@echo "repl:    	debug using bpython"
	@echo "secure:  	security check using Bandit"
	@echo
	@echo "📦 DEPENDENCIES"
	@echo
	@echo "freeze:   	freeze dependencies into requirements.txt"
	@echo "install:   	install dependencies from requirements.txt"
	@echo "reset:   	remove any installed pkg *not* in requirements.txt"
	@echo

seed:
	qing local.db; source venv/bin/activate; bpython -i db-shell.py

flask:
	source venv/bin/activate; flask run

routes:
	python3 -c "from application import app; import pprint; pp = pprint.PrettyPrinter(indent=4); pp.pprint(app.url_map._rules[1:])"

index:
	qiu -po 5000

clouds:
	qiu -po 5000 -pa static/clouds.jpeg

404:
	qiu -po 5000 -pa foo

add:
	qiu -po 5000 -pa add

fmt:
	black src test application.py

repl:
	bpython

secure:
	bandit -r src

lint:
	flake8 src application.py

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
