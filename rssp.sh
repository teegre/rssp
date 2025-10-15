#! /usr/bin/env bash

#    __  __  __    ___ 
#   /__\/ _\/ _\  / _ \
#  / \//\ \ \ \  / /_)/
# / _  \_\ \_\ \/ ___/ 
# \/ \_/\__/\__/\/     
#
# C : 2021/10/20
# M : 2025/10/13
# D : quick rss feed parser.

parse_feed() {
  local IFS='>'
  # shellcheck disable=SC2162
  read -d '<' TAG VALUE

}

html_unescape() {
  local text="$1";
  text="${text//\&lt\;/\<}"
  text="${text//\&gt\;/\>}"
  text="${text//\&amp\;/\&}"
  text="${text//\&nbsp\;/\ }"
  text="${text//\&quot\;/\"}"
  echo "$text"
}

[[ $1 == "-t" ]] && { T=1; shift; } # display rss channel's title only.
feed="$1"

[[ $feed ]] || {
  echo "rssp version 0.3"
  echo "quick rss feed parser."
  echo
  echo "usage: rssp [-t] <url|file>"
  echo
  echo "options:"
  echo "  -t display rss channel's title only."
  echo
  exit
}

if [[ $feed =~ ^https? ]]; then
  content="$(curl -s "$feed")"
else
  content="$(<"$feed")"
fi

while parse_feed; do
  case $TAG in
    item | entry)
      unset pubdate link title
      ;;
    title)
      title="$VALUE"
      [[ $VALUE ]] || { TT=1; continue; }
      if [[ $T ]]; then 
        echo "$(html_unescape "$title")"
        exit
      fi
      ;;
    link*)
      if [[ $TAG =~ .*href=\"(.+)\" ]]; then
        link="${BASH_REMATCH[1]}"
      else
        link="$VALUE"
      fi
      [[ $link =~ /shorts/ ]] && title="[SHORT] $title"
      ;;
    pubDate | published)
      pubdate="$(date -d "$VALUE" "+%Y/%m/%d")"
      ;;
    /item | /entry)
      printf '%s %s\n' "$pubdate" "$(html_unescape "$title")"
      echo "$link"
      ;;
    \!\[CDATA*)
      [[ $TAG =~ \!\[CDATA\[(.+)\]\] ]] &&
        [[ $TT ]] && {
          [[ $T ]] && {
            echo "${BASH_REMATCH[1]}"
            exit
          }
          title="${BASH_REMATCH[1]}"
        }
      ;;
    /title)
      unset TT
  esac

done <<< "$content"
