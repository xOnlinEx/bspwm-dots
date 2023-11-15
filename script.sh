!#/bin/bash

# instalar yay
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si

# volver al home
cd ~

# intalar lo necesario
yay -S bspwm rofi nitrogen polybar kitty dunst \ 
  ttf-iosevka-nerd picom-simpleanims-git 

# clonamos el repositorio
git clone https://github.com/xOnlinE/bspwm

# copiamos las configuraciones
cp -rf ./bspwm/bspwm ~/.config
cp -rf ./bspwm/sxhkd ~/.config
cp -rf ./bspwm/rofi ~/.config
cp -rf ./bspwm/dunst ~/.config
cp -rf ./bspwm/picom ~/.config
