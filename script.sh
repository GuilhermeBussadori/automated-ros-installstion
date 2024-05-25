#!/bin/bash

# Atualizar e atualizar o sistema
echo "Atualizando o sistema..."
sudo apt-get update
sudo apt-get upgrade -y

# Instalar pacotes necessários
echo "Instalando pacotes necessários..."
sudo apt-get install -y curl gnupg2 lsb-release build-essential

# Adicionar repositório do ROS Noetic
echo "Adicionando repositório do ROS Noetic..."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

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
sudo rosdep init
rosdep update

# Instalar pacotes Python 3 e dependências
echo "Instalando Python 3 e dependências..."
sudo apt-get install -y python3-pip python3-dev python3-venv

# Instalar bibliotecas Python adicionais
echo "Instalando bibliotecas Python adicionais..."
pip3 install -U pip
pip3 install rospkg catkin_pkg

# Instalar scikit-learn e outras bibliotecas úteis
echo "Instalando scikit-learn e outras bibliotecas..."
pip3 install scikit-learn numpy scipy matplotlib pandas

# Instalar bibliotecas ROS adicionais
echo "Instalando bibliotecas ROS adicionais..."
sudo apt-get install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

# Criar arquivo de swap de 2 GB
echo "Criando arquivo de swap de 2 GB..."
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Adicionar o swap ao fstab para ativar o swap na inicialização
echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab

echo "Instalação completa!"
