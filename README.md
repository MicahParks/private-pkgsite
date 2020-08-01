# Private pkgsite

Host the open source [pkg.go.dev](https://pkg.go.dev) site, also known as `pkgsite`, internally on a private network
and allow for the displaying of projects with non open source licenses. This site helps display Go (golang)
documentation with support for Go modules.

This project has four directories representing use cases. They are somewhat intuitively named and contain a subset of
the set of features this project offers.


## Features of directories:
`customCertAndInternalProxy`
- [x] Ability to read project repositories with non-permissive licences.
- [x] Private GitLab with custom HTTPS certificate.
- [x] Private network with gateway HTTP proxy.
___
`customCert`
- [x] Ability to read project repositories with non-permissive licences.
- [x] Private GitLab with custom HTTPS certificate.
- [ ] Private network with gateway HTTP proxy.
___
`InternalProxy`
- [x] Ability to read project repositories with non-permissive licences.
- [ ] Private GitLab with custom HTTPS certificate.
- [x] Private network with gateway HTTP proxy.
___
`justLicense`
- [x] Ability to read project repositories with non-permissive licences.
- [ ] Private GitLab with custom HTTPS certificate.
- [ ] Private network with gateway HTTP proxy.
___


# License
Please note that this repository is under the MIT license, but the [pkgsite](https://go.googlesource.com/pkgsite)
project has its own version of a permissive license. Additionally, the [athens](https://github.com/gomods/athens)
project is under the MIT license, but has dependencies with other licences.
