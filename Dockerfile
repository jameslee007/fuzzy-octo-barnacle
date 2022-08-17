FROM python:3.7
RUN mkdir /app 
COPY . /app
COPY pyproject.toml /app 
WORKDIR /app
RUN chmod 755 run.sh
ENV PYTHONPATH=${PYTHONPATH}:${PWD} 
RUN pip3 install poetry
RUN pip3 install backports.zoneinfo importlib-resources
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
EXPOSE 8793
CMD ["/app/run.sh"]
