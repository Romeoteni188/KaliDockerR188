ARG KALI_IMAGE=kalilinux/kali-rolling
FROM ${KALI_IMAGE} AS base

LABEL maintainer="Erwin Romeo <tu@email>"
LABEL org.opencontainers.image.title="auditoria-docker"
LABEL org.opencontainers.image.description="Imagen Docker para auditorías y pentesting (nmap, ffuf, sqlmap, nikto, wpscan, hydra, dirb, whatweb, metasploit...)."

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

ARG VERSION=0.1.0
LABEL version=$VERSION

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      wget \
      git \
      sudo \
      gnupg \
      python3 \
      python3-pip \
      ruby \
      ruby-dev \
      build-essential \
      libssl-dev \
      zlib1g-dev \
      libxml2 \
      libxslt1.1 \
      libcurl4-openssl-dev \
      nmap \
      ffuf \
      nikto \
      sqlmap \
      wpscan \
      hydra \
      dirb \
      whatweb \
      metasploit-framework \
      jq \
      vim \
      less \
      net-tools \
      iputils-ping \
    && pip3 install --no-cache-dir \
      virtualenv \
    && gem install bundler --no-document || true \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root
ENV PATH="/root/.local/bin:${PATH}"

ENTRYPOINT ["/bin/bash"]
