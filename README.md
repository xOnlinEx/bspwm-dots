# xOnlinEx
### Thanks for dropping by!
Here are some details about my setup:

|       WM      | bspwm      |
|:-------------:|------------|
|       OS      | Arch Linux |
|    Terminal   |    Kitty   |
|      Bar      |     Eww    |
|   Compositor  |   picom    |
| Launcher Apps |    rofi    |

### Screenshot
![Image text](https://github.com/xOnlinEx/bspwm/blob/main/.screenshots/1.png)
![Image text](https://github.com/xOnlinEx/bspwm/blob/main/.screenshots/2.png)

- ** Utilidades **
```sh
paru -S wget unrar unzip zip
```
### personalizar la terminal kitty
```sh
# Instalar oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

### Instalar plugins: `autocompletado`, `sugerencias` y `fzf`
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
```

### Copiar configuracion de la terminal kitty
```sh
cp -r ./kitty "$HOME".config
```
- ** Utilidades **
```sh
paru -S nwg-look
```

- **Custom gtk, icons and file explorer thunar**
```sh
paru -S --noconfirm thunar gvfs gvfs-mtp thunar-archive-plugin xarchiver \
    thunar-volman ffmpegthumbnailer tumbler raw-thumbnailer webp-pixbuf-loader
```
```sh
# Copy themes and icons to home diretory
cd dotfiles
cp -r ./themes "$HOME"
cp -r ./icons "$HOME"
```