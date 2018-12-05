FROM ubuntu:xenial

# reqired packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y nano apt-utils lsb-release ca-certificates unzip locales \
	mtools genisoimage debirf
	# && \
	# rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8' TERM=screen

RUN mkdir /debirf
WORKDIR /debirf
COPY start.sh /debirf

ADD minimal.tgz /debirf

RUN echo 'DEBIRF_LABEL="debirf-minimal"' >> /debirf/minimal/debirf.conf
RUN echo 'DEBIRF_SUITE=xenial' >> /debirf/minimal/debirf.conf
RUN echo 'DEBIRF_DISTRO=ubuntu' >> /debirf/minimal/debirf.conf
RUN echo 'DEBIRF_EXTRA_PACKAGES=nano,cpio' >> /debirf/minimal/debirf.conf

RUN sed -i "65idebirf_exec sh -c 'sed -i \"s/main/main universe security/\" /etc/apt/sources.list'" /debirf/minimal/modules/a0_prep-root
RUN sed -i "70idebirf_exec sh -c 'if [ ! -e /bin/insserv ]; then ln -s /usr/lib/insserv/insserv /bin/insserv; fi'" /debirf/minimal/modules/a0_prep-root
RUN sed -i "14imkdir -p \${DEBIRF_ROOT}/etc/network" /debirf/minimal/modules/network

CMD ["/bin/bash", "/debirf/start.sh"]
