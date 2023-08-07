#!/bin/sh
deactivate
. venv/bin/activate
# source venv/bin/activate
export FLASK_APP=flasky.py
export FLASK_DEBUG=1
# flask run
flask run -h 0.0.0.0 -p 8000
gunicorn -b 0.0.0.0:8000  - flasky:app
