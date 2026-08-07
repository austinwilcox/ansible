# Test harness for local.yml. This is not a production image -- it exists so
# that CI (and you, locally) can run the playbook against a clean Ubuntu and
# catch rotted download URLs, renamed apt packages, and broken task ordering
# before you find them while setting up a real machine.
FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

# Note the absence of `rm -rf /var/lib/apt/lists/*`. local.yml's cache update
# uses cache_valid_time, so it trusts the update-success-stamp written here and
# skips refreshing -- with the lists cleared, every later apt task would fail
# with "No package matching ...".
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        gnupg \
        lsb-release \
        software-properties-common \
        sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y --no-install-recommends ansible

# ubuntu:noble ships a stock `ubuntu` account on uid 1000. Reclaim that uid so
# the test user lines up with the uid on a real install. Tasks that use `become`
# need passwordless sudo, since there is no password to prompt for here.
RUN userdel --remove ubuntu 2>/dev/null || true && \
    groupadd --gid 1000 austin && \
    useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash austin && \
    echo 'austin ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/austin && \
    chmod 0440 /etc/sudoers.d/austin

USER austin

# local.yml resolves `home_dir` and `user` from $HOME and $USER. Docker sets
# neither, so `user` would come back empty and every `owner:` would fail.
ENV HOME=/home/austin \
    USER=austin \
    PATH=/home/austin/.cargo/bin:/home/austin/.volta/bin:/home/austin/.deno/bin:/home/austin/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /home/austin/ansible
COPY --chown=austin:austin . .

# Tags a container cannot satisfy: they need snapd, netfilter, a display, real
# input hardware, or the private repos behind the vaulted SSH key. Kept as an
# env var so docker-build.sh and CI agree on one definition.
ENV CONTAINER_SKIP_TAGS=snap,ufw,ssh,dotfiles,zettelkasten,disconnected,neovim,i3,awesome,desktop-apps,nextcloud,kmonad

# Override the args to scope a run, e.g.
#   docker run --rm new-computer ansible-playbook local.yml --tags rust,node
CMD ["sh", "-c", "ansible-playbook local.yml --skip-tags \"$CONTAINER_SKIP_TAGS\""]
