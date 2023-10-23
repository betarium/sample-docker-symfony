FROM php:8.1.21-apache-bullseye

RUN adduser --disabled-password vscode

RUN apt-get update

RUN apt install -y sudo
RUN apt install -y openssh-client
RUN apt install -y git
RUN apt install -y vim

#support nopass sudo
RUN echo "vscode    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/vscode
RUN chmod 0440 /etc/sudoers.d/vscode

#startup config
COPY docker-entry.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entry.sh

WORKDIR /workspace

USER vscode

CMD ["docker-entry.sh"]
