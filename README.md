# AVRDude SVN Debian Package Builder

We are building our own AVRDude debs from SVN because we often need hardware support that's not present in the released versions.

## Build Your Own

```
git clone https://bitbucket.org/profirmserv/pfs-avrdude_builder
cd pfs-avrdude_builder
vagrant up
vagrant ssh
/vagrant/avrdude-build.bash
```

Soon after, there should be `avrdude` and `avrdude-doc` debs in the `releases` directory.

## Pre-Built Binaries

You can also download [debs we've built](https://bitbucket.org/profirmserv/pfs-avrdude_builder/downloads). These debs are for 64-bit Ubuntu Xenial (16.04). If you need something else, build it yourself.

## Contributions

We welcome contributions via [BitBucket pull request](https://bitbucket.org/profirmserv/pfs-avrdude_builder/pull-requests/new).

## Caveats

This whole thing is kindofa kludge.
