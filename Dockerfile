FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get dist-upgrade -y
RUN apt-get install -y  curl \ 
    build-essential tcl \
    unzip \
    nginx \
    libcurl4 \
    php-redis \
    php7.4 \ 
    php7.4-cli \
    php7.4-dev \
    php7.4-gmp \
    php7.4-json \
    php7.4-odbc \
    php7.4-pspell \
    php7.4-sqlite3 \
    php7.4-xmlrpc \
    php7.4-bcmath \
    php7.4-common \
    php7.4-enchant \
    php7.4-imap \
    php7.4-ldap \
    php7.4-opcache \
    php7.4-readline \
    php7.4-sybase \
    php7.4-xsl \
    php7.4-bz2 \
    php7.4-curl \
    php7.4-fpm \
    php7.4-interbase \
    php7.4-mbstring \
    php7.4-pgsql \
    php7.4-snmp \
    php7.4-tidy \
    php7.4-zip \
    php7.4-xml \
    php7.4-soap \
    php7.4-phpdbg \
    php7.4-mysql \
    php7.4-intl \
    php7.4-gd \
    php7.4-dba \
    php7.4-cgi \
    mysql-server \
    mysql-client \
    rar \
    net-tools \
    build-essential \
    g++ \
    vim \
    openssh-server \
    nano \ 
    git \
    supervisor \
    vim \
    net-tools 
ENV MYSQL_PWD qwerty
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
RUN mkdir -p /var/cache/php-fpm/DoctrineMongoODMModule/Proxy
run mkdir -p /var/cache/php-fpm/DoctrineMongoODMModule/Hydrator
run chmod 777 -R /var/cache/
RUN apt-get -y install mysql-server 
RUN useradd -s /bin/bash sites
RUN mkdir -p /var/www/sites/web
ADD conf/supervisord.conf /etc/supervisord.conf
ADD start.sh /start.sh
RUN chmod 777 /start.sh
ADD index.php /var/www/sites/web
ADD site /etc/nginx/sites-available/
RUN rm -r /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/
RUN echo "clear_env = no" >> /etc/php/7.4/fpm/php-fpm.conf
#CREATING A SOCKET FILE TO START FPM FROM SUPERVISORD
RUN service php7.4-fpm start
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
ADD php-fpm  /var/log/
RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /etc/php/7.4/cli/php.ini
RUN echo "extension=mongodb.so" >> /etc/php/7.4/fpm/php.ini
CMD ["/bin/bash","start.sh"]
MAINTAINER "CLGJ DEV" <catcoder.php@gmail.com>
