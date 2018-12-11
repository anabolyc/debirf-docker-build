FROM ubuntu:disco

# reqired packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y nano apt-utils lsb-release ca-certificates unzip locales dbus systemd strace \
	mtools genisoimage debirf
	# && \
	# rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8' TERM=screen

RUN mkdir /debirf
ADD rescue.tgz /debirf

WORKDIR /debirf/rescue

# general debootstrap settings
RUN echo 'DEBIRF_LABEL="debirf-rescue"' >> /debirf/rescue/debirf.conf
RUN echo 'DEBIRF_SUITE=disco' >> /debirf/rescue/debirf.conf
RUN echo 'DEBIRF_DISTRO=ubuntu' >> /debirf/rescue/debirf.conf
#RUN echo 'DEBIRF_EXTRA_PACKAGES=nano,cpio,dbus' >> /debirf/rescue/debirf.conf
RUN echo 'DEBIRF_COMPONENTS=main,universe' >> /debirf/rescue/debirf.conf

# scripts fixups
RUN sed -i "117i   if [ \"\$DEBIRF_COMPONENTS\" ] ; then OPTS=\"--components='\$DEBIRF_COMPONENTS' \$OPTS\"; fi\n" $(which debirf)

RUN if [ -f "/debirf/rescue/modules/install-kernel" ] ; then \
		sed -i "54iKMPKG=\$(basename \"\$DEBIRF_ROOT\"/var/cache/apt/archives/linux-modules-*)" /debirf/rescue/modules/install-kernel ; \
		sed -i "57idebirf_exec dpkg --extract /var/cache/apt/archives/\"\$KMPKG\" /" /debirf/rescue/modules/install-kernel ; \
	fi
RUN if [ -f "/debirf/rescue/modules/network" ] ; then \
		sed -i "30s/.*/debirf_exec systemctl disable systemd-resolved.service \&\& debirf_exec systemctl enable systemd-resolved.service/" /debirf/rescue/modules/network ; \
	fi

# custom modules
ADD install-desktop /debirf/rescue/modules

# start build
COPY build.sh /debirf/rescue
CMD ["/bin/bash"]



