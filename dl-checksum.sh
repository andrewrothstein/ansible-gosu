#!/usr/bin/env sh
VER='1.11'
DIR=~/Downloads
MIRROR=https://github.com/tianon/gosu/releases/download/$VER

RSHASUMS=$MIRROR/SHA256SUMS
LSHASUMS=$DIR/gosu-SHA256SUMS-$VER

if [ ! -e $LSHASUMS ]
then
    wget -q -O $LSHASUMS $RSHASUMS
fi

dl()
{
    PLATFORM=$1
    FILE=gosu-$PLATFORM
    printf "    %s: sha256:%s\n" $PLATFORM `egrep -e $FILE\$ $LSHASUMS | awk '{print $1}'`
}

printf "  # %s\n" $RSHASUMS
printf "  '%s':\n" $VER
dl amd64
dl arm64
dl armel
dl armhf
dl i386
dl ppc64
dl ppc64el
dl s390x



