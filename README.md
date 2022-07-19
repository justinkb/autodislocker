# requirements

requires macFUSE (for both dislocker and ntfs-3g), dislocker, ntfs-3g, recent version of bash (probably 4 or higher) in /usr/local/bin (the script uses associative arrays which the bash that comes with macOS does not support). you will probably need to edit the homebrew formulas for dislocker and ntfs-3g so they build and work properly on macOS again (they were disabled due to macFUSE becoming proprietary), this is left as an exercise to the reader.

# autodislocker

script that reads /etc/autodislocker.conf lines for bitlocker partition UUID and volume name pairs (space separated). should be executed with root permissions (needed to read the recovery keys and to mount the partitions). it reads the recovery key used to decrypt the partition from a file named identical to the volume name inside /etc/autodislocker-keys.d/. after decryption, it mounts the decrypted partition using mount_ntfs from ntfs-3g into /Volumes. the user should take care that /etc/autodislocker.conf is not writable by normal users to avoid malicious editing of the file; the script has no sanity checking on the input. furthermore, /etc/autodislocker-keys.d and the files therein should only be readable by root, as these contain secrets.

# unautodislocker

script that unmounts all volumes mounted from decrypted dislocker-files and afterwards unmounts those dislocker-files. the latter operation can take a while for big partitions. you normally shouldn't have to use this manually, macOS should take care of unmounting all of these on shutdown or reboot.

# TODO

figure out why using this script in a LaunchDaemon fails to mount ntfs partitions from the dislocker-files, this is a mystery
