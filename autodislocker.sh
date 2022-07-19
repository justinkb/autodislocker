#!/usr/local/bin/bash

declare -A uuid_map
declare -A config

populate_map() {
    devices=$(/bin/ls /dev/disk*s*)
    for p in $devices; do
        uuid=$(/usr/sbin/diskutil info "$p" | /usr/bin/grep "Partition UUID" | /usr/bin/awk '{print $5}')
        if [ "x$uuid" != "x" ]; then
            uuid_map[$uuid]=$p
        fi
    done
}

load_config() {
    while read -r line; do
        read -r -a entry <<<"$line"
        config["${entry[0]}"]="${entry[1]}"
    done </etc/autodislocker.conf
}

mount_partitions() {
    /bin/mkdir -p /var/autodislocker
    for uuid in "${!uuid_map[@]}"; do
        volume_name="${config[$uuid]}"
        if [ ! "${volume_name}" ]; then
            continue
        fi
        device="${uuid_map[$uuid]}"
        dislocker_path="/var/autodislocker/${volume_name}"
        mount_path="/Volumes/${volume_name}"
        key=$(/bin/cat /etc/autodislocker-keys.d/"${volume_name}")
        /usr/local/bin/dislocker "$device" "$dislocker_path" --recovery-password="$key"
        /usr/local/sbin/mount_ntfs -o loop "${dislocker_path}/dislocker-file" "$mount_path"
    done
}

populate_map
load_config
mount_partitions
