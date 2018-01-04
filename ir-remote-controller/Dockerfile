FROM resin/rpi-raspbian:stretch

RUN apt-get update && apt-get install -y \
    lirc \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/lirc_options.conf /etc/lirc/lirc_options.conf

#RUN echo "lirc-rpi,gpio_in_pin=8,gpio_out_pin=7" > /etc/modules

COPY ./conf/lircd-*.conf /usr/src/app/
RUN cat /usr/src/app/lircd-*.conf > /etc/lirc/lircd.conf

#COPY ./crontab.txt /usr/src/app/
#RUN crontab < /usr/src/app/crontab.txt

COPY ./entrypoint.sh /usr/src/app/

CMD ["/usr/src/app/entrypoint.sh"]
