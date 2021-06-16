FROM registry.access.redhat.com/ubi8/ubi:latest

RUN dnf install -y unzip zip curl wget file  \
    && rm -r /var/cache/dnf

COPY kumato-init /kumato-init
