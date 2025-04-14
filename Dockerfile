FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    netcat-openbsd \
    && apt-get clean

WORKDIR /app

COPY api/requirements.txt ./

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

COPY dockerize.sh /dockerize.sh
RUN chmod +x /dockerize.sh
    

# Só copia o código depois, pra não invalidar o cache da camada anterior
COPY api/ .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]