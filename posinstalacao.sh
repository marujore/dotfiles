#!/bin/bash
set -e

echo "🔄 Atualizando sistema..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common apt-transport-https ca-certificates gnupg lsb-release curl wget git make cmake build-essential python3-pip

echo "⌨️ Adicionando cedilha"
if ! grep -q "GTK_IM_MODULE=cedilla" /etc/environment; then
  echo "GTK_IM_MODULE=cedilla" | sudo tee -a /etc/environment
fi

if ! grep -q "QT_IM_MODULE=cedilla" /etc/environment; then
  echo "QT_IM_MODULE=cedilla" | sudo tee -a /etc/environment
fi

echo "📝 Instalando Sublime Text..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimehq-archive.gpg
echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update && sudo apt install sublime-text -y
grep -qxF "127.0.0.1 license.sublimehq.com" /etc/hosts || echo "127.0.0.1 license.sublimehq.com" | sudo tee -a /etc/hosts > /dev/null

echo "🐱 Instalando Kitty Terminal..."
sudo apt install kitty

echo "🐢 Instalando Terminator..."
sudo apt install terminator -y

echo "💻 Instalando ZSH e Oh My Zsh..."
sudo apt install zsh -y
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "🔌 Instalando plugins do Zsh..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
wget https://raw.githubusercontent.com/zakaziko99/agnosterzak-ohmyzsh-theme/master/agnosterzak.zsh-theme -O ~/.oh-my-zsh/custom/themes/agnosterzak.zsh-theme

echo 'ZSH_THEME="agnosterzak"' >> ~/.zshrc
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> ~/.zshrc

echo "🎨 Instalando Pokemon Colorscripts..."
git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
cd pokemon-colorscripts && sudo ./install.sh && cd .. && rm -rf pokemon-colorscripts

echo "📂 Instalando LSD e Fastfetch..."
sudo apt install lsd -y
git clone https://github.com/fastfetch-cli/fastfetch.git
cd fastfetch && mkdir -p build && cd build
cmake .. && make -j$(nproc)
sudo make install
cd ../.. && rm -rf fastfetch

echo 'alias ls="lsd -al"' >> ~/.zshrc
echo 'alias ff="fastfetch"' >> ~/.zshrc

echo "🔤 Instalando Nerd Fonts..."
sudo apt install fonts-firacode -y

echo "🛠 Instalando utilitários extras (htop, btop, tmux, bat, flameshot, gnome-tweaks)..."
sudo apt install -y htop btop tmux bat flameshot gnome-tweaks

echo "🌐 Instalando Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y && rm google-chrome-stable_current_amd64.deb

echo "🎮 Instalando Steam e Discord..."
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install ./discord.deb -y && rm discord.deb

echo "💻 Instalando VS Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update && sudo apt install code -y

echo "🐳 Instalando Docker e Docker Compose..."
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
newgrp docker

echo "🐍 Instalando PyCharm Community..."
sudo snap install pycharm-community --classic

echo "📓 Instalando JupyterLab..."
pip install jupyterlab

echo "📦 Instalando Miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
eval "$($HOME/miniconda3/bin/conda shell.zsh hook)"
conda init zsh
rm Miniconda3-latest-Linux-x86_64.sh

echo "📮 Instalando Postman..."
sudo snap install postman

echo "🎥 Instalando programas multimídia..."
sudo apt install vlc gimp audacity kolourpaint -y
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt update && sudo apt install obs-studio -y

echo "🌍 Instalando GDAL e QGIS..."
sudo apt install -y libgdal-dev gdal-bin python3-dev build-essential
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
pip install GDAL==$(gdal-config --version)
sudo apt install qgis -y

echo "🔊 Instalando PipeWire (áudio moderno)..."
sudo apt install pipewire pipewire-pulse pipewire-alsa wireplumber -y
systemctl --user restart pipewire pipewire-pulse wireplumber

echo "🖥️ Configurando drivers NVIDIA..."
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install libnvidia-gl-570:i386

echo "⚙️ Clonando e aplicando dotfiles..."
git clone https://github.com/marujore/dotfiles.git
cp -r ./dotfiles/kitty ~/.config

echo "⚙️ Instalando FUSE (vai ser usado pelo davinci resolve..."
sudo add-apt-repository universe
sudo apt install libfuse2t64
sudo apt-get install libapr1 libaprutil1 libglib2.0-0 libxcb-cursor0 libasound2-dev libxcb-damage0-dev -y

echo "🧹 Limpando pacotes não usados..."
sudo apt autoremove -y
sudo apt autoclean -y

echo "✅ Script concluído! Reinicie o sistema para aplicar todas as mudanças."