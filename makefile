mppsolar-tests: 
	python3 -m unittest discover -s tests/mppsolar_tests -f 
	
powermon-unit-tests: 
	python3 -m unittest discover -s tests/powermon_tests/unit -f -v

powermon-integration-tests: 
	python3 -m unittest discover -s tests/powermon_tests/integration -f -v

test:
	python3 -m unittest discover -s tests -f 

tests: powermon-unit-tests powermon-integration-tests mppsolar-tests

pypi:
	rm -rf dist/*
	#python3 -m build 
	./make_version.sh
	poetry build
	poetry version patch
	./make_version_dev.sh
	ls -l dist/
	cat mppsolar/version.py
	cat powermon/version.py

pypi-upload:
	twine upload dist/*

docker-up:
	docker-compose up --build

docker-powermon-dev-up:
	docker compose -f docker-compose.development.yaml up --build
