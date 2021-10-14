# this is based on https://github.com/jkuri/alpine-xfce4
FROM alpine:edge

ENV DISPLAY :1
ENV RESOLUTION 1920x1080x24
ENV USER alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# basic packages
RUN apk add --no-cache \
		vim zsh bash neovim tmux pass \
		openssl curl bat w3m exa zip \
		ctags zsh-vcs python3 ack p7zip \
		coreutils tree ranger nodejs \
		npm yarn curl wget fd fzf openssh \
		coreutils nodejs grep tar openssl \
    ca-certificates sudo bash

# python packages
RUN pip install \
		markdown \
		html2text \
		requests \
		beautifulsoup4 \
		pyyaml \
		pyxdg \
		pytz \
		python-dateutil \
		urwid

# desktop packages
RUN apk add --no-cache \
		lightdm lightdm-gtk-greeter \
		alacritty alacritty-zsh-completion \
		xfce4-screensaver dbus-x11 faenza-icon-theme\
		xf86-video-vmware xf86-input-mouse \
		xf86-input-keyboard

# i3 window manager
RUN apk add --no-cache \
		i3wm i3lock i3status

# vnc service
RUN apk add --no-cache \
    xvfb x11vnc

# add user including sudo rights
RUN adduser -h /home/${USER} -s /bin/bash -S -D ${USER} && echo -e "${USER}\n${USER}" | passwd alpine \
    && echo '${USER} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${USER}
WORKDIR /home/${USER}

RUN mkdir -p /home/${USER}/.vnc && x11vnc -storepasswd ${USER} /home/${USER}/.vnc/passwd

COPY entrypoint.sh /entrypoint.sh

CMD [ "/bin/zsh", "/entrypoint.sh" ]
