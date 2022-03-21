#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/tianon/gosu/releases/download

dl()
{
    local ver=$1
    local lshasums=$2
    local arch=$3
    local file="gosu-${arch}"
    local url="${MIRROR}/${ver}/${file}"
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $arch `egrep -e "$file\$" $lshasums | awk '{print $1}'`
}

dl_ver() {
    local ver=$1

    local rshasums="$MIRROR/${ver}/SHA256SUMS"
    local lshasums="$DIR/gosu-${ver}-SHA256SUMS"

    if [ ! -e $lshasums ];
    then
        curl -sSLf -o $lshasums $rshasums
    fi

    printf "  # %s\n" $rshasums
    printf "  '%s':\n" $ver
    dl $ver $lshasums amd64
    dl $ver $lshasums arm64
    dl $ver $lshasums armel
    dl $ver $lshasums armhf
    dl $ver $lshasums i386
    dl $ver $lshasums mips64el
    dl $ver $lshasums ppc64el
    dl $ver $lshasums riscv64
    dl $ver $lshasums s390x
}

dl_ver ${1:-1.14}
