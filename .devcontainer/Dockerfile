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

# Install xdebug3
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.mode = debug" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.client_port = 9003" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.log = /tmp/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && rm -rf /tmp/pear

# Install composer
RUN curl -sSL https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer

# Install symfony-cli
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
RUN apt install symfony-cli

#custom apache config
RUN cp /etc/apache2/conf-available/docker-php.conf docker-php.conf.bak
COPY docker-php.conf /etc/apache2/conf-available/

RUN cp /etc/apache2/sites-available/000-default.conf 000-default.conf.bak
COPY 000-default.conf /etc/apache2/sites-available/

#startup config
COPY docker-entry.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entry.sh

WORKDIR /workspace

USER vscode

CMD ["docker-entry.sh"]
