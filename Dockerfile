FROM balena/open-balena-base:armv7-fin

ENV NGINX_VERSION=1.14.1-1~bpo9+1
ENV YARN_VERSION=0.27.5-1

# Does not install Chrome in the ARM7 build
RUN echo 'deb http://deb.debian.org/debian stretch-backports main' >> /etc/apt/sources.list

RUN echo 'deb http://deb.debian.org/debian jessie main' >> /etc/apt/sources.list \
	&& wget -q -O - https://nginx.org/keys/nginx_signing.key | apt-key add - \
	&& wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list

RUN	apt-get update -y

RUN apt-get install nginx-full=${NGINX_VERSION} \
	libnginx-mod-http-auth-pam=${NGINX_VERSION} \
	libnginx-mod-http-dav-ext=${NGINX_VERSION} \
	libnginx-mod-http-echo=${NGINX_VERSION} \
	libnginx-mod-http-geoip=${NGINX_VERSION} \
	libnginx-mod-http-image-filter=${NGINX_VERSION} \
	libnginx-mod-http-subs-filter=${NGINX_VERSION} \
	libnginx-mod-http-upstream-fair=${NGINX_VERSION} \
	libnginx-mod-http-xslt-filter=${NGINX_VERSION} \
	libnginx-mod-mail=${NGINX_VERSION} \
	libnginx-mod-stream=${NGINX_VERSION} \
	nginx-common=${NGINX_VERSION} \
	nginx=${NGINX_VERSION} -y

RUN apt-get install yarn=${YARN_VERSION} -y \
	&& apt-get -t jessie install rpl \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /var/lib/apt/lists/*
