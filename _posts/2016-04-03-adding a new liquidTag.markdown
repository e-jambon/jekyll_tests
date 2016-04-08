---
layout: post
title: Adding a new liquidtag
date: 2016-04-03T15:02:11+02:00
extra_css:
    - embark-IT.css
---
## Structure 

Added a Gemfile.
Lists all the gems I use.

Therefore, this site can't be hosted on github pages, which do not accept plugins for security reasons.

I use bundle to manage dependencies. You need to install bundle in order to use it. cf : [bundler](http://bundler.io/)

1. To install all dependencies, run the following :

        bundle install

2. To launch jekyll, use the following command : 

        bundle exec jekyll build 
        bundle exec jekyll serve 
        etc..



## Plugin liquidtag embark

### Usage : 
    embark http://www.google.com__Mon titre ici__Mon commentaire ici. Ca peut contenir ce que je veux, même du html <br> Saut de ligne ou autre.__style

The style parameter refers to  : 
    
        assets/css/postspecific/embark-stylValue.css

### Site Regeneration :
By default, every embarked link is being cached.
Therefore, each regeneration does not take for ages fetching every data back from your linked websites. If you want to go fetch all embarked links, remove this folder :

        assets/embarked folder.

If you do so, it will take much more time to build everything again.

### Result :

{%  embark http://www.google.com__Mon titre ici__Mon commentaire ici. Ca peut contenir ce que je veux, même du html <br> Saut de ligne ou autre.__IT %}
<br/>

###  Todo :

- Tests
- Error management
- Handle the cache differently, so it is possible to remove the cache for a given post / page.
- Change interface, particularly the __ delimitation between parameters.

### Known issues
- Using the delimitation mark '__' within a parameters triggers a bug.

