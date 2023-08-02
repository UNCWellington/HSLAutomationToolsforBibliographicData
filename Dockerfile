# FROM python:3.10-alpine
FROM python:3.8-slim

USER root

ENV FLASK_APP flasky.py
ENV FLASK_CONFIG docker

# RUN adduser -D flasky
# USER flasky

WORKDIR /home/flasky

COPY requirements requirements
RUN python -m venv venv
RUN venv/bin/pip install -r requirements/requirements.txt

COPY app app
COPY migrations migrations
COPY results results
COPY tests tests
COPY uploads uploads

COPY flasky.py config.py boot.sh run_flask.sh ./
# runtime configuration
EXPOSE 5000

# ENTRYPOINT ["./boot.sh"]
#  change the permission of the bash file by chmod +x run_flask.sh before calling ENTRYPOINT
RUN chmod +x run_flask.sh
RUN useradd flasky
RUN mkdir /home/flasky/nltk_data
RUN chmod 777 /home/flasky/nltk_data
USER flasky
ENTRYPOINT ["./run_flask.sh"]
