FROM balena/open-balena-base:v11.3.11

ENV NGINX_VERSION 1.18.0-1~buster

# Note that we stop nginx from being available in systemd, as we run it manually in downstream images
RUN wget -q -O - https://nginx.org/keys/nginx_signing.key | apt-key add - \
	&& echo 'deb http://nginx.org/packages/debian/ buster nginx' >> /etc/apt/sources.list \
	&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
	&& apt-get update -y \
	&& apt-get install rpl google-chrome-stable nginx=${NGINX_VERSION} -y \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /var/lib/apt/lists/* \
	&& systemctl mask nginx.service
