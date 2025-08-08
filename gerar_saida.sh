#!/bin/bash

# Este script executa o comando para concatenar o conteúdo de arquivos específicos em um único arquivo.
find lib pubspec.yaml -type f -exec cat {} + > saida_completa.txt
