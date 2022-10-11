#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

CEPHALOND=${CEPHALOND:-$SRCDIR/cephalond}
CEPHALONCLI=${CEPHALONCLI:-$SRCDIR/cephalon-cli}
CEPHALONTX=${CEPHALONTX:-$SRCDIR/cephalon-tx}
CEPHALONQT=${CEPHALONQT:-$SRCDIR/qt/cephalon-qt}

[ ! -x $CEPHALOND ] && echo "$CEPHALOND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
NEOXVER=($($CEPHALONCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for cephalond if --version-string is not set,
# but has different outcomes for cephalon-qt and cephalon-cli.
echo "[COPYRIGHT]" > footer.h2m
$CEPHALOND --version | sed -n '1!p' >> footer.h2m

for cmd in $CEPHALOND $CEPHALONCLI $CEPHALONTX $CEPHALONQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${NEOXVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${NEOXVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
