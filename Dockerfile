FROM luislin/mysql:5.7

RUN set -eux; \
	{ \
	echo 'max_allowed_packet=18777216'; \
	echo 'max_heap_table_size=47483648'; \
	echo 'tmp_table_size=47483648'; \
	echo 'join_buffer_size=70483648'; \
	echo 'innodb_buffer_pool_size=600483648'; \
	echo 'innodb_doublewrite=OFF'; \
	echo 'innodb_flush_log_at_timeout=5'; \
	echo 'innodb_read_io_threads=33'; \
	echo 'innodb_write_io_threads=20'; \
	echo 'innodb_buffer_pool_instances=6'; \
	} >> /etc/mysql/conf.d/docker.cn

COPY cacti.sql /docker-entrypoint-initdb.d/
COPY docker-entrypoint.sh /usr/local/bin/


ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
