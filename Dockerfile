FROM balena/open-balena-base:v12.0.3

ENV NGINX_VERSION 1.18.0-6.1

# Note that we stop nginx from being available in systemd, as we run it manually in downstream images
RUN wget -q -O - https://nginx.org/keys/nginx_signing.key | apt-key add - \
	&& echo 'deb http://nginx.org/packages/debian/ bullseye nginx' >> /etc/apt/sources.list \
	&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
	&& apt-get update -y \
	&& apt-get install rpl google-chrome-stable nginx=${NGINX_VERSION} \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /etc/nginx/sites-available/* \
	&& rm -rf /etc/nginx/sites-enabled/* \
	&& rm -rf /var/lib/apt/lists/* \
	&& systemctl mask nginx.service
