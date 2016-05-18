// Définition du LazyPipe pour linter Stylus
'use strict';

// MODULES
// ----------------------------------------------------------------------------
var lazypipe = require('lazypipe');
var stylelint  = require('stylelint');

// LINTER CONFIGURATION
// ----------------------------------------------------------------------------
var LINT = {
  config: './.stylelintrc'
};

module.exports = function () {
  var lazystream = lazypipe()
    .pipe(stylelint, LINT)
    .pipe(stylelint.reporter)
    .pipe(stylelint.reporter, 'fail');

  return lazystream();
};
