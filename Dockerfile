FROM gentoo/portage as portage

FROM gentoo/stage3-amd64
COPY --from=portage /var/db/repos/gentoo/ /var/db/repos/gentoo/
RUN emerge -q sys-devel/crossdev
RUN mkdir -p /usr/local/portage-crossdev/{profiles,metadata} && \
    echo 'crossdev' > /usr/local/portage-crossdev/profiles/repo_name && \
    echo 'masters = gentoo' > /usr/local/portage-crossdev/metadata/layout.conf && \
    mkdir -p /etc/portage/repos.conf && \
    echo '[crossdev]' > /etc/portage/repos.conf/crossdev.conf && \
    echo 'location = /usr/local/portage-crossdev' >> /etc/portage/repos.conf/crossdev.conf && \
    echo 'priority = 10' >> /etc/portage/repos.conf/crossdev.conf && \
    echo 'masters = gentoo' >> /etc/portage/repos.conf/crossdev.conf && \
    echo 'auto-sync = no' >> /etc/portage/repos.conf/crossdev.conf && \
    crossdev -t aarch64-unknown-linux-gnu
RUN emerge -q dev-vcs/git sys-devel/bc sys-fs/dosfstools sys-block/parted

RUN mkdir /mnt/gentoo

VOLUME /work
WORKDIR /work

COPY ./entrypoint.sh /
ENTRYPOINT /entrypoint.sh

