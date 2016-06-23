
Grunt
================================================================================

Pour tous nos projets, nous automatisons les tâches répétitives à l'aide de
[Grunt](http://gruntjs.com/)

> **NOTE :** _L'utilisation d'autres outils d'automatisation des tâches n'est
  autorisé que si le client en fait une demande explicite_


Vérifier votre environnement
--------------------------------------------------------------------------------

Grunt repose sur [NodeJS](http://nodejs.org/), assurez-vous que vous l'avez bien
installé sur votre environnement.

Il est également nécessaire d'installer l'utilitaire Grunt CLI dans votre
environnement global (cela vous permet d'accéder à la commande `grunt` dans
votre terminal).

Si ce n'est pas déjà le cas, exécutez simplement la commande suivante :

```bash
$ sudo npm install -g grunt-cli
```

Nous vous recommandons également de prendre le temps de lire l'article
"[Getting Started](http://gruntjs.com/getting-started)" sur le site officiel du
projet.


Configuration standard
--------------------------------------------------------------------------------

La configuration standard de Grunt est celle avec laquelle tous nos projets
doivent être initialisés. Cette configuration comprend un jeu de plugins
standardisé ainsi que certaines tâches normalisées identiques pour tous les
projets.


### Plugin standards
Par défaut, tout projet utilise les plugins suivant avec leur tâches associées :

* [assemble](https://github.com/assemble/assemble/)
* [grunt-contrib-clean](https://github.com/gruntjs/grunt-contrib-clean)
* [grunt-contrib-concat](https://github.com/gruntjs/grunt-contrib-concat)
* [grunt-contrib-connect](https://github.com/gruntjs/grunt-contrib-connect)
* [grunt-contrib-copy](https://github.com/gruntjs/grunt-contrib-copy)
* [grunt-contrib-imagemin](https://github.com/gruntjs/grunt-contrib-imagemin)
* [grunt-contrib-jshint](https://github.com/gruntjs/grunt-contrib-jshint)
* [grunt-contrib-uglify](https://github.com/gruntjs/grunt-contrib-uglify)
* [grunt-contrib-watch](https://github.com/gruntjs/grunt-contrib-watch)
* [grunt-newer](https://github.com/tschaub/grunt-newer)
* [grunt-prettify](https://github.com/jonschlinkert/grunt-prettify)
* [grunt-postcss](https://github.com/nDmitry/grunt-postcss)
* [grunt-usemin](https://github.com/yeoman/grunt-usemin)
* [grunt-svgstore](https://github.com/FWeinb/grunt-svgstore)
* [postcss](https://github.com/postcss/postcss)
* [postcss-cssnext](https://github.com/MoOx/postcss-cssnext)
* [css-mqpacker](https://github.com/hail2u/node-css-mqpacker)
* [cssnano](https://github.com/ben-eb/cssnano)
* [postcss-import](https://github.com/postcss/postcss-import)
* [postcss-reporter](https://github.com/postcss/postcss-reporter)
* [stylelint](https://github.com/stylelint/stylelint)


### Tâches normalisées
Tous nos projets doivent, de manière standard proposer les tâches normalisées
suivantes:

#### live
Cette tâche est celle à utiliser lors de l'intégration. Elle reconstruit le
projet puis lance un serveur web statique sur la version de développement et
enfin elle observe tous les changements sur les fichiers sources. Les changements
seront automatiquement répercutés sur le _build_ de développement et le
navigateur sera mis à jour.

```bash
$ grunt live
```

Cette tâche est un raccourcis pour le lancement successif des tâches _build_,
_connect_ et _watch_ (voir ci-après). Elle propose en outre une fonction de
_livereload_.

```bash
$ grunt live --sass=no
```

#### build
Cette tâche va intégralement reconstruire le contenu du dossier `/build`.
Cela inclus, la documentation du projet au format HTML, la version statique de
développement du projet et la version statique prête à être livrée pour la
production.

```bash
$ grunt build
```

#### css
Cette tâche va s'occuper de contruire toutes les feuilles de styles et leurs
ressources associées (images, fontes, etc.)

```bash
$ grunt css
```

#### html
Cette tâche va s'occuper de contruire toutes les pages HTML

```bash
$ grunt html
```

#### js
Cette tâche va s'occuper de contruire tous les fichiers JavaScript

```bash
$ grunt js
```

#### test
Cette tâche va lancer tous les tests présents sur les fichiers du projet

```bash
$ grunt test
```

#### connect
Cette tâche offre la possibilité d'avoir un serveur web statique autonome pour
visualiser le résultat d'un _build_. Elle se subdivise en deux sous-tâches, une
pour la version statique de développement et une pour la version statique de
production :

```bash
$ grunt connect:dev
```

Cette tâche permet d'accéder au site web statique de développement à l'adresse
[http://localhost:8000](http://localhost:8000). Elle permet également d'accéder
à la version HTML de la documentation du projet à l'adresse
[http://localhost:8000/docs/](http://localhost:8000/docs/)

```bash
$ grunt connect:prod
```

Cette tâche permet d'accéder au site web statique avec toutes les optimisations
pour la production à l'adresse [http://localhost:8001](http://localhost:8001)

#### watch
Cette tâche permet de lancer tous les observateurs disponibles pour le travail
de développement. Leur travail consiste à mettre à jour le _build_ de
développement pour pouvoir vérifier le résultat dans un navigateur.

Sauf cas très spécifique, il est conseillé d'utiliser la tâche _live_ plutôt que
_watch_ directement.

```bash
$ grunt watch
```


Autres tâches
--------------------------------------------------------------------------------

En plus de la configuration standard, il est tout-à-fait possible d'utiliser
d'autre tâches Grunt. Selon le contexte projet, tout est possible.

Nous recommandons cependant d'enregistrer les plugins associés à ces tâches dans
la section `devDependencies` du fichier `package.json`, la section
`dependencies` étant réservée aux tâches standards. Pour cela, il suffit
d'utiliser le flag `--save-dev` lors de l'installation de la tâche :

```bash
$ npm install <nom-de-la-tâche> --save-dev
```
