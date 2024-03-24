echo "Changing APK repositories to latest-stable..."
cat > /etc/apk/repositories <<EOL
https://mirror.fcix.net/alpine/latest-stable/main
https://mirror.fcix.net/alpine/latest-stable/community
EOL
apk upgrade

echo "Enabling root auto-login..."
apk add agetty
cat > /etc/inittab <<EOL
# /etc/inittab
::sysinit:/sbin/openrc sysinit
::sysinit:/sbin/openrc boot
::wait:/sbin/openrc default

# Set up a couple of getty's
::respawn:/sbin/getty 38400 console

# Stuff to do for the 3-finger salute
::ctrlaltdel:/sbin/reboot

# Stuff to do before rebooting
::shutdown:/sbin/openrc shutdown
tty1::respawn:/sbin/agetty --autologin root tty1 linux
tty2::respawn:/sbin/getty 38400 tty2
EOL

/etc/init.d/agetty restart tty1

