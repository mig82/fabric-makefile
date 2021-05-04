# Fabric Makefile

A makefile to make it easier to work with Fabric applications and an SCM.

## Set Up

Edit the `makefile` to:

1. Set the value of `F_CLI_V` to the version of the Fabric CLI JAR you want.
2. Set the value of `fabric_proj` to the name of your Fabric project.
3. Set an environment variable `fabric_acct` to the 9 digit ID of the Cloud account.
4. Set an environment variable `fabric_user` to your Cloud user name —e.g. `user@foo.com`.
5. Set an environment variable `fabric_pssw` to your password.
6. Run `make` or `make setup` to download the `mfcli.jar`.

**Note** that steps 3, 4 and 5 should be set as environment variables in your operating system, rather than hardcoded into the makefile, because you ideally want to add this makefile to source control.

## Usage

Export your Fabric app by running `make export` and then your SCM's client to
version the latest changes —e.g.:

```
make export
git add .
git commit -m "Add new getFoo operation"
```

Or you can check out a version of your Fabric app from SCM and run `make import` to
put it back into Fabric —e.g.:

```
git checkout develop
make import
```
