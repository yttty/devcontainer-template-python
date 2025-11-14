FROM python:3.14-trixie

ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone environment variable
ENV TZ=Asia/Hong_Kong
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# User info
ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME=developer

# Install system packages & setup user
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get install -y \
        man-db \
        tzdata \
        tar \
        unzip \
        zip \
        iproute2 \
        git \
        git-lfs \
        vim \
        nano \
        curl \
        wget \
        sudo \
        procps \
        zsh \
        libssl-dev \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && pip install --upgrade --no-cache-dir pip poetry ipykernel \
    && groupadd --gid $USER_GID $USER_NAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USER_NAME \
    && echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME \
    && chmod 0440 /etc/sudoers.d/$USER_NAME

USER $USER_NAME
WORKDIR /home/$USER_NAME

ENV GIT_COMPLETION_VERSION=v2.51.2
RUN mkdir -p ~/.local/share/git-core/contrib/completion \
    && curl -fsSL "https://raw.githubusercontent.com/git/git/${GIT_COMPLETION_VERSION}/contrib/completion/git-completion.bash" \
         -o ~/.local/share/git-core/contrib/completion/git-completion.bash \
    && curl -fsSL "https://raw.githubusercontent.com/git/git/${GIT_COMPLETION_VERSION}/contrib/completion/git-prompt.sh" \
         -o ~/.local/share/git-core/contrib/completion/git-prompt.sh

# Git config
COPY .gitconfig .gitconfig
COPY auxiliary.bashrc .auxiliary.bashrc
RUN echo '' >> ~/.bashrc \
    && echo '# Git completion and prompt' >> ~/.bashrc \
    && echo 'export LANG=C.UTF-8' >> ~/.bashrc \
    && echo 'export LC_ALL=C.UTF-8' >> ~/.bashrc \
    && echo 'source ~/.local/share/git-core/contrib/completion/git-completion.bash' >> ~/.bashrc \
    && echo 'source ~/.local/share/git-core/contrib/completion/git-prompt.sh' >> ~/.bashrc \
    && echo "source ~/.auxiliary.bashrc" >> ~/.bashrc \
    && git lfs install \
    && curl -fLo ~/.gitignore https://raw.githubusercontent.com/yttty/dotfiles/main/.gitignore
ENV TERM=xterm-256color

# Vim config
RUN curl -fLo ~/.vimrc https://raw.githubusercontent.com/yttty/dotfiles/main/.vimrc

ENV DEBIAN_FRONTEND=dialog
