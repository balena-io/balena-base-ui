FROM resin/resin-base:v4.2.1

ENV NGINX_VERSION 1.12.1-1~stretch
ENV YARN_VERSION=0.27.5-1

RUN wget -q -O - https://nginx.org/keys/nginx_signing.key | apt-key add - \
	&& apt-key fingerprint 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 | (grep "573B FD6B 3D8F BC64 1079  A6AB ABF5 BD82 7BD9 BF62" || false) \
	&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo 'deb http://deb.debian.org/debian jessie main' >> /etc/apt/sources.list \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
	&& echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list \
	&& echo 'deb http://nginx.org/packages/debian/ stretch nginx' >> /etc/apt/sources.list \
	&& apt-get update -y \
	&& apt-get -t jessie install rpl \
	&& apt-get install yarn=${YARN_VERSION} google-chrome-stable nginx=${NGINX_VERSION} -y \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /var/lib/apt/lists/*
