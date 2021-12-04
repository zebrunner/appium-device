FROM zebrunner/stf:2.0-beta1

ENV STF_PROVIDER_ADB_HOST appium
ENV STF_PROVIDER_ADB_PORT 5037

ENV STF_PROVIDER_PUBLIC_IP localhost
ENV STF_PROVIDER_DEVICE_NAME device

ENV STF_PROVIDER_HOST localhost
#ENV STF_PROVIDER_APPIUM_PORT 4723

ENV STF_PROVIDER_CONNECT_SUB tcp://localhost:7250
ENV STF_PROVIDER_CONNECT_PUSH tcp://localhost:7270

ENV STF_PROVIDER_BOOT_COMPLETE_TIMEOUT 60000
ENV STF_PROVIDER_CLEANUP false
ENV STF_PROVIDER_GROUP_TIMEOUT 3600
ENV STF_PROVIDER_HEARTBEAT_INTERVAL 10000
ENV STF_PROVIDER_LOCK_ROTATION false
ENV STF_PROVIDER_MIN_PORT 7400
ENV STF_PROVIDER_MAX_PORT 7410
ENV STF_PROVIDER_MUTE_MASTER never
ENV STF_PROVIDER_SCREEN_JPEG_QUALITY 30
ENV STF_PROVIDER_SCREEN_PING_INTERVAL 30000
# disable screen reset by default to not hide applications and corrupt automated runs
ENV STF_PROVIDER_SCREEN_RESET false
ENV STF_PROVIDER_VNC_INITIAL_SIZE 600x800
ENV STF_PROVIDER_VNC_PORT 5900

# #56 disable ssl verification by stf provider slave (fix screenshots generation over ssl)
ENV NODE_TLS_REJECT_UNAUTHORIZED 0

# Switch to the app user.
USER stf

COPY files/healthcheck /usr/local/bin/

COPY files/start_all.sh /opt/

## Install websockify
#RUN git clone https://github.com/novnc/websockify.git /opt/websockify && \
#    cd /opt/websockify && git checkout tags/v0.9.0 -b v0.9.0 && make

CMD bash /opt/start_all.sh

HEALTHCHECK CMD ["healthcheck"]
