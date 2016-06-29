# Thu, 09 Jun 2016 21:28:42 GMT
ADD file:76679eeb94129df23c99013487d6b6bd779d2107bf07d194a524fdbb6a961530 in /
# Thu, 09 Jun 2016 21:28:43 GMT
CMD ["/bin/bash"]
# Fri, 10 Jun 2016 01:56:57 GMT
RUN groupadd -r memcache && useradd -r -g memcache memcache
# Fri, 10 Jun 2016 01:57:52 GMT
RUN apt-get update && apt-get install -y --no-install-recommends        libevent-2.0-5  && rm -rf /var/lib/apt/lists/*
# Fri, 17 Jun 2016 22:50:05 GMT
ENV MEMCACHED_VERSION=1.4.26
# Fri, 17 Jun 2016 22:50:06 GMT
ENV MEMCACHED_SHA1=f0d4f89ead2ac48c6b9e8070178279c0a3d45559
# Fri, 17 Jun 2016 22:51:39 GMT
RUN buildDeps='         gcc         libc6-dev       libevent-dev        make        perl        wget    '   && set -x   && apt-get update && apt-get install -y $buildDeps --no-install-recommends  && rm -rf /var/lib/apt/lists/*  && wget -O memcached.tar.gz "http://memcached.org/files/memcached-$MEMCACHED_VERSION.tar.gz"    && echo "$MEMCACHED_SHA1  memcached.tar.gz" | sha1sum -c -  && mkdir -p /usr/src/memcached  && tar -xzf memcached.tar.gz -C /usr/src/memcached --strip-components=1     && rm memcached.tar.gz  && cd /usr/src/memcached    && ./configure  && make -j$(nproc)  && make install     && cd / && rm -rf /usr/src/memcached    && apt-get purge -y --auto-remove $buildDeps
# Fri, 17 Jun 2016 22:51:40 GMT
COPY file:621e178b267679ef7140edd23c3ad9e717ed767ed55322a4e198798311bc1d36 in /usr/local/bin/
# Fri, 17 Jun 2016 22:51:41 GMT
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
# Fri, 17 Jun 2016 22:51:41 GMT
ENTRYPOINT &{["docker-entrypoint.sh"]}
# Fri, 17 Jun 2016 22:51:42 GMT
USER ["memcache"]
# Fri, 17 Jun 2016 22:51:42 GMT
EXPOSE 8081/tcp
# Fri, 17 Jun 2016 22:51:43 GMT
CMD ["memcached"]
