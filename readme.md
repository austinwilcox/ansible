<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->

<a id="readme-top"></a>

<br />
<div align="center">
<h3 align="center">Austins Ansible Playbooks</h3>

  <p align="center">
    Ansible playbooks to automate setup of Ubuntu based machines
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Running</a></li>
      </ul>
    </li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

This is a simple ansible setup that allows me to grab a new ubuntu machine, and automate my setup so that I can spend more time writing software than trying to rememember which software packages that I need to effectively work.

Please note that this has been moved to gitea, this is simply a mirror.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With [Ansible](https://docs.ansible.com/)

<!-- GETTING STARTED -->

## Getting Started

Run `install-ansible.sh` which will install all the necessary software to run the playbooks.

### Prerequisites

Here are the contents of the `install-ansible.sh` script

```sh
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
```

### Running

`ansible-playbook local.yml --ask-become-pass --ask-vault-pass`

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Testing

The playbook is exercised against a clean Ubuntu container so that rotted
download URLs and renamed apt packages surface here rather than while setting up
a real machine.

Locally:

```sh
./docker-build.sh                      # everything a container can satisfy
./docker-build.sh --tags rust,node     # scope it to a few tags
```

A bare run takes a while, since it includes the cargo builds.

### What a container cannot cover

`CONTAINER_SKIP_TAGS` in the `Dockerfile` is the single definition of what gets
skipped. These are **not** covered by CI, so they still need testing on real
hardware:

| Tags                                          | Why                                        |
| --------------------------------------------- | ------------------------------------------ |
| `snap`                                         | snapd needs a real init system             |
| `ufw`                                          | no netfilter in an unprivileged container  |
| `ssh`, `dotfiles`, `zettelkasten`, `disconnected` | private repos behind the vaulted SSH key |
| `i3`, `awesome`, `desktop-apps`, `nextcloud`, `kmonad` | need a display, flatpak, or real input hardware |
| `neovim`                                       | the Lazy sync step needs the dotfiles      |

`snap` and `ufw` exist only as opt-out tags; they tag a single task each so a
container can skip it without skipping the rest of its file.

In GitHub Actions (`.github/workflows/ci.yml`):

- **lint** — `ansible-lint` plus `--syntax-check`, on every push
- **smoke** — the container-safe tags, split into four parallel buckets
- **idempotence** — runs `packages,git,tmux,opentofu` twice and requires
  `changed=0` on the second pass
- **slow** — cargo and neovim source builds, weekly on a schedule

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the GPL-3.0 license. See [LICENSE](./LICENSE) for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
