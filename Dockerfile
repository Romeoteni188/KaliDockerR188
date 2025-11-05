ARG KALI_IMAGE=kalilinux/kali-rolling
FROM ${KALI_IMAGE} AS base

LABEL maintainer="Erwin Romeo <tu@email>"
LABEL org.opencontainers.image.title="auditoria-docker"
LABEL org.opencontainers.image.description="Imagen Docker para auditorías y pentesting (nmap, ffuf, sqlmap, nikto, wpscan, hydra, dirb, whatweb, metasploit...)."
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Version
ARG VERSION=0.1.0
LABEL version=$VERSION

# tools
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
      less \
      net-tools \
      iputils-ping \
    && pip3 install --no-cache-dir \
      virtualenv \
    && gem install bundler --no-document || true \
    # limpieza
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Crear usuario no-root 'pentest'
ARG NONROOTUSER=pentest
ARG NONROOT_UID=1000
ARG NONROOT_GID=1000
RUN groupadd -g ${NONROOT_GID} ${NONROOTUSER} || true \
    && useradd -m -u ${NONROOT_UID} -g ${NONROOT_GID} -s /bin/bash ${NONROOTUSER} \
    && echo "${NONROOTUSER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${NONROOTUSER} \
    && chmod 0440 /etc/sudoers.d/${NONROOTUSER}

WORKDIR /home/${NONROOTUSER}

# Copia helpers (si los tienes). Opcional:
# COPY tools/ /opt/tools/
# RUN chown -R ${NONROOT_UID}:${NONROOT_GID} /opt/tools

# Derechos de usuario
USER ${NONROOTUSER}

# Entrypoint por defecto: shell interactiva
ENV PATH="/home/${NONROOTUSER}/.local/bin:${PATH}"
ENTRYPOINT ["/bin/bash"]
