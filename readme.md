# Setup
This will install all the files found with the tasks folder.

```bash
ansible-playbook local.yml --ask-become-pass
```

## TODO
- [x] ~~Figure out how to trigger only certain sections to download and install.
    Example: I only want to update deno, I don't want to have to comment things out every time.~~
```bash
ansible-playbook local.yml --ask-become-pass --tags js
ansible-playbook local.yml --ask-become-pass --skip-tags js
```
