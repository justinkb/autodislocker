#!/usr/local/bin/bash

unmount_decrypted_volumes() {
    decrypted_volumes=$(/sbin/mount | /usr/bin/grep dislocker-file | /usr/bin/awk '{print $1}')
    for dv in $decrypted_volumes; do
        /sbin/umount "$dv"
    done
}

unmount_bitlocker_partitions() {
    bitlocker_partitions=$(/sbin/mount | /usr/bin/grep dislocker-fuse | /usr/bin/awk '{print $1}')
    for bp in $bitlocker_partitions; do
        /sbin/umount "$bp"
    done
}

unmount_decrypted_volumes
unmount_bitlocker_partitions
