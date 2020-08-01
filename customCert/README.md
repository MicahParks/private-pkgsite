# Custom Cert
This directory contains a stub of how to host [pkgsite](https://go.googlesource.com/pkgsite) in a network that contains
a custom cert for the git repositories that your projects live at. The containers in this directory will not only help
with these networking issues, but allow `pkgsite` to host documentation for repositories that do not have a permissive
license.

This project uses the [athens](https://github.com/gomods/athens) project as a replacement for [proxy.golang.org](https://proxy.golang.org).

## Editing files
Every file in this directory except the `README.md` and `athens.Dockerfile` needs to be edited.
Please use this Linux bash command to help you search for `TODO`s that need attention.
```bash
grep -R TODO
```

Don't forget to edit the `.netrc` and `root.crt` files in the same directory as you `docker-compose.yml`. The `.netrc`
is a "hidden file" by default.

The `.netrc` file will need a personal access token from GitLab with the `read_api` scope (in my use case). Make sure to
not use your GitLab password. Use a service account + token if possible.

The `root.crt` file is expected to be a certificate the needs to be trusted for HTTPS connections to the GitLab server.

## Running `pkgsite`
This implementation assumes you are using Docker.

Have [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/install/) installed and
running. Then, while in this directory, simply use this command to build and run the images and containers:
```bash
docker-compose up
```
