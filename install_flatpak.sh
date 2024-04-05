#!/bin/bash

# Função para instalar um pacote Flatpak
function instalar_flatpak() {
  nome="$1"

  echo "Instalando $nome..."

  # Baixar e instalar o app Flatpak
  flatpak install --user --noninteractive "$nome"

  echo "$nome instalado com sucesso!"
}

# Lista de apps Flatpak para instalar
apps=(
  "obs.flatpak"
  "com.spotify.Client"
  # Adicione outros apps Flatpak aqui...
)

# Percorrer a lista de apps e instalar cada app
for app in "${apps[@]}"; do
  instalar_flatpak "$app"
done

echo "Instalação de apps Flatpak concluída!"

