// Définition du LazyPipe pour utiliser LESS
'use strict';

// MODULES
// ----------------------------------------------------------------------------
var lazypipe = require('lazypipe');
var next     = require('postcss-cssnext');
var ENV      = require('../../tools/env');

// CSSNEXT CONFIGURATION
// ----------------------------------------------------------------------------
var CONF = {
  browsers: ENV.autoprefixer || ['> 4%', 'ie >= 8']
};

module.exports = function () {
  var lazystream = lazypipe()
    .pipe(next, CONF);

  return lazystream();
};
