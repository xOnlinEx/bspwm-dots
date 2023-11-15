# xOnlinEx
### Thanks for dropping by!
Here are some details about my setup:

|       WM      | bspwm      |
|:-------------:|------------|
|       OS      | Arch Linux |
|    Terminal   |    Kitty   |
|      Bar      |   Polybar  |
|   Compositor  |    picom   |
| Launcher Apps |    rofi    |

### Screenshot
![Image text](https://github.com/xOnlinEx/bspwm/blob/main/.screenshots/1.png)
![Image text](https://github.com/xOnlinEx/bspwm/blob/main/.screenshots/2.png)

# instalar yay
- git clone https://aur.archlinux.org/yay.git
- cd yay && makepkg -si

# intalar lo necesario
- sudo -S bspwm rofi nitrogen polybar kitty dunst
- yay -S ttf-iosevka-nerd picom-simpleanims-git

# clonamos el repositorio
git clone https://github.com/xOnlinE/bspwm

# copiamos las configuraciones
- cp -rf bspwm ~/.config
- cp -rf sxhkd ~/.config
- cp -rf rofi ~/.config
- cp -rf dunst ~/.config
- cp -rf picom ~/.config

