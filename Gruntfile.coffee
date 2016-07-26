module.exports = (grunt) ->
  try
    require('time-grunt')(grunt)
  catch error
    grunt.log.debug "time-grunt not installed"
  semver = require 'semver'
  pkg = grunt.file.readJSON 'package.json'

  # TÂCHES PERSONNALISÉES COMMUNES A TOUS LES PROJETS
  # ============================================================================
  # $ grunt live
  # Lance tous les watcher grunt ainsi qu'un serveur statique pour voir le
  # contenu du repertoir `/build/dev`. Ce serveur utilise livereload pour
  # rafraichir automatiquement le navigateur dès qu'un  fichier est mis à jour.
  grunt.registerTask 'live',  ['build', 'connect:live', 'watch']

  # $ grunt build
  # Régénère le contenu du dossier `/build`. Il est recommandé de lancer cette
  # tache à chaque fois que l'on réalise un `git pull` du projet.
  grunt.registerTask 'build', ['clean', 'css', 'html', 'js', 'svgstore', 'copy', 'test']

  # $ grunt css
  # Régènère uniquement les feuilles de styles (et les sprites/images associés)
  grunt.registerTask 'css', ['postcss', 'imagemin', 'copy:fonts']

  # $ grunt html
  # Régènère uniquement les pages HTML
  grunt.registerTask 'html', ['assemble', 'prettify', 'kss']

  # $ grunt js
  # Régènère uniquement les fichiers JS
  grunt.registerTask 'js', ['copy:js', 'useminPrepare', 'concat:generated', 'uglify:generated', 'usemin']

  # $ grunt test
  # Lance les tests du projets
  grunt.registerTask 'test', ['jshint']

  # $ grunt kss
  # Generation du style guide basé sur les commentaires KSS des fichiers SCSS
  # Alias de grunt exec:kss
  grunt.registerTask 'kss', ['exec:kss']

  # CHARGE LES TÂCHES A LA DEMANDE POUR ACCELERER
  # L'EXECUTION DES TâCHES APPELLÉES INDIVIDUELLEMENT
  # ============================================================================
  [
    'grunt-assemble'
    'grunt-contrib-clean'
    'grunt-contrib-concat'
    'grunt-contrib-copy'
    'grunt-contrib-imagemin'
    'grunt-contrib-jshint'
    'grunt-contrib-uglify'
    'grunt-exec'
    'grunt-newer'
    'grunt-postcss'
    'grunt-prettify'
    'grunt-svgstore'
  ].forEach (npmTask) ->
    task = npmTask.replace /^grunt-(contrib-)?/, ''
    grunt.registerTask task, [], () ->
      grunt.loadNpmTasks npmTask
      grunt.task.run task

  # taches qui doivent être distinguées via `task:distinction`...
  # ... ou taches qui ne peuvent pas être optimisées de cette manière
  [
    'grunt-usemin'
    'grunt-contrib-connect'
    'grunt-contrib-watch'
  ].forEach (npmTask) ->
    grunt.loadNpmTasks npmTask



  # CONFIGURATION DES TÂCHES CHARGÉES
  # ============================================================================
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'


    # HTML
    # ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
    # Les tâches suivantes sont exclusivement dédiées au traitement du HTML

    # $ grunt assemble
    # --------------------------------------------------------------------------
    # Utilise Handlebars pour créer les sources HTML du projet à partir de
    # gabarits factorisés
    assemble:
      options:
        helpers   : ['handlebars-helper-compose', 'src/helpers/**/*.js']
        partials  : 'src/tpl/inc/**/*.hbs'
        layoutdir : 'src/tpl/layouts'
        layout    : 'default.hbs'

      dev:
        options:
          assets : 'build/dev/'
          data   : 'src/tpl/data/{*,dev/*}.json'
        expand : true
        cwd    : 'src/tpl/'
        src    : ['index.hbs','pages/**/*.hbs']
        dest   : 'build/dev'

      prod:
        options:
          assets : 'build/prod/'
          data   : 'src/tpl/data/{*,prod/*}.json'
        expand : true
        cwd    : 'src/tpl/'
        src    : ['index.hbs','pages/**/*.hbs']
        dest   : 'build/prod'

      doc:
        options:
          assets : 'build/'
          data   : 'src/tpl/data/{*,dev/*}.json'
          layout : 'documentation.hbs'
        files: [{
          expand : true
          cwd    : 'docs/'
          src    : ['**/*.md']
          dest   : 'build/dev/docs/docs'
        },{
          src : 'readme.md'
          dest: 'build/dev/docs/index.html'
        },{
          expand : true
          cwd    : 'src/docs/'
          src    : ['**/*.md']
          dest   : 'build/dev/docs'
        }]

    # $ grunt prettify
    # --------------------------------------------------------------------------
    # Indente correctement le HTML du build de dev pour qu'il soit plus lisible
    prettify:
      options:
        config: '.jsbeautifyrc'
      dev:
        expand: true
        src   : ['build/dev/**/*.html']
      prod:
        expand: true
        src   : ['build/prod/**/*.html']


    # IMAGES
    # ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
    # Les tâches suivantes sont exclusivement dédiées au traitement des images

    # $ grunt imagemin
    # --------------------------------------------------------------------------
    # Optimise automatiquement les images (png, jpeg, gif et svg)
    # Seul les images à la racine de `src/img` sont optimisées. Les images
    # optimisées sont automatiquement placées dans `build/dev`
    imagemin:
      options:
        progressive: false
        svgoPlugins: [
          removeHiddenElems  : false
          convertStyleToAttrs: false
        ]
      dev:
        files: [
          expand: true,
          cwd   : 'src/img/',
          src   : ['*.{png,jpg,gif,svg}', 'dummy/*'],
          dest  : 'build/dev/img/'
        ]
      prod:
        files: [
          expand: true,
          cwd   : 'src/img/',
          src   : ['*.{png,jpg,gif,svg}', 'dummy/*'],
          dest  : 'build/prod/img/'
        ]

    svgstore:
      options:
        prefix : 'icon-' # This will prefix each ID
        svg: # will add and overide the the default xmlns="http://www.w3.org/2000/svg" attribute to the resulting SVG
          viewBox : '0 0 100 100',
          xmlns: 'http://www.w3.org/2000/svg'
          'xmlns:xlink': 'http://www.w3.org/1999/xlink'
          class: 'icons'
      default :
        files:
          'src/img/icons.svg': ['src/img/svgs/*.svg']


    # CSS
    # ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
    # Les tâches suivantes sont exclusivement dédiées au traitement de CSS

    # $ grunt postcss
    # --------------------------------------------------------------------------
    # Applique des filtres de post-traitement aux feuilles de styles générées
    # Les post processeur CSS utilisés sont:
    # * CSSnext http://cssnext.io
    # * postcss-import https://github.com/postcss/postcss-import
    # * css-mqpacker https://github.com/hail2u/node-css-mqpacker
    postcss:
      options:
        processors: [
          require('postcss-import')({
            plugins: [
              require('stylelint')()
            ]
          })
          require('css-mqpacker')({
            sort: true
          })
          require('postcss-cssnext')({
            browsers: 'last 2 versions, > 5%'
          })
          require("postcss-reporter")({ clearMessages: true })
          require('cssnano')({
            autoprefixer: false
          })
        ]
      dev:
        src: 'src/css/style.css'
        dest: 'build/dev/css/style.css'
      prod:
        src: 'src/css/style.css'
        dest: 'build/prod/css/style.css'
      doc:
        src: 'src/css/doc.css'
        dest: 'build/dev/css/doc.css'
      docProd:
        src: 'src/css/doc.css'
        dest: 'build/prod/css/doc.css'



    # JS
    # ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
    # Les tâches suivantes sont exclusivement dédiées au traitement de JS

    # $ grunt useminPrepare
    # --------------------------------------------------------------------------
    useminPrepare:
      prod:
        src: 'build/dev/pages/*.html'
        options:
          dest: 'build/prod/pages'

    # $ grunt usemin
    # --------------------------------------------------------------------------
    usemin:
      prod:
        src: 'build/prod/**/*.html'

    # $ grunt jshint
    # --------------------------------------------------------------------------
    # Vérifie que les fichiers Javascript suivent les conventions de codage
    jshint:
      all: ['src/**/*.js','!src/js/lib/**/*.js']
      options:
        jshintrc: '.jshintrc'



    # UTILITAIRES
    # ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
    # Les tâches suivantes sont des utilitaires génériques

    # $ grunt clean
    # --------------------------------------------------------------------------
    # Supprime tous les fichiers avant de lancer un build
    clean:
      dev : ['build/dev']
      prod : ['build/prod']

    # $ grunt copy
    # --------------------------------------------------------------------------
    # Déplace tous les fichiers qui ont besoin de l'être
    copy:
      fonts:
        files: [{
          expand: true
          cwd: 'src'
          src: ['fonts/**/*']
          dest: 'build/dev/'
        },
        {
          expand: true
          cwd: 'src'
          src: ['fonts/**/*']
          dest: 'build/prod/'
        }]
      js:
        files: [{
          expand: true
          cwd: 'src'
          src: ['js/**/*.js']
          dest: 'build/dev/'
        }]
      icons:
        files: [{
          expand: true
          cwd: 'src/img'
          src: ['icons.svg']
          dest: 'src/tpl/inc/'
          rename: (dest, src) ->
            dest + src.replace(/\.svg$/, ".hbs")
        }]

    # $ grunt exec
    # --------------------------------------------------------------------------
    # Permet d'executer n'importe quelle commande shell
    exec:
      kss: 'kss-node -c kss.json'

    # $ grunt connect
    # --------------------------------------------------------------------------
    # Static web server près à l'emplois pour afficher du HTML statique.
    connect:
      options:
        hostname: '*'

      # $ grunt connect:live
      # Uniquement pour être utilisé avec watch:livereload
      live:
        options:
          base       : 'build/dev'
          port       : 8000
          livereload : true

      # $ grunt connect:dev
      # Pour pouvoir voir le contenu du repertoire `/build/dev`
      # A l'adresse http://localhost:8000
      dev:
        options :
          base       : 'build/dev'
          port       : 8000
          keepalive  : true

      # $ grunt connect:prod
      # Pour pouvoir voir le contenu du repertoire `/build/prod`
      # A l'adresse http://localhost:8000
      prod:
        options :
          base       : 'build/prod'
          port       : 8001
          keepalive  : true

    # $ grunt watch
    # --------------------------------------------------------------------------
    # Configuration de tous les watcher du projet
    watch:
      options:
        spawn: false
      livereload:
        options:
          livereload: true
        files: ['build/dev/**/*']
      css:
        files: ['src/css/**/*.css']
        tasks: ['postcss']
      images:
        files: 'src/img/*.{png,jpg,gif,svg}'
        tasks: ['newer:imagemin:dev']
      js:
        files: 'src/js/**/*.js'
        tasks: ['newer:copy:js', 'newer:jshint']
      html:
        files: 'src/tpl/**/*.hbs'
        tasks: ['assemble:dev','newer:prettify:dev']
      fonts:
        files: 'src/fonts/**/*'
        tasks: ['newer:copy:fonts']
      svg:
        files: 'src/img/svgs/*.svg'
        tasks: ['svgstore','copy:icons','assemble:dev','newer:prettify:dev']
