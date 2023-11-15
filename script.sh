!#/bin/bash

# instalar yay
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si

# volver al home

# intalar lo necesario
yay -S bspwm rofi nitrogen polybar kitty dunst \ 
  ttf-iosevka-nerd picom-simpleanims-git 

# clonamos el repositorio
git clone https://github.com/xOnlinE/bspwm

# copiamos las configuraciones
cp -rf bspwm ~/.config
cp -rf sxhkd ~/.config
cp -rf rofi ~/.config
cp -rf dunst ~/.config
cp -rf picom ~/.config
