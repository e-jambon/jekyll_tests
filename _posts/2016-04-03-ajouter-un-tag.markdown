---
layout: post
title: Ajouter un tag
date: 2016-04-03T15:02:11+02:00
extra_css:
    - embark-IT.css
---

## Structure 

J'ai ajouté un Gemfile. 
En l'occurrence pour ce test j'utilise une gem supplémentaire.

Conséquence : Mon test ne marche pas sur les github pages (ce sont les spécifications de JS qui veulent ça, question de sécurité).

Donc j'utilise bundle pour gérer mes dépendances (donc à installer pour utiliser)
Conséquence : 

1. Pour installer mes dépendances, il faut bundle et faire dans une ligne de commande, dans le répertoire du projet

        bundle install

2. Pour utiliser mon jekyll il faut lancer en utilisant bundle exec :

        bundle exec jekyll build 
        bundle exec jekyll serve 
        etc..



## Plugin liquidtag embark

Utilisation : 
    embark http://www.google.com__Mon titre ici__Mon commentaire ici. Ca peut contenir ce que je veux, même du html <br> Saut de ligne ou autre.__style

L'argument style renvoie vers le css : 
    
        assets/css/postspecific/embark-valeurDeStyle.css

Résultat obtenu :

{%  embark http://www.google.com__Mon titre ici__Mon commentaire ici. Ca peut contenir ce que je veux, même du html <br> Saut de ligne ou autre.__IT %}


