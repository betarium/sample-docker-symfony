#!/bin/sh

if [ ! -d symfony ] ; then
  symfony new symfony --version="5.2" --php=8.1 --webapp

  rm -rf symfony/.git
fi

cd symfony

composer require "annotations:<6.2.10"
composer require symfony/twig-bundle

composer require symfony/apache-pack

composer install

apachectl restart
