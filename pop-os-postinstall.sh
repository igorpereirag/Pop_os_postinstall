#!/bin/bash

## Diretórios
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

## Cores
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

## Funções

# Atualiza e faz a manutenção do sistema
atualizar_sistema(){
  echo -e "${VERDE}[INFO] - Atualizando o sistema.${SEM_COR}"
  sudo apt update && sudo apt dist-upgrade -y
  sudo apt autoclean -y
  sudo apt autoremove -y
}

# Verifica conexão com a Internet
verificar_internet(){
  if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
    echo -e "${VERMELHO}[ERROR] - Sem conexão com a Internet.${SEM_COR}"
    exit 1
  fi
}

# Remove travas do apt
remover_travas_apt(){
  sudo rm -rf /var/lib/dpkg/lock-frontend /var/cache/apt/archives/lock
}

# Instala pacotes do repositório
instalar_programas_apt(){
  local PROGRAMAS=(
    code            # Visual Studio Code (IDE)
    git             # Git (Controle de versão)
    docker.io       # Docker (Contêineres)
  )
  echo -e "${VERDE}[INFO] - Instalando pacotes APT.${SEM_COR}"
  sudo apt update && sudo apt install -y "${PROGRAMAS[@]}"
  
  # Configura Docker para uso sem sudo
  sudo usermod -aG docker $USER
  newgrp docker
}

# Instala pacotes via Flatpak
instalar_flatpaks(){
  local FLATPAK_PROGRAMAS=(
    rest.insomnia.Insomnia    # Insomnia (Cliente REST API)
    org.chromium.Chromium    # Chromium (Navegador baseado no Chrome)
    com.bitwarden.desktop   # Bitwarden (Gerenciador de senhas)
  )
  
  echo -e "${VERDE}[INFO] - Instalando Flatpak.${SEM_COR}"
  # Verifica se o Flatpak está instalado e, se necessário, instala-o
  if ! command -v flatpak &> /dev/null; then
    sudo apt install flatpak -y
  fi
  
  # Adiciona o repositório Flathub
  if ! flatpak remotes | grep -q flathub; then
    echo -e "${VERDE}[INFO] - Adicionando repositório Flathub.${SEM_COR}"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  fi

  for flatpak in "${FLATPAK_PROGRAMAS[@]}"; do
    flatpak install flathub "$flatpak" -y
  done
}

# Instala SDKMAN
instalar_sdkman(){
  echo -e "${VERDE}[INFO] - Instalando SDKMAN.${SEM_COR}"
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
}

# Execução
verificar_internet
remover_travas_apt
atualizar_sistema
instalar_programas_apt
instalar_flatpaks
instalar_sdkman
atualizar_sistema

echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
