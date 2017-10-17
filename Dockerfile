FROM resin/resin-base:v2.9.1 AS base

ENV NGINX_VERSION 1.12.1-1~jessie
ENV YARN_VERSION=0.27.5-1

RUN wget https://sks-keyservers.net/sks-keyservers.netCA.pem -O /usr/local/share/ca-certificates/sks-keyservers.crt \
	&& update-ca-certificates \
	&& apt-get update -y \
  && apt-get install gnupg-curl -y

RUN apt-key adv --keyserver hkps://hkps.pool.sks-keyservers.net --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
	&& wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list \
	&& echo 'deb http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list \
	&& apt-get update -y \
	&& apt-get install yarn=${YARN_VERSION} google-chrome-stable rpl nginx=${NGINX_VERSION} -y \
	&& rm /etc/init.d/nginx \
	&& rm -rf /var/lib/apt/lists/* \
	# Make sure we drop the sks-keyservers CA cert from our prod images
	&& rm /usr/local/share/ca-certificates/sks-keyservers.crt \
	&& update-ca-certificates
