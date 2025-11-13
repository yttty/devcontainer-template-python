FROM python:3.14-trixie

ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone environment variable
ENV TZ=Asia/Hong_Kong
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install packages
RUN apt-get clean && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y \
    tzdata tar unzip zip iproute2 git git-lfs vim nano curl wget sudo procps zsh \
    libssl-dev libicu-dev \
    && apt-get autoremove -y \
    && apt-get clean -y

# Install GCM
ENV GCM_VERSION=2.6.1
RUN wget -O gcm-linux_amd64.deb https://github.com/git-ecosystem/git-credential-manager/releases/download/v$GCM_VERSION/gcm-linux_amd64.$GCM_VERSION.deb && \
    dpkg -i gcm-linux_amd64.deb && \
    rm gcm-linux_amd64.deb

# Install poetry
RUN pip install --upgrade pip && \
    pip install --no-cache-dir poetry ipykernel

# Add user
ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME=developer
RUN groupadd --gid $USER_GID $USER_NAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USER_NAME \
    && echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME \
    && chmod 0440 /etc/sudoers.d/$USER_NAME \
    && chsh -s $(which zsh) $USER_NAME

USER $USER_NAME
WORKDIR /home/$USER_NAME

# User config
COPY .zshrc .zshrc
COPY .gitconfig .gitconfig
RUN git lfs install && \
    git-credential-manager configure && \
    curl -fLo ~/.gitignore https://raw.githubusercontent.com/yttty/dotfiles/main/.gitignore && \
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    curl -fLo ~/.vimrc https://raw.githubusercontent.com/yttty/dotfiles/main/.vimrc

ENV DEBIAN_FRONTEND=dialog
