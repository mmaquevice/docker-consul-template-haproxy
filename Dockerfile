FROM ubuntu:14.04

RUN apt-get update && apt-get install -y curl

ENV HAPROXY_MAJOR 1.6
ENV HAPROXY_VERSION 1.6.2
ENV HAPROXY_MD5 d0ebd3d123191a8136e2e5eb8aaff039

# see http://sources.debian.net/src/haproxy/1.5.8-1/debian/rules/ for some helpful navigation of the possible "make" arguments
RUN buildDeps='curl gcc libc6-dev libpcre3-dev libssl-dev make' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& curl -SL "http://www.haproxy.org/download/${HAPROXY_MAJOR}/src/haproxy-${HAPROXY_VERSION}.tar.gz" -o haproxy.tar.gz \
	&& echo "${HAPROXY_MD5}  haproxy.tar.gz" | md5sum -c \
	&& mkdir -p /usr/src/haproxy \
	&& tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 \
	&& rm haproxy.tar.gz \
	&& make -C /usr/src/haproxy \
		TARGET=linux2628 \
		USE_PCRE=1 PCREDIR= \
		USE_OPENSSL=1 \
		USE_ZLIB=1 \
		all \
		install-bin \
	&& mkdir -p /usr/local/etc/haproxy \
	&& cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors \
	&& rm -rf /usr/src/haproxy \
	&& apt-get purge -y --auto-remove $buildDeps

ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD startup.sh /startup.sh
RUN chmod u+x /startup.sh
ADD hap.sh /hap.sh
RUN chmod u+x /hap.sh
RUN useradd haproxy -s /sbin/nologin


RUN curl -L -o /tmp/consul-template https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz && \
  cd /tmp && \
  tar -xf consul-template && \
  cp consul-template_0.7.0_linux_amd64/consul-template /usr/local/bin/consul-template && \
  chmod a+x /usr/local/bin/consul-template

ADD haproxy.template /etc/haproxy/haproxy.template

WORKDIR /

CMD ["/startup.sh"]
