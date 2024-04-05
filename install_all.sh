Integração dos Scripts "install_flatpak.sh" e "install_pacman.sh"

Combinando os scripts em um único arquivo "install_all.sh":

    Crie um novo arquivo chamado "install_all.sh".
    Copie o conteúdo do script "install_pacman.sh" para o novo arquivo.
    Adicione o conteúdo do script "install_flatpak.sh" ao final do novo arquivo.
    Faça as seguintes alterações no script "install_all.sh":

    Remova a linha que adiciona o repositório Flatpak. Esta linha já está presente no script "install_pacman.sh".
    Altere a função instalar_pacote para verificar se o nome do pacote termina em ".flatpak". Se sim, a função deve chamar a função instalar_flatpak para instalar o app Flatpak. Se não, a função deve instalar o pacote do repositório padrão usando sudo pacman.

Seu script "install_all.sh" agora deve se parecer com isto:
Bash

#!/bin/bash

# Permitir execução com sudo
if [[ $(whoami) != "root" ]]; then
  exec sudo -u root "$0" "$@"
fi

# Lista de pacotes
pacotes=(
  #pacman
  chromium
  arduino
  deepin-calculator
  gimp
  inkscape

  #flatpak
  com.obsproject.Studio
  com.spotify.Client
)

# Função para instalar um pacote
function instalar_pacote() {
  grupo="$1"
  nome="$2"

  echo "Instalando $nome ($grupo)..."

  # Se o pacote termina em ".flatpak", instalar como Flatpak
  if [[ "$nome" =~ .*\.flatpak$ ]]; then
    instalar_flatpak "$nome"
    return
  fi

  # Instalar pacote do repositório padrão
  sudo pacman -Sy "$nome" --noconfirm --quiet
}

# Função para instalar um pacote Flatpak
function instalar_flatpak() {
  nome="$1"

  echo "Instalando $nome..."

  # Baixar e instalar o app Flatpak
  flatpak install --user --noninteractive "$nome"

  echo "$nome instalado com sucesso!"
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

