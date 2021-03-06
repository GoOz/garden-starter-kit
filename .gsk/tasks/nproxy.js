'use strict';

// MODULES
// ----------------------------------------------------------------------------
var gulp   = require('gulp');
var nproxy = require('nproxy');
var argv   = require('yargs').argv;
var ENV    = require('../tools/env');


// TASK DEFINITION
// ----------------------------------------------------------------------------
// $ gulp nproxy
// ----------------------------------------------------------------------------
// This will serve static local files intead of remote ones
// use: `localhost:8989` as proxy parameter

// see `conf/nproxy.js` for proxy configuration

gulp.task('nproxy', function nproxyTask() {

	// use `--port=8080` to change the port number
	var port = argv.port || 8989,
      options = {
        timeout: argv.timeout || 100,
        // use `--debug` to activate debuging
        debug  : argv.debug || false
      };

  options.responderListFilePath = require('../conf/nproxy.js')(argv);

  return nproxy(port, options);

});