
Debian
====================
This directory contains files used to package cephalond/cephalon-qt
for Debian-based Linux systems. If you compile cephalond/cephalon-qt yourself, there are some useful files here.

## cephalon: URI support ##


cephalon-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install cephalon-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your cephalon-qt binary to `/usr/bin`
and the `../../share/pixmaps/cephalon128.png` to `/usr/share/pixmaps`

cephalon-qt.protocol (KDE)

