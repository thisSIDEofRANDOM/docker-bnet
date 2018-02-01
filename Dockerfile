FROM tsunamibear/wine:stable
MAINTAINER tsunamibear <thissideofrandom@gmail.com>
CMD bnet

ENV WINE_USER wine
ENV WINE_UID 1000
ENV WINEPREFIX /home/wine/.wine
RUN useradd -u $WINE_UID -d /home/wine -m -s /bin/bash $WINE_USER
WORKDIR /home/wine

# Winetricks
ADD https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks /usr/local/bin/winetricks
RUN chmod 755 /usr/local/bin/winetricks

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        cabextract \
        xauth \
        xvfb \
    && su - $WINE_USER -c winecfg \
    && su - $WINE_USER -c 'xvfb-run -a taskset -c 0 winetricks -q corefonts dotnet462 win7' \
    && rm -rf /home/wine/.cache \
    && apt remove -y --purge xauth xvfb \
    && apt autoremove -y --purge \
    && apt clean -y && rm -rf /var/lib/apt/lists/*

ENV WINEDEBUG -all

COPY extra/bnet.sh /usr/local/bin/bnet

ADD --chown=wine:wine "https://us.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe" /opt/bnet/bnet.exe

USER wine

RUN mkdir -p "${WINEPREFIX}/drive_c/users/${WINE_USER}/Application Data/Battle.net/" \
    && cd "$WINEPREFIX/drive_c/users/${WINE_USER}/Application Data/Battle.net/" \
    && echo "{\"Client\": {\"HardwareAcceleration\": \"false\"}}" > "Battle.net.config"

# Hack to allow mounting of user.reg and system.reg from host
RUN cd .wine && mkdir host \
    && mv user.reg system.reg host/ \
    && ln -s host/*.reg .

COPY extra/host-webbrowser /usr/local/bin/xdg-open
