FROM nvidia/cuda:10.2-base-ubi8

RUN dnf install -y unzip zip curl wget file  \
    && rm -r /var/cache/dnf

COPY kumato-init /kumato-init
