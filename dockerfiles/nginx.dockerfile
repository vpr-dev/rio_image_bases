# `base` is supplied by compose as a named build context pointing at the
# `base` service (see docker-compose-local.yml), so it is always up to date.
FROM base

COPY configs/nginx.list.noble /rioapp/nginx.list

RUN apt-get update \
    && apt-get install -y gnupg \
    # gunpg is for `apt-get add` command
    && mv nginx.list /etc/apt/sources.list.d/ \
    && wget http://nginx.org/keys/nginx_signing.key \
    && apt-key add nginx_signing.key \
    && apt-get update \
    && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/* \
    && rm nginx_signing.key