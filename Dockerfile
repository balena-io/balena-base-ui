FROM resin/resin-base:v4.4.1

ENV NGINX_VERSION 1.12.1-1~stretch
ENV YARN_VERSION=0.27.5-1

# Note: We make sure we drop the sks-keyservers CA cert from our prod images after it's
#       been used to get the keys for Nginx
RUN wget https://sks-keyservers.net/sks-keyservers.netCA.pem -O /usr/local/share/ca-certificates/sks-keyservers.crt \
	&& update-ca-certificates \
	&& echo 'deb http://deb.debian.org/debian jessie main' >> /etc/apt/sources.list \
	&& apt-get update -y \
	&& apt-key adv --keyserver hkps://hkps.pool.sks-keyservers.net --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
	&& wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list \
	&& echo 'deb http://nginx.org/packages/debian/ stretch nginx' >> /etc/apt/sources.list \
	&& apt-get update -y \
	&& apt-get -t jessie install rpl \
	&& apt-get install yarn=${YARN_VERSION} google-chrome-stable nginx=${NGINX_VERSION} -y \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /usr/local/share/ca-certificates/sks-keyservers.crt \
	&& update-ca-certificates
