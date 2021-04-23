#!/usr/bin/env bash
set -x

echo 'Ruby skeleton project setup'

PROJECT_NAME=$1

if [[ -z "${PROJECT_NAME}" ]]; then
  echo 'ENV PROJECT_NAME is misssing \n Usage ruby-template << projet_name  >>' && exit 123
fi

cwd=$(pwd)

if [ ! -d $cwd/$PROJECT_NAME ]; then
    echo "Ruby Project Creating $PROJECT_NAME"

    cd $cwd
    echo $cwd
    mkdir $PROJECT_NAME

    cd $PROJECT_NAME
    mkdir lib
    mkdir bin
    mkdir spec
    touch README.md
    touch Rakefile
    touch Gemfile
    touch .gitignore

    echo '.DS_Store' > .gitignore

    cd spec
    mkdir $PROJECT_NAME
    touch spec_helper.rb
    echo 'require' $PROJECT_NAME'' > spec_helper.rb

    cd ..
    cd lib
    mkdir $PROJECT_NAME
    touch $PROJECT_NAME.rb

    cd ..
    echo 'require "rspec/core/rake_task"' >> Rakefile
    echo 'RSpec::Core::RakeTask.new(:spec)' >> Rakefile
    echo 'desc "Run the default task"' >> Rakefile
    echo 'task :default => [:spec]' >> Rakefile

    echo 'source "https://rubygems.org"' >> Gemfile
    echo 'gem "rake"' >> Gemfile
    echo 'gem "rspec"' >> Gemfile

    echo $PROJECT_NAME > README.md

    bundle install

    echo 'project is successfully created.'

    cd $cwd/$PROJECT_NAME
else
   echo '\tproject name already exists. \n\thelp: \tplease run the script again with different project name.'
fi
