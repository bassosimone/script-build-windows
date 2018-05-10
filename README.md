# Package MK and deps for Windows

This repository contains the scripts to compile and package MK and its
dependencies on Windows systems (but _not_ for Mingw-w64; you should
use [measurement-kit/script-build-unix](
https://github.com/measurement-kit/script-build-unix
) to do that).

## Build and package

By following this procedure, you will find tarball packages in the root
directory and an updated SHA256SUM file that you should commit.

You'll need to have installed Visual Studio 2017 and the Linux Subsystem
for Windows with `bash` with `curl` installed. Additionally, we also require
CMake to be installed as a Windows executable.

Open a development command prompt for either `x86` or `x64` (depending
on what you want to compile for) and run:

```
build.bat ./geoip-api-c
build.bat ./libressl
build.bat ./libevent
build.bat ./measurement-kit
```

## Publishing packages

Packages are published in a [measurement-kit/prebuilt](
https://github.com/measurement-kit/prebuilt) release. There should be
two releases: `stable` and `testing`. Depending on whether you are sure
that this is a stable build or not, use the former or the latter.

## Downloading packages

For the download to succeed, you must have committed and pushed the
changes to `SHA256SUM` created by the build step and published the
related tarballs as explained in the previous step.

Then run:

```
./install <package-name>
```

By default, the `testing` release channel is used. To override:

```
./install -c stable <package-name>
```

For example (valid at the moment of writing this file):

```
./install windows-libressl-2.6.4-1
```

This will download the related tarball, verify its SHA256 sum and unpack
the tarball inside `./MK_DIST`. You can use `find` inside of `MK_DIST` to
understand exactly the structure of the downloaded package.

If you integrate this repository as a subrepository, and you run install
from the parent directory, `MK_DIST` will be inside the parent directory.

```
./foo/bar/install windows-libressl-2.6.4-1
# You will find the package in ./MK_DIST rather than ./foo/bar/MK_DIST
```

## Low-level details

For each package, there is a build script named after the package. Packages
may depend on each other. You will clearly see that when reading the package
specific build script. Make sure you build them in order.

There may be small patches that we apply to packages. (Preferrably none but
some small patches are better than having to do more difficult stuff.)
