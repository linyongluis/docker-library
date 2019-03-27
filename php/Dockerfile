FROM luislin/cacti:1.0
ADD cacti-1.2.2.tar.gz /var/www/html/

ADD rrdtool-1.7.1.tar.gz /usr/local/
ADD cacti-spine-1.2.2.tar.gz /usr/local/
RUN apt-get update && apt-get install -y --no-install-recommends \
	libpcre3-dev \
	libpango1.0-dev \
	libxml2-dev \
	libssl-dev \
	libmysql++-dev \
	help2man \
	cron \
	groff-base \
	&& rm -rf /var/lib/apt/lists/*


WORKDIR /usr/local/rrdtool-1.7.1
RUN  ./configure --prefix=/usr/local/rrdtool/ \
	&& make \
	&& make install

WORKDIR /usr/local/cacti-spine-1.2.2
RUN ./configure --prefix=/usr/local/spine/ \
	&& make \
	&& make install

WORKDIR /usr/local/spine/etc
RUN sed 's/cactiuser/cacti/g' -i spine.conf.dist

RUN /etc/init.d/cron start \
	&& echo '*/5 * * * * cactiuser php /var/www/html/cacti/poller.php > /dev/null 2>&1' >> /var/spool/cron/crontabs/root

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
