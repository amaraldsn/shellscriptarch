#!/bin/bash

# Permitir execução com sudo
if [[ $(whoami) != "root" ]]; then
  exec sudo -u root "$0" "$@"
fi

# Adicionar o repositório Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Lista de pacotes
pacotes=(
  #pacman
  chromium
  arduino
  deepin-calculator
  gimp
  inkscape

  #flatpak
  obs.flatpak
)

# Função para instalar um pacote
function instalar_pacote() {
  grupo="$1"
  nome="$2"

  echo "Instalando $nome ($grupo)..."

  # Se o pacote termina em ".flatpak", instalar como Flatpak
  if [[ "$nome" =~ .*\.flatpak$ ]]; then
    flatpak install --user --noninteractive "$nome"
    return
  fi

  # Instalar pacote do repositório padrão
  sudo pacman -Sy "$nome" --noconfirm --quiet
}

# Percorrer a lista de pacotes e instalar cada pacote
for pacote in "${pacotes[@]}"; do
  # Divida o pacote em nome do grupo e nome do pacote
  grupo="${pacote%%:*}"
  nome="${pacote#*:}"

  # Instalar o pacote
  instalar_pacote "$grupo" "$nome"
done

echo "Instalação concluída!"

'''
#!/bin/bash

# Permitir execução com sudo
if [[ $(whoami) != "root" ]]; then
  exec sudo -u root "$0" "$@"
fi

# Adicionar o repositório Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Lista de pacotes
pacotes=(
  "navegadores:chromium"
  "desenvolvimento:arduino"
  "ferramentas:deepin-calculator gimp inkscape"
  "ferramentas-video:obs.flatpak"
)

# Função para instalar um pacote
function instalar_pacote() {
  grupo="$1"
  nome="$2"

  echo "Instalando $nome ($grupo)..."

  # Se o pacote termina em ".flatpak", instalar como Flatpak
  if [[ "$nome" =~ .*\.flatpak$ ]]; then
    flatpak install --user "$nome" --noconfirm --quiet
    return
  fi

  # Instalar pacote do repositório padrão
  sudo pacman -Sy "$nome" --noconfirm --quiet
}

# Percorrer a lista de pacotes e instalar cada pacote
for pacote in "${pacotes[@]}"; do
  # Divida o pacote em nome do grupo e nome do pacote
  grupo="${pacote%%:*}"
  nome="${pacote#*:}"

  # Instalar o pacote
  instalar_pacote "$grupo" "$nome"
done

echo "Instalação concluída!"
'''


