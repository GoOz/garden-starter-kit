
Linter
================================================================================

Les Linters sont des outils qui vérifient la qualité du code. Dans le starter kit,
2 linters sont en place : JavaScript et Sass


Linter JavaScript : JSHint
--------------------------------------------------------------------------------

[JSHint](http://jshint.com/) vérifie la qualité du code JavaScript.

Il est possible de surcharger les règles par défaut via le fichier *.jshint*.
Pour voir les options possibles, c'est [ici](http://jshint.com/docs/options/).

Certains éditeurs, tels que [Sublime](http://www.sublimetext.com/), sont capables
de lire cette configuration et de verifier le linting à la demande. Voir la [liste
des plugins disponibles](http://www.jshint.com/install/).

Voici quelques-unes des options choisies :

``` "strict" : true ```

On force l'utilisation du [mode Strict](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode), qui permet notamment une meilleure gestion des erreurs.

``` "evil" : false ```

On empêche l'utilisation de la fonction ```eval``` car elle contient des vulnérabilités.

 ``` "eqeqeq" : true ```

Lors de comparaison via ```==```, on force l'utilisation de ```===``` (comparaison stricte). Cela est d'une part plus performant, et d'autre part permet d'éviter des résultats inattendus.


Linter Sass : StyleLint
--------------------------------------------------------------------------------

[StyleLint](https://github.com/stylelint/stylelint) vérifie la qualité du code CSS.

Il est possible de surcharger les règles par défaut via le fichier *.stylelintrc*.
Pour voir les options possibles, c'est [ici](http://stylelint.io/user-guide/rules/).

Certains éditeurs, tels que [Sublime text 3](http://www.sublimetext.com/3), sont
capables de lire cette configuration et de verifier le linting à la demande.
[Documentation du plugin Sublime](https://github.com/kungfusheep/SublimeLinter-contrib-stylelint)
