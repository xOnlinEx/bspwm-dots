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