# FROM django

# ADD . /startup

# WORKDIR /startup

# RUN pip install -r requirements.txt

# CMD [ "python", "./manage.py runserver 0.0.0.0:8000" ]
FROM python:3.7.4-alpine3.10
ENV PYTHONBUFFERED 1
ADD startup/requirements.txt /app/requirements.txt

RUN set -ex \
    && apk add --no-cache --virtual .build-deps postgresql-dev build-base \
    && python -m venv /env \
    && /env/bin/pip install --upgrade pip \
    && /env/bin/pip install --no-cache-dir -r /app/requirements.txt \
    && runDeps="$(scanelf --needed --nobanner --recursive /env \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u)" \
    && apk add --virtual rundeps $runDeps \
    && apk del .build-deps

ADD startup /app
WORKDIR /app
EXPOSE 8080
ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

EXPOSE 8000
ENTRYPOINT ["gunicorn", "--bind", ":8080", "--workers", "3", "startup.wsgi:application"]