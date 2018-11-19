# msys2-cross

This image contains everything you need to create a windows bundles from msys2
packages.  It was built to help with [Pidgin3](https://pidgin.im) development
as most of use tend to use Linux and don't readily have a Windows machine
available.

This image uses
[pacman-static](https://aur.archlinux.org/packages/pacman-static/) and a bunch
of helper files from [mingw64-base](http://repo.msys2.org/distrib/x86_64/) to
make this all work.

# Howto

It setups up a new empty root in `/windows` which can be modified using
`pacman-cross` which just runs `pacman --root /windows $@`.  After installing
packages you can extract the files by any means you like from
`/windows/mingw32` or `/windows/mingw64` depending on which packages you
installed.

This image was built to be run in
[convey](https://bitbucket.org/rw_grim/convey) pipelines, but can we used
where ever.

