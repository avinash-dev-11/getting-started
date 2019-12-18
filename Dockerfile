FROM python:3.6
COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt
ENTRYPOINT ["python3"]
#RUN ["collector.py"]
#RUN git clone https://username:password@github.com/username/repository.git
RUN ["main.py"]