
Starter Kit
================================================================================

Ce dépôt GIT sert de kit de démarrage pour les projets d'intégration statique.

Il contient toutes nos bonnes pratiques et tous les outils nécessaires pour
nos projets d'intégration statique. Parmi tous les outils
présents dans ce kit vous trouverez ceux qui doivent être utilisés
obligatoirement aussi bien que ceux qui sont simplement recommandés.

Chaque outil utilisé dispose d'une documentation dédiée sur la façon de
l'utiliser dans notre contexte. Cette documentation est rédigée au format
Markdown et est disponible dans le répertoire `docs` de ce dépôt.


Créer un nouveau projet
--------------------------------------------------------------------------------
Pour créer un nouveau projet, suivez simplement les instructions ci-après.

## Vérifiez votre environnement
Tous nos projet pré-supposent que votre environnement dispose des outils suivant
installés au niveau global sur votre machine :

* [Git](http://git-scm.com/)
* [NodeJS](http://nodejs.org/)
* [Grunt CLI](http://gruntjs.com/getting-started)

> Pour **Mac** : _vous devez obligatoirement installer XCode et les outils en
  ligne de commande qui l'accompagne. Il est également recommandé d'installer et d'utiliser
  [Homebrew](http://brew.sh/) pour installer tous les outils en ligne de
  commande dont vous pourriez avoir besoin._

## Démarrez votre projet

Télécharger le contenu de ce dépôt et l'utiliser comme base de démarrage

Une fois que vous aurez récupéré le contenu de ce dépôt, vous avez la possibilité d'ajouter les outils recommandés ci-après (voir section : Outils recommandés).

Lorsque le dépôt est rapatrié en local, exécutez les commandes
suivantes :

```bash
$ npm install
```

## Organisation des fichiers
Pour harmoniser notre travail, tous les projets utiliserons la structure de
fichiers suivante.

Les sources sur lesquelles nous travaillons sont toutes dans le répertoire `src`.
Normalement, seuls les fichiers présents dans ce répertoire devraient être
modifiés après le début du projet.

* `/src`
* `/src/css` : L'ensemble des fichiers CSS du projet
* `/src/js`   : L'ensemble des sources JavaScript du projet
* `/src/img`  : L'ensemble des images d'interface du projet
* `/src/img/sprites` : L'ensemble des images d'interface qui seront regroupées en sprites
* `/src/fonts`: L'ensemble des _fonts_ utilisées par le projet
* `/src/tpl`  : L'ensemble des gabarits HTML du projet
* `/src/tpl/data` : Les fichiers JSON de données à injecter dans les gabarits HTML
* `/src/tpl/inc`  : Les gabarits partiels à injecter dans les pages HTML
* `/src/tpl/layout` : Les gabarits globaux de base pour les pages HTML
* `/src/tpl/pages`  : L'ensemble des gabarits d'assemblage des pages HTML
* `/src/docs` : L'ensemble de la documentation statique du projet au format Markdown

A chaque fois que le projet est "construit", le résultat est disponible dans
les répertoires suivant:

* `/build`
* `/build/docs` : Toute la documentation du projet au format HTML
* `/build/dev` : Le projet construit sans optimisation pour le développement
* `/build/prod` : Le projet statique optimisé pour la livraison final

La compilation est dépendante des paramètres de `locale` courant, qui peuvent
varier d'un poste à un autre, y compris sur un serveur distant où ces paramètres
sont influencés par la configuration locale de votre machine. Il est donc
déconseillé de lancer une tâche de *build* à distance soi-même : mieux vaut
planifier une tâche dont le contexte d'exécution sera toujours le même.

Tâches normalisées
--------------------------------------------------------------------------------

Tout projet démarré avec ce starter kit dispose d'un certain nombre de tâches
Grunt normalisées utilisables quels que soient les modules grunt utilisés.

**live**: permet de démarrer un serveur statique pour les pages HTML et d'avoir
un _watch_ sur les fichiers du projet en même temps.

> **ATTENTION:** _Même si tous les chemins sont résolus de manière relative, il
  est vivement conseillé de préférer cette méthode à tout autre serveur local
  que vous pourriez utiliser. De cette manière vous verrez toujours votre site
  "à la racine". Votre site répondra sur l'URL: http://localhost:8000_

```bash
$ grunt live
```

**build**: contruit la version statique du projet (compile les fichiers CSS,
assemble les fichiers HTML, etc.)

```bash
$ grunt build
```

**css**: Construit les feuilles de styles et gère les images associées

```bash
$ grunt css
```

**html**: Construit les pages HTML

```bash
$ grunt html
```

**js**: Construit les fichiers JS

```bash
$ grunt js
```

**test**: Lance tous les tests du projet

```bash
$ grunt test
```

Outils obligatoires
--------------------------------------------------------------------------------
Les outils listés ici doivent êtres utilisés obligatoirement lorsqu'on démarre
un nouveau projet d'intégration. _Le seul cas où on ne les utilisera pas sera
lorsqu'on aura une demande explicite du client pour utiliser autre chose._

* [Grunt](docs/grunt.md)
* [Assemble](docs/assemble.md)
* [Linter](docs/linter.md)


Outils recommandés
--------------------------------------------------------------------------------
Les outils listés ci-après sont des recommandations. Ils peuvent apporter des
fonctionnalités originales ou en cours d’expérimentation. Vous êtes libre de
les utiliser, ou non, selon vos envies ou votre contexte projet.

* [KSS](docs/kss.md)
