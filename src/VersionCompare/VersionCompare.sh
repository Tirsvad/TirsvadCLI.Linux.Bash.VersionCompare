#!/bin/bash
declare -r -g TCLI_LINUX_VERSIONCOMPARE=0.0.1

function compare_versions() {
    if [[ $1 == $2 ]]; then
        echo "The versions are equal."
        return 0
    fi

    local IFS=.
    local i ver1=($1) ver2=($2)

    # Fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
        ver1[i]=0
    done

    # Fill empty fields in ver2 with zeros
    for ((i=${#ver2[@]}; i<${#ver1[@]}; i++)); do
        ver2[i]=0
    done

    for ((i=0; i<${#ver1[@]}; i++)); do
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            echo "Version $1 is greater than $2"
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            echo "Version $1 is less than $2"
            return 2
        fi
    done

    echo "The versions are equal."
    return 0
}