FROM alpine AS builder

RUN apk add --update \
    make \
    git \
    g++ \
    linux-headers \
    && rm -rf /var/cache/apk/* \
    && git clone https://github.com/g4klx/MMDVMHost.git src \
    && cd /src && make -j$(nproc)
    

FROM alpine

RUN apk add --update libstdc++ libgcc && rm -rf /var/cache/apk/*

RUN mkdir -p /conf
COPY --from=builder /src/MMDVMHost /usr/bin
COPY --from=builder /src/RemoteCommand /usr/bin

RUN addgroup -g 1000 mmdvm \
    && adduser -u 1000 -G mmdvm -s /bin/sh -D mmdvm \
    && adduser mmdvm dialout \
    && chown -R mmdvm:mmdvm /conf \
    && mkdir /var/log/mmdvm \
    && chown -R mmdvm:mmdvm /var/log/mmdvm

VOLUME /conf
VOLUME /var/log/mmdvm
USER mmdvm

LABEL org.opencontainers.image.authors="Adam SQ7LRX <sq7lrx@lavabs.com>" \
      org.opencontainers.image.url="https://github.com/sq7lrx/mmdvmhost-docker" \
      org.opencontainers.image.source="https://github.com/sq7lrx/mmdvmhost-docker" \
      org.opencontainers.image.title="MMDVMHost" \
      org.opencontainers.image.description="Ham Radio MMDVMHost software by G4KLX to interface with his MMDVM modem" \
      org.opencontainers.image.vendor="SQ7LRX"

CMD ["/usr/bin/MMDVMHost", "/conf/MMDVM.ini"]