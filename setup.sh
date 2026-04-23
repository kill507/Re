cat > /root/setup.sh << 'EOF'
#!/bin/bash
pacstrap -K /mnt base base-devel linux linux-firmware intel-ucode networkmanager sddm plasma plasma-meta firefox konsole
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt bash -c "
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && hwclock --systohc
echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
echo 'LANG=ru_RU.UTF-8' > /etc/locale.conf
echo 'arch' > /etc/hostname
useradd -m -G wheel arch && passwd -d arch
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/arch
systemctl enable NetworkManager sddm
bootctl install
echo -e 'title Arch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions root=/dev/nvme0n1p2 rw' > /boot/loader/entries/arch.conf
echo 'default arch' > /boot/loader/loader.conf
mkinitcpio -P
"
EOF
chmod +x /root/setup.sh
