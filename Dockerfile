#FROM python:3.6
FROM google/cloud-sdk:latest
#RUN apt-get update -y
#RUN apt-get install -y python3 python3-pip curl
COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt
EXPOSE 8080
#RUN chmod +x hello.sh
ENTRYPOINT ["python3"]
#RUN ./hello.sh
#RUN git clone https://username:password@github.com/username/repository.git
RUN python3 collector.py && python3 main.py