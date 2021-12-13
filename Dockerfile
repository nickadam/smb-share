FROM ubuntu:20.04

RUN apt-get update && apt-get install -y samba \
  tini

COPY --chmod=755 docker-entrypoint /

COPY --chmod=644 smb.conf /

RUN rm /etc/samba/smb.conf

VOLUME ["/data"]

EXPOSE 139/tcp 445/tcp

ENV SMB_USER=admin \
  SHARE_NAME=data \
  SMB_UID=1000 \
  SMB_GID=1000 \
  FILEMODE=644 \
  DIRMODE=755

ENTRYPOINT ["tini", "--", "/docker-entrypoint"]

CMD ["smbd", "--foreground", "--log-stdout"]
