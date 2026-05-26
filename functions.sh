#!/usr/bin/env bash

#### Auxiliary functions ####
.refs()
{
  # Used refs
  while read ref
  do
    echo ${ref:2:-2}
  done < <(typst query --font-path "$FONT_PATH" main.typ ref | jq '[.[] | select(.element == null) | {ref: .target}] | .[] | .ref')
  [[ -n "$1" ]] && local file="$1" || local file="references.bib"
  # All declared refs
  while read line
  do
    if [[ "${line:0:1}" = "@" ]]; then
      echo "${line/,}" | sed -e "s/@.*{//g"
    fi
  done < "$file"
}

.count-refs()
{
  while read line
  do
    line=($line)
    if [[ -z "${line[1]}" ]]; then
      continue
    fi
    echo -e "\t$((${line[0]} - 1)) ${line[1]}"
  done < <(.refs | sort | uniq -c)
}

.functions()
{
  local file="$1"
  while read line
  do
    if [[ "$line" =~ ^[^.].*\(\)$ ]]; then
      echo "${line%\(\)}"
    fi
  done < <(sort -u "$file")
}

.has.function()
{
  local func="$1"
  local funcs="$(.functions ./functions.sh)"
  grep "^${func}$" <(echo "$funcs") &> /dev/null
}

.check.bool.prompt()
{
  local can_hide=true
  [[ "$1" = "-n" ]] && can_hide=false && shift
  local prompt="$1 [y/n]"
  local hide_prompt=$(printf ' %.0s' $(seq 1 ${#prompt}))
  local ans
  while read -s -n 1 -p "$prompt" ans
  do
    $can_hide && echo -e "\r$hide_prompt\r" || echo
    if [[ "$ans" =~ [yYnN] ]]; then
      [[ "$ans" =~ [yY] ]] && return 0 || return 1
    fi
  done
}

#### Functions ####
count-refs()
{
  .count-refs | sort -nr
}

zip-update()
{
  local zipfile="$1"
  [[ -n "$2" ]] && local cmpdir="$2" || local cmpdir="."
  shift 2
  if ! [[ -f "$zipfile" ]]; then
    echo "'$zipfile' is not a valid file." >&2
    return 1
  fi
  local zipdir=$(mktemp -d)
  unzip "$zipfile" -d "$zipdir" &> /dev/null
  while read file
  do
    file=${file##$zipdir/}
    local curfile="$cmpdir/$file"
    local newfile="$zipdir/$file"
    if ! [[ -e "$curfile" ]]; then
      if .check.bool.prompt "Copy new ${file}?"; then
        cp "$newfile" "$curfile"
      fi
    elif ! cmp "$curfile" "$newfile" &> /dev/null; then
      if .check.bool.prompt "Override ${file}?"; then
        cp "$newfile" "$curfile"
      fi
    fi
  done < <(find "$zipdir" -type f)
  #rm -rf "$zipdir"
}

if .has.function "$1"; then
  "$@"
else
  echo "ERROR: '$1' not found!" >&2
  exit 10
fi
