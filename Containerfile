FROM us.kheeper.com/bootc/server:45

COPY sysusers_admin.conf /usr/lib/sysusers.d/admin.conf
COPY --chmod=0400 sudoers_admin /etc/sudoers.d/admin
COPY tmpfiles_admin_authorized_keys /usr/lib/tmpfiles.d/admin.conf

RUN visudo -cf /etc/sudoers.d/admin && bootc container lint
