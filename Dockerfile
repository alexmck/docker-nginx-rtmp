# Use an official Ubuntu runtime as a parent image
FROM ubuntu:22.04

ENV NGINX_VERSION nginx-1.23.2
ENV NGINX_RTMP_MODULE_VERSION 1.2.2-r1

RUN apt-get update && \
	apt-get -y install gcc make libpcre3 libpcre3-dev libssl-dev zlib1g-dev wget && \
	apt install -y git apache2-utils build-essential ffmpeg libpcre3 libpcre3-dev libssl-dev zlib1g-dev

WORKDIR /tmp

RUN wget http://nginx.org/download/${NGINX_VERSION}.tar.gz && \
	wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/v${NGINX_RTMP_MODULE_VERSION}.tar.gz

RUN tar -zxvf ${NGINX_VERSION}.tar.gz && tar -zxvf v${NGINX_RTMP_MODULE_VERSION}.tar.gz

WORKDIR /tmp/${NGINX_VERSION}

#RUN ./configure --with-http_ssl_module && make && make install
#nginx-rtmp-module-1.2.2-r1\ #--add-module=../nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} && \
#	make && make install
RUN ./configure --prefix=/usr/share/nginx \
--sbin-path=/usr/sbin/nginx \
--modules-path=/usr/lib/nginx/modules \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/run/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--user=www-data \
--group=www-data \
--with-compat \
--with-file-aio \
--with-threads \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_mp4_module \
--with-http_random_index_module \
--with-http_realip_module \
--with-http_slice_module \
--with-http_ssl_module \
--with-http_sub_module \
--with-http_stub_status_module \
--with-http_v2_module \
--with-http_secure_link_module \
--add-module=../nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} \
--with-mail \
--with-mail_ssl_module \
--with-stream \
--with-stream_realip_module \
--with-stream_ssl_module \
--with-stream_ssl_preread_module && \
make -j$((`nproc`+1)) && \
make install

RUN rm -rf /tmp/${NGINX_VERSION} /tmp/${NGINX_VERSION}.tar.gz /tmp/v${NGINX_RTMP_MODULE_VERSION}.tar.gz /tmp/nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 1935
EXPOSE 8080

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]