#!/bin/bash

function install_gems() {
  echo "source 'https://rubygems.org'" > Gemfile
  echo "gem 'smashing'" >> Gemfile
  echo "gem 'json'" >> Gemfile
  echo "gem 'thin'" >> Gemfile
  echo "gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]" >> Gemfile

  GEMS=$@
  if [[ ! -z "$GEMS" ]]; then
    for GEM in $GEMS; do
      echo -e "gem '$GEM'" >> Gemfile
    done
  fi

  bundle install
}

if [[ ! -e /installed ]]; then
  install_gems ${GEMS}
  touch /installed
fi

if [[ ! -z "$PORT" ]]; then
  PORT_ARG="-p $PORT"
fi

echo "Gemfile"
echo "----"
cat Gemfile
echo "----"

echo "Starting smashing"
smashing start ${PORT_ARG}