#!/usr/bin/env bash

BANCO='database/agenda.db'
TABELA='usuario'
MSG_USO="
Uso: $0 [ OPÇÃO ]

OPEÇÃO: 
    -c | --cadastrar - Cadastro de usuario
    -r | --remover - Remover usuario
    -l | --listar - listar usuario 
    -b | --buscar - busca de usuario
    -a | --atualizar - login obrigatorio para atualizar
"
source lib_db
_pega-dados(){
    echo "Cadastrar de usuario"
    echo -n "Digite o login: "
    read login
    [  "$(_tem $login )" ] || {
        return 1
    }
    echo -n "Digite o nome: "
    read nome
    nome=$(echo "$nome" | sed 's/ /+/g')
    echo -n "Digite o idade: "
    read idade
    echo -n "Digite o sexo: "
    read sexo
}

cadastrar(){
    _pega-dados
    _insert $login $nome $idade $sexo
}

remover(){
    echo "Remover de usuario"
    _all login| sed 's/\n / - /g' 
    echo "Digite o login do usuario que sera removido: "
    read usuario
    _delete $usuario
}

listar(){
    echo "Listar de usuario"
    _find
}

buscar(){
    echo "Digite o login"
    read usuario
    _find $usuario
}

atualizar(){
    buscar 
}

case $1 in
    -c | --cadastrar) cadastrar ;;
    -r | --remover) remover ;;
    -l | --listar) listar ;;
    -b | --buscar) buscar ;;
    -a | --atualizar) atualizar ;;

    *)
        echo "$MSG_USO"
esac
