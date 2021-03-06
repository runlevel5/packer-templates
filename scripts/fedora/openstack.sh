#!/bin/bash -eux

if [ $(uname -m)=="ppc64" -o $(uname -m)=="ppc64le" ] ; then
  dnf -y install ppc64-diag
fi

dnf -y install cloud-init cloud-utils yum vim
dracut -f

if [ -e /boot/grub/grub.conf ] ; then
  sed -i -e 's/rhgb.*/console=ttyS0,115200n8 console=tty0 quiet/' /boot/grub/grub.conf
  sed -i -e 's/^timeout=.*/timeout=0/' /boot/grub/grub.conf
  cd /boot
  ln -s boot .
elif [ -e /etc/default/grub ] ; then
  # output bootup to serial
  sed -i -e \
    's/GRUB_CMDLINE_LINUX=\"\(.*\)/GRUB_CMDLINE_LINUX=\"console=ttyS0,115200n8 console=tty0 \1/g' \
    /etc/default/grub
  # No timeout for grub menu
  sed -i -e 's/^GRUB_TIMEOUT.*/GRUB_TIMEOUT=0/' /etc/default/grub
  # No fancy boot screen
  grep -q rhgb /etc/default/grub && sed -i -e 's/rhgb //' /etc/default/grub
  # Write out the config
  grub2-mkconfig -o /boot/grub2/grub.cfg
fi

# Ensure that cloud-init starts before sshd
if [ -e /usr/lib/systemd/system/cloud-init.service ] ; then
  FILE=/usr/lib/systemd/system/cloud-init.service
  sed -i '/^Wants/s/$/ sshd.service/' $FILE
  grep -q Before $FILE && sed -i '/Before/s/$/ sshd.service/' $FILE ||  sed -i '/\[Unit\]/aBefore=sshd.service' $FILE
  systemctl enable cloud-init
fi
