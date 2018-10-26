FROM balena/open-balena-base:v4.5.0

ENV NGINX_VERSION 1.12.1-1~stretch
ENV YARN_VERSION=0.27.5-1

RUN echo 'deb http://deb.debian.org/debian jessie main' >> /etc/apt/sources.list \
	&& wget -q -O - https://nginx.org/keys/nginx_signing.key | apt-key add - \
	&& echo 'deb http://nginx.org/packages/debian/ stretch nginx' >> /etc/apt/sources.list \
	&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
	&& wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list \
	&& apt-get update -y \
	&& apt-get -t jessie install rpl \
	&& apt-get install yarn=${YARN_VERSION} google-chrome-stable nginx=${NGINX_VERSION} -y \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /var/lib/apt/lists/*
