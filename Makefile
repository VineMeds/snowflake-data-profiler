devserver: venv
	source ./venv/bin/activate && gunicorn --bind 0.0.0.0:5000 --timeout 3600 --workers=5 snowflake_data_profiler.wsgi:app 

venv:
	python3 -m venv venv && source ./venv/bin/activate && \
	  pip install --upgrade pip && \
	  pip install -r snowflake_data_profiler/requirements.txt

image:
	docker build --platform=linux/amd64 -t snowflake_data_profiler .

container:
	docker run  --platform=linux/amd64 -it -p 5050:5000 snowflake_data_profiler

test: venv
	source ./venv/bin/activate && pytest
