#!/bin/bash

audio="-x --audio-format mp3"
video="-f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best""

URL=$1
OPTION=$2

if [ $OPTION == 'video' ] ; then
    FORMATO=$video
elif [ $OPTION == 'áudio' ] ; then
    FORMATO=$audio
else
  echo "algo deu erado"
  exit 1
fi

clear
echo "Agora escolha o tipo de download de $OPTION:"
echo

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