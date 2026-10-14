FROM balena/open-balena-base:v22.0.3-s6-overlay@sha256:1a55320b1c345a4a09ad096221785c1ab33e3eec0cb4f69c89360136586af6aa

# Install gnupg to allow us to add the nginx signing key
# hadolint ignore=DL3008
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		gnupg \
	&& rm -rf /var/lib/apt/lists/*

# renovate: datasource=repology depName=debian_13/nginx versioning=loose
ARG NGINX_VERSION=1.28.0-1~trixie

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN wget -q -O /etc/apt/trusted.gpg.d/nginx.asc https://nginx.org/keys/nginx_signing.key \
	&& echo 'deb http://nginx.org/packages/debian/ trixie nginx' >> /etc/apt/sources.list \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends rpl chromium nginx=${NGINX_VERSION} \
	&& rm /etc/init.d/nginx \
	&& rm -rf /etc/nginx/conf.d/* \
	&& rm -rf /etc/nginx/sites-available/* \
	&& rm -rf /etc/nginx/sites-enabled/* \
	&& rm -rf /var/lib/apt/lists/*
