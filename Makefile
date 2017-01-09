.PHONY: build coverage lint graphs tests docs clean clean_cython deploy

build:
	mkdir -p docs/modules/generated
	python setup.py build_ext --inplace

coverage:
	nosetests --logging-level=INFO --with-coverage --cover-package=discretize --cover-html
	open cover/index.html

lint:
	pylint --output-format=html discretize > pylint.html

graphs:
	pyreverse -my -A -o pdf -p discretize discretize/**.py discretize/**/**.py

tests:
	nosetests --logging-level=INFO

docs:
	cd docs;make html

clean:
	cd docs;make clean
	find . -name "*.pyc" | xargs -I {} rm -v "{}"

clean_cython: clean
	find . -name "*.c" | xargs -I {} rm -v "{}"
	find . -name "*.so" | xargs -I {} rm -v "{}"

deploy:
	python setup.py sdist bdist_wheel upload
