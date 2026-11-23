FROM balena/open-balena-base:22.2.1-s6-overlay@sha256:c0e3d6f3ac5ae2707e1e3fdf0222eaa629120e1247e03d52b9911b3d4ab5c95f

# Install gnupg to allow us to add the nginx signing key
# hadolint ignore=DL3008
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		gnupg \
	&& rm -rf /var/lib/apt/lists/*

# renovate: datasource=repology depName=debian_13/nginx versioning=loose
ARG NGINX_VERSION=1.30.7-1~trixie

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
