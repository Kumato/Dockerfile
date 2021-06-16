FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

COPY kumato /bin/kumato
COPY S10c.crt S10c.key /etc/kumato/

ENTRYPOINT ["kumato"]
