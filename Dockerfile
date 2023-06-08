FROM python:3.9-slim AS deps

WORKDIR /app

RUN apt-get update && apt-get install -y gcc g++

RUN python3 -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

COPY ./requirements.txt .

RUN pip3 install -r requirements.txt

FROM python:3.9-slim AS runner

WORKDIR /app

COPY --from=deps /opt/venv /opt/venv
COPY app.py htmlTemplates.py .env ./

ENV PATH="/opt/venv/bin:$PATH"
