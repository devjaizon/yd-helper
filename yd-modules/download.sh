#!/bin/bash
URL=$1
OPTION=$2

#  seleciona o formato correto para download, dependendo da escolha do usuário
if [ $OPTION == 'video' ] ; then
    FORMATO="-f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best""
elif [ $OPTION == 'áudio' ] ; then
    FORMATO="-x --audio-format mp3"
else
  echo "algo deu erado"
  exit 1
fi

clear
echo "Agora escolha o tipo de download de $OPTION:"
echo

# selecionar se vai fazer o download do vídeo completo, dividido pelos cápitulos ou se é pra baixar uma playlist
# o script usa o título do vpideo ou playlist para criar a pasta onde as pare irão ficar
# no caso de capítulos, cada parte terá o nome corresponde ao nome do capítulo do vídeo
# no caso das playlists, cada parte terá o nome correspondente do vídeo
# em ambos os casos, as partes vêm numeradas de acordo com a ordem
select opt in arquivo capítulos playlist sair; do
  case $opt in
    arquivo)
      clear
      echo Iniciando o download do arquivo de $OPTION!!
      echo
      yt-dlp $FORMATO $URL
      break

      ;;
    capítulos)
          clear
      echo Iniciando o download dos capítulos de $OPTION!!
      echo
        yt-dlp $FORMATO --split-chapters -o "chapter:~/Downloads/yt-dlp/%(title)s/%(section_number)s - %(section_title)s.%(ext)s" $URL
      break

        ;;
    playlist)
          clear
      echo Iniciando o download da playlist de $OPTION!!
      echo
        yt-dlp $FORMATO -o "~/Downloads/yt-dlp/%(playlist_title)s/%(title)s.%(ext)s" $URL
      break

      ;;
    sair)
      clear
      echo Usuário desistiu do download!!!
      break
      ;;
    *) 
    clear
      echo "opção inválida. Escolha "1" para vídeo, "2" para capítulos,"3" para playlists ou "4" para sair!!"
      echo
      ;;
  esac
done