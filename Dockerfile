FROM python:3.11-slim

LABEL author="Sebas"

SHELL ["/bin/bash", "-c"]

WORKDIR /apps/api_data

# Crear el entorno virtual
RUN python3 -m venv apiEnv

# Activar el entorno virtual y actualizar pip
RUN source apiEnv/bin/activate && pip install --upgrade pip

# Copiar requirements.txt e instalar dependencias
COPY ./requirements.txt ./
RUN source apiEnv/bin/activate && pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente
COPY ./src ./src

# Exponer el puerto
EXPOSE 5001

# Comando para ejecutar la aplicación
CMD ["bash", "-c", "source apiEnv/bin/activate && uwsgi -w src.api_data:app --http-socket 0.0.0.0:5001"]