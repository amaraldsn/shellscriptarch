#!/bin/bash

# Função para instalar o Flatpak
function instalar_flatpak() {
  echo "Instalando o Flatpak..."

  # Atualizar o repositório de pacotes
  sudo pacman -Syu

  # Instalar o Flatpak e seus pré-requisitos
  sudo pacman -S flatpak --noconfirm --quiet

  # Habilitar o daemon do Flatpak
  sudo systemctl enable --now flatpak.service

  echo "Flatpak instalado com sucesso!"
}

# Função para instalar um pacote Flatpak
function instalar_flatpak_app() {
  nome="$1"

  echo "Instalando $nome..."

  # Baixar e instalar o app Flatpak
  flatpak install --user --noninteractive "$nome"

  echo "$nome instalado com sucesso!"
}

# Lista de apps Flatpak
apps=(
  #NAVEGADORES
  "com.brave.Browser"
  "org.mozilla.firefox"
  "com.microsoft.Edge"
  "ru.yandex.Browser"
  #MULTIMÍDIA
  "io.github.Figma_Linux.figma_linux"
  "com.rawtherapee.RawTherapee"
  "com.obsproject.Studio"
  "com.spotify.Client"
  "org.libreoffice.LibreOffice"
  "org.telegram.desktop"
  #PROGRAMAÇÃO
  "com.visualstudio.code"
  #JOGOS
  "com.valvesoftware.Steam"
  "org.ppsspp.PPSSPP"
  #ESTUDOS
  "net.ankiweb.Anki"
)

# Perguntar se deseja instalar o Flatpak
echo "Você quer instalar o Flatpak? (S/N/0 para abortar):"
read resposta

# Instalar o Flatpak se a resposta for "S"
if [[ "$resposta" =~ ^[Ss]$ ]]; then
  instalar_flatpak
fi

# Verificar se o Flatpak já está instalado se a resposta for "N"
if [[ "$resposta" =~ ^[Nn]$ ]]; then
  if ! command -v flatpak &> /dev/null; then
    echo "O Flatpak não está instalado. Abortando..."
    exit 1
  fi
fi

# Perguntar se deseja instalar todos os programas
echo "Você quer instalar todos os programas? (S/N/0 para abortar):"
read resposta

# Instalar todos os programas se a resposta for "S"
if [[ "$resposta" =~ ^[Ss]$ ]]; then
  for app in "${apps[@]}"; do
    instalar_flatpak_app "$app"
  done
  echo "Instalação concluída!"
  exit 0
fi

# Perguntar se deseja instalar os programas separadamente se a resposta for "N"
if [[ "$resposta" =~ ^[Nn]$ ]]; then
  echo "Você deseja instalar os programas separadamente? (S/0 para abortar):"
  read resposta

  # Instalar os programas separadamente se a resposta for "S"
  if [[ "$resposta" =~ ^[Ss]$ ]]; then
    for app in "${apps[@]}"; do
      echo "Deseja instalar o app $app (S/N)?"
      read resposta

      # Instalar app se a resposta for "S"
      if [[ "$resposta" =~ ^[Ss]$ ]]; then
        instalar_flatpak_app "$app"
      fi
    done
    echo "Instalação concluída!"
  fi
fi

# Exibir mensagem de erro se a resposta for inválida
if [[ "$resposta" != ^[SsNn0]$ ]]; then
  echo "Resposta inválida. Abortando..."
  exit 1
fi
