#!/bin/bash

# Função para instalar um pacote
function instalar_pacote() {
 nome="$1"

 echo "Instalando $nome..."

 # Instalar pacote do repositório padrão
 sudo pacman -Sy "$nome" --noconfirm --quiet
}

# Função para instalar um pacote via Yay
function instalar_yay() {
 nome="$1"

 echo "Instalando $nome via Yay..."

 # Instalar pacote via Yay
 yay -S "$nome" --noconfirm --quiet
}

# Lista de pacotes do repositório oficial
pacotes_repo=(
 #NAVEGADOR
 "firefox"
 #MULTIMÍDIA
 "gimp"
 "inkscape"
 #FERRAMENTAS-SISTEMA
 "isoimagewriter"
 "gnome-calculator"
)

# Lista de pacotes AUR
pacotes_aur=(
 #FERRAMENTAS
 "kdeconnect"
 #VIRTUALIZAÇÃO
 "virt-manager"
 #PROGRAMAÇAÕ
 "github-desktop-bin"
 "jdk"
)

# Perguntar se deseja instalar todos os programas
echo "Você quer instalar todos os programas? (S/N/0 para abortar):"
read resposta

# Instalar todos os programas do repositório oficial se a resposta for "S"
if [[ "$resposta" =~ ^[Ss]$ ]]; then
 for pacote in "${pacotes_repo[@]}"; do
   instalar_pacote "$pacote"
 done

 # Instalar o GitHub Desktop via Yay
 instalar_yay "${pacotes_aur[0]}"

 echo "Instalação concluída!"
 exit 0
fi

# Perguntar se deseja instalar os programas separadamente se a resposta for "N"
if [[ "$resposta" =~ ^[Nn]$ ]]; then
 echo "Você deseja instalar os programas separadamente? (S/0 para abortar):"
 read resposta

 # Instalar os programas separadamente se a resposta for "S"
 if [[ "$resposta" =~ ^[Ss]$ ]]; then
   for pacote in "${pacotes_repo[@]}" "${pacotes_aur[@]}"; do
      # Descrição breve do pacote (opcional)
      descricao=""
      case "$pacote" in
        "firefox")
          descricao="Segundo melhor navegador"
          ;;
        "kdeconnect")
          descricao="Conecta seu smartphone ao seu computador."
          ;;
        "gimp")
          descricao="Melhor editor de imagem"
          ;;
        "inkscape")
          descricao="Segunda melhor alternativa para o I"
          ;;
        "isoimagewriter")
          descricao="Criador de ISO"
          ;;
        "gnome-calculator")
          descricao="Calculadora"
          ;;
        "virt-manager")
          descricao="A melhor virtualização"
          ;;
        "github-desktop-bin")
          descricao="Alternativa (software)"
          ;;
        "jdk")
          descricao="Javinha pra jogar mine"
          ;;
        # ...
      esac

      echo "Deseja instalar o pacote $pacote ($descricao)? (S/N)"
      read resposta

      if [[ "$resposta" =~ ^[Ss]$ ]]; then
        if [[ "$pacote" =~ ^aur- ]]; then
          instalar_yay "$pacote"
        else
          instalar_pacote "$pacote"
        fi
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
