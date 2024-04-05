FROM python:3.12-slim

WORKDIR /code
COPY poetry.lock pyproject.toml /code/
COPY .env /code/.env

RUN apt-get update && apt-get install -y curl
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir poetry==1.7.0

RUN poetry config virtualenvs.create false
ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=0 \
    POETRY_VIRTUALENVS_CREATE=0 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

RUN touch README.md

RUN poetry install --without dev && rm -rf $POETRY_CACHE_DIR
COPY ./backend /code/backend
COPY alembic.ini /code/alembic.ini
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "80", "--reload"]
