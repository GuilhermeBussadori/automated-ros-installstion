#!/bin/bash

# Verificar a versão do Ubuntu e instalar lsb-release se necessário
echo "Verificando a versão do Ubuntu..."
if ! command -v lsb_release &> /dev/null
then
    echo "lsb-release não encontrado. Instalando..."
    sudo apt-get update
    sudo apt-get install -y lsb-release
fi

RELEASE=$(lsb_release -sc)
echo "Versão do Ubuntu: $RELEASE"

# Atualizar e atualizar o sistema
echo "Atualizando o sistema..."
sudo apt-get update
sudo apt-get upgrade -y

# Instalar pacotes necessários
echo "Instalando pacotes necessários..."
sudo apt-get install -y curl gnupg2 build-essential python3-pip python3-dev python3-venv

# Adicionar repositório do ROS Noetic para Ubuntu 20.04 (Focal Fossa)
echo "Adicionando repositório do ROS Noetic..."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-latest.list'

# Adicionar chave GPG do ROS
echo "Adicionando chave GPG do ROS..."
curl -sSL 'http://packages.ros.org/ros.key' | sudo apt-key add -

# Atualizar lista de pacotes
echo "Atualizando lista de pacotes..."
sudo apt-get update

# Instalar ROS Noetic Desktop-Full
echo "Instalando ROS Noetic Desktop-Full..."
sudo apt-get install -y ros-noetic-desktop-full

# Configurar o ambiente do ROS
echo "Configurando o ambiente do ROS..."
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Inicializar rosdep
echo "Inicializando rosdep..."
sudo apt-get install -y python3-rosdep
sudo rosdep init
rosdep update

# Criar um ambiente virtual Python
echo "Criando um ambiente virtual Python..."
python3 -m venv ~/ros-noetic-venv
source ~/ros-noetic-venv/bin/activate

# Instalar bibliotecas Python adicionais no ambiente virtual
echo "Instalando bibliotecas Python adicionais no ambiente virtual..."
pip install -U pip
pip install rospkg catkin_pkg scikit-learn numpy scipy matplotlib pandas

# Instalar bibliotecas ROS adicionais no ambiente virtual
echo "Instalando bibliotecas ROS adicionais no ambiente virtual..."
pip install rosinstall rosinstall-generator wstool

# Criar arquivo de swap de 2 GB
echo "Criando arquivo de swap de 2 GB..."
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Adicionar o swap ao fstab para ativar o swap na inicialização
echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab

echo "Instalação completa! Não se esqueça de ativar o ambiente virtual com 'source ~/ros-noetic-venv/bin/activate' sempre que for usar o ROS Noetic."
