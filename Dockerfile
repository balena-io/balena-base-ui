FROM balena/open-balena-base:v17.0.11

ENV NGINX_VERSION 1.24.0-1~bookworm

# Note that we stop nginx from being available in systemd, as we run it manually in downstream images
RUN wget -q -O - https://nginx.org/keys/nginx_signing.key | apt-key add - \
	&& echo 'deb http://nginx.org/packages/debian/ bookworm nginx' >> /etc/apt/sources.list \
	&& apt-get update -y \
	&& apt-get install rpl chromium nginx=${NGINX_VERSION} \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /etc/nginx/sites-available/* \
	&& rm -rf /etc/nginx/sites-enabled/* \
	&& rm -rf /var/lib/apt/lists/* \
	&& systemctl mask nginx.service
