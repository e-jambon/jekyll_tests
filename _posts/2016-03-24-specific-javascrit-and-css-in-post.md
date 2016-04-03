---
layout: post
title: Jekyll, Comment Avoir Un Javascript Et Un Css Spécifique à Une Page
modified:
categories: jekyll
excerpt: Si vous utilisez Jekyll, vous avez peut-être eu besoin de mettre un css ou un javascript spécifique sur un post. Voilà comment j'ai fait.
tags: []
image:
  feature:
extra_css: 
    - css_specifique.css
extra_js:
    - javascript_specifique.js
date: 2016-03-24T00:40:31+01:00
---
Je l'avais fait pour prendre des notes lors d'un cours sur jquery.
Et bien sûr, je n'avais pas documenté. Et j'ai perdu un bon quart d'heure à le retrouver.
Je le pose ici.


Donc dans Jekyll, chaque article dispose de son propre en-tête.
Je veux ajouter une référence vers un css et un javascript à charger spécifiquement, c'est donc là que je vais l'indiquer.

Voilà à quoi ça va ressembler : 


    ---
    layout: post
    title: Jekyll, Comment Avoir Un Javascript Et Un Css Spécifique à Une Page
    modified:
    categories: jekyll
    excerpt: Si vous utilisez Jekyll, vous avez peut-être eu besoin de mettre un css ou un javascript spécifique sur un post. Voilà comment j'ai fait.
    extra_css: 
        - css_specifique.css
    extra_js:
        - javascript_specifique.js
    ---

Dans l'arborescence de Jekyll, vous trouverez un répertoire "assets".  
C'est là que se trouvent les scripts (javascript en particulier) et les feuilles de style (css) utilisées dans vos pages.

## Un CSS spécifique à un article
Dans mon répertoire css, je crée là un sous-répertoire 'postspecific'.
J'y dépose mon css spécifique "css_specifique.css"

Dans mon répertoire "_includes", je trouve mon "head.html".
J'y ajoute ces quelques lignes entre les balises head >:

    {% highlight html %}
        <head>
            { % for css_name in page.extra_css % }
                <link rel="stylesheet" href="{{ site.url }}/assets/css/postspecific/{{ css_name }}">
            { % endfor % }
        </head>
    {% endhighlight %}
    
__Note__ Il n'y a pas d'espace entre les % et les { }.  

Ce code permet donc de charger, dans le header, les liens vers les css que j'ajoute. 
Dans le présent article, en particulier, il n'y en a qu'un :    

    extra_css: 
            - css_specifique.css

## Testons la feuille de style

Voici le contenu, un peu complexe je vous le concède, de ma feuille de style :
    .grosmoche {
        border : 3px;
        background-color: yellow;
    }

Et voilà le html que j'inclus ci-dessous : 
{% highlight html   %}
    <html>
        <div class="grosmoche">
            <p> Quand je suis malin, je tiens à ce que ça se voit.</p>
        </div>
    </html>
{% endhighlight %}

    
<html>
    <div class="grosmoche">
        <p> Quand je suis malin, je tiens à ce que ça se voit.</p>
    </div>
</html>





## Un Javascript spécifique à un article
Devinez ... c'est la même idée.
Je crée un répertoire "javascript" à la racine de mon site (il n'y en a pas, par défaut).
Dans ce répertoire, je crée un répertoire "postspecific", où je déponse mon fichier "javascript_specifique.js".

Ceci étant fait, dans le fichier _include/head.html je fais ma modification pour pouvoir l'appeler :

{% highlight html   %}
    <head>
    
        { % for js_name in page.extra_js % }
            <script type='text/javascript' src="{{ site.url }}/assets/javascript/postspecific/{{ js_name }}"></script>
        { % endfor % }
    
    </head>
{% endhighlight %}

__Note :__ Même remarque. Pas d'espace entre % et les { }


Voilà, c'est tout. Normalement, si je me suis pas gouré (l'idée y est), ça devrait marcher.
Remarquez ma configuration est très différente. Donc je teste de suite.

## Testons le javascript

Voici le code javascript super élaboré que je teste dans cette page :

{% highlight javascript %}
function boom(){
  alert('Boom !');  
}
}
{% endhighlight %}
    
Et je l'appelle ci-dessous en créant un bouton en mettant du code html dans ma page :

{% highlight html %}
    <html>
    <input 
        id= "bouton_danger"
        type="button" 

        value="Détonateur">
    </html>
{% endhighlight %}
    

<html>
    <input 
    id= "bouton_danger"
    type="button" 
    onclick="boom()"
    value="Détonateur">
</html>



<br />
<br />
Bon... Testez si le coeur vous en dis.



