FROM balena/open-balena-base:19.2.0-s6-overlay

# Install gnupg to allow us to add the nginx signing key
# hadolint ignore=DL3008
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		gnupg \
	&& rm -rf /var/lib/apt/lists/*

ENV NGINX_VERSION=1.24.0-1~bookworm

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Note that we stop nginx from being available in systemd, as we run it manually in downstream images
# hadolint ignore=DL3008
RUN wget -q -O - https://nginx.org/keys/nginx_signing.key | apt-key add - \
	&& echo 'deb http://nginx.org/packages/debian/ bookworm nginx' >> /etc/apt/sources.list \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends rpl chromium nginx=${NGINX_VERSION} \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /etc/nginx/sites-available/* \
	&& rm -rf /etc/nginx/sites-enabled/* \
	&& rm -rf /var/lib/apt/lists/*
