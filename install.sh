#!/bin/bash

# install paru
echo "instalado paru"
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin & makepkg -si

echo "instalando driver de video para AMD"
paru -S xf86-video-amdgpu vulkan-radeon mesa-libgl mesa-vdpau libvdpau-va-gl libva-mesa-driver #AMD

echo "pipewire"
paru -S pipewire pipewire-alsa pipewire-pulse alsa-utils

echo "utils"
paru -S xdg-user-dirs
xdg-user-dirs-update

echo "file manager"
paru -S thunar thunar-archive-plugin xarchiver ffmpegthumbnailer \
  tumbler raw-thumbnailer tumbler-extra-thumbnailers webp-pixbuf-loader \
  gvfs

echo "lightdm"
paru -S lightdm lightdm-webkit2-greeter lightdm-webkit-theme-aether
sudo systemctl enable lightdm.service
