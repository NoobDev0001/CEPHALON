VERSION=4.4.4.2
rm -rf ./release-linux
mkdir release-linux

cp ./src/cephalond ./release-linux/
cp ./src/cephalon-cli ./release-linux/
cp ./src/qt/cephalon-qt ./release-linux/
cp ./CEPHALONCOIN_small.png ./release-linux/

cd ./release-linux/
strip cephalond
strip cephalon-cli
strip cephalon-qt

#==========================================================
# prepare for packaging deb file.

mkdir cephaloncoin-$VERSION
cd cephaloncoin-$VERSION
mkdir -p DEBIAN
echo 'Package: cephaloncoin
Version: '$VERSION'
Section: base 
Priority: optional 
Architecture: all 
Depends:
Maintainer: Cephalon
Description: Cephalon coin wallet and service.
' > ./DEBIAN/control
mkdir -p ./usr/local/bin/
cp ../cephalond ./usr/local/bin/
cp ../cephalon-cli ./usr/local/bin/
cp ../cephalon-qt ./usr/local/bin/

# prepare for desktop shortcut
mkdir -p ./usr/share/icons/
cp ../CEPHALONCOIN_small.png ./usr/share/icons/
mkdir -p ./usr/share/applications/
echo '
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/usr/local/bin/cephalon-qt
Name=cephaloncoin
Comment= cephalon coin wallet
Icon=/usr/share/icons/CEPHALONCOIN_small.png
' > ./usr/share/applications/cephaloncoin.desktop

cd ../
# build deb file.
dpkg-deb --build cephaloncoin-$VERSION

#==========================================================
# build rpm package
rm -rf ~/rpmbuild/
mkdir -p ~/rpmbuild/{RPMS,SRPMS,BUILD,SOURCES,SPECS,tmp}

cat <<EOF >~/.rpmmacros
%_topdir   %(echo $HOME)/rpmbuild
%_tmppath  %{_topdir}/tmp
EOF

#prepare for build rpm package.
rm -rf cephaloncoin-$VERSION
mkdir cephaloncoin-$VERSION
cd cephaloncoin-$VERSION

mkdir -p ./usr/bin/
cp ../cephalond ./usr/bin/
cp ../cephalon-cli ./usr/bin/
cp ../cephalon-qt ./usr/bin/

# prepare for desktop shortcut
mkdir -p ./usr/share/icons/
cp ../CEPHALONCOIN_small.png ./usr/share/icons/
mkdir -p ./usr/share/applications/
echo '
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/usr/bin/cephalon-qt
Name=cephaloncoin
Comment= cephalon coin wallet
Icon=/usr/share/icons/CEPHALONCOIN_small.png
' > ./usr/share/applications/cephaloncoin.desktop
cd ../

# make tar ball to source folder.
tar -zcvf cephaloncoin-$VERSION.tar.gz ./cephaloncoin-$VERSION
cp cephaloncoin-$VERSION.tar.gz ~/rpmbuild/SOURCES/

# build rpm package.
cd ~/rpmbuild

cat <<EOF > SPECS/cephaloncoin.spec
# Don't try fancy stuff like debuginfo, which is useless on binary-only
# packages. Don't strip binary too
# Be sure buildpolicy set to do nothing

Summary: Cephalon wallet rpm package
Name: cephaloncoin
Version: $VERSION
Release: 1
License: MIT
SOURCE0 : %{name}-%{version}.tar.gz
URL: https://www.cephaloncoin.net/

BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description
%{summary}

%prep
%setup -q

%build
# Empty section.

%install
rm -rf %{buildroot}
mkdir -p  %{buildroot}

# in builddir
cp -a * %{buildroot}


%clean
rm -rf %{buildroot}


%files
/usr/share/applications/cephaloncoin.desktop
/usr/share/icons/CEPHALONCOIN_small.png
%defattr(-,root,root,-)
%{_bindir}/*

%changelog
* Tue Aug 24 2021  Cephalon Project Team.
- First Build

EOF

rpmbuild -ba SPECS/cephaloncoin.spec



