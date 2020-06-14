#!/bin/sh

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

update_polybar(){
    PATH_JSON='/home/anderson/.local/scripts/MangaUpdates/iruma.json'
    executou=$(scrapy crawl MangaUpdates)
    update_number=$(echo $( cat $PATH_JSON ) | jq '.chapter [0:2] | tonumber')
    update_name=$(echo $( cat $PATH_JSON ) | jq '.chapter [5:] | tostring' | sed 's/\"//g') 
    if [ -n "$update_number" ] && [ "$update_number" -gt 0 ]; then
        echo "Iruma $update_number - $update_name"
    else
        echo ""
    fi
}

update_show(){
    # Teste de cores
    GREEN='\033[0;32m'
    CYAN='\033[0;36m'
    ORANGE='\033[0;33m'
    DARK_GRAY='\033[1;30m'
    LIGHT_PURPLE='\033[1;35m'
    PURPLE='\033[0;35m'
    BLUE='\033[0;34m'
    RED='\033[0;31m'
    NC='\033[0m' # No Color

    PATH_JSON='/home/anderson/.local/scripts/MangaUpdates/iruma.json'
    executou=$(scrapy crawl MangaUpdates)
    CAPITULO_NUMERO=$(echo $( cat $PATH_JSON ) | jq '.chapter [0:2] | tonumber')
    CAPITULO_TEXTO=$(echo $( cat $PATH_JSON ) | jq '.chapter [5:] | tostring' | sed 's/\"//g') 
    VOLUME=$(echo $( cat $PATH_JSON ) | jq '.volume [7:] | tonumber')
    DATA=$(echo $( cat $PATH_JSON ) | jq '.date')
    LINK=$(echo $( cat $PATH_JSON ) | jq '.url')
    if [ -n "$CAPITULO_NUMERO" ] && [ "$CAPITULO_NUMERO" -gt 0 ]; then
        echo "${BLUE}##################################################################################################"
        echo "${BLUE}############################## Mangá Update ######################################################"
        echo "${NC}Mangá: ${ORANGE}Mairimashita! Iruma-kun\t\t${NC}Scan: ${ORANGE}Drope"${NC}
        echo "|------------------------------------------------------------------------------------------------|"
        echo "${NC}Volume:${CYAN}$VOLUME\t\t${NC}Capítulo:${CYAN}$CAPITULO_NUMERO - $CAPITULO_TEXTO${NC} ${NC}\nData:${CYAN}$DATA${NC} \t${NC}Link:${GREEN}$LINK${NC}"
        echo "${BLUE}|------------------------------------------------------------------------------------------------|${NC}"
    else
        echo ""
    fi
}

if [ $# -lt 1 ];then
   echo "Faltou utilizar pelo menos um argumento!"
   echo "-s - Atualiza status e mostra na tela"
   echo "-p - Atualiza status e mostra na polybar"
   exit 1
fi

case $* in
    -p)
        update_polybar
        break
        ;;
    -s)
        update_show
        break
        ;;
    *)
        echo "show"
        break
        ;;
esac    
