FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    bash \
    sudo \
    && apt-get clean

COPY ../setup.sh /setup.sh

RUN chmod +x /setup.sh

CMD [ "bash" ]

