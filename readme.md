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

<!-- LICENSE -->

## License

Distributed under the GPL-3.0 license. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
