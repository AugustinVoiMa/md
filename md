#! /bin/bash

check(){
  type $1 >/dev/null 2>&1 || { echo -e >&2 "$1 require foo but it's not installed.\nInstall it with\n\tsudo apt install $1\nAborting."; exit 1; }
}

print_help(){
  echo "Markdown viewer in shell"
  echo -e "\t$ md file.md"
}

check markdown;
check w3m;

if [ $# = 1 ]; then
  if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    print_help;
    exit 0;
  fi
  if [ ! -e $1 ]; then
    echo "File $1 does not exists. Please give a markdown file"
    exit 1;
  fi
  markdown $1 | w3m -T text/html;
  exit $?;
else
  print_help;
  exit 1;
fi
