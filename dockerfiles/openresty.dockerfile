FROM base

RUN apt update \
    && apt install -y \
       build-essential \
       libpcre3 libpcre3-dev \
       libssl-dev \
       zlib1g zlib1g-dev \
       perl \
    && rm -rf /var/lib/apt/lists/*


ARG OPENRESTY=openresty-1.31.8.1

RUN cd /usr/local/src \
    && curl -LO https://openresty.org/download/${OPENRESTY}.tar.gz \
    && tar xzf ${OPENRESTY}.tar.gz \
    && cd ${OPENRESTY} \
    && ./configure \
       --prefix=/usr/local/openresty \
       --with-http_ssl_module \
       --with-http_v2_module \
       --with-http_realip_module \
       --with-http_stub_status_module \
       --with-threads \
       --with-luajit \
    && make -j$(nproc) \
    && make install \
    && /usr/local/openresty/bin/opm get ledgetech/lua-resty-http \
       p0pr0ck5/lua-resty-cookie \
    && rm -rf /usr/local/src/*


ENV PATH="/usr/local/openresty/bin:${PATH}"