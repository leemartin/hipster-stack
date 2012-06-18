express = require 'express'
stylus  = require 'stylus'
nib     = require 'nib'
config  = require('konphyg')(__dirname + '/../config')
jade_helpers = require './jade_helpers'


### CONFIGURE THE EXPRESS APP ###
setup = (app, basedir, cb) ->
  app.configure ->
    app.set 'port', process.env.PORT || config('app').port
    app.set 'views', "#{basedir}/views"
    app.set 'view engine', 'jade'
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    
    #add in some jade helpers
    app.helpers jade_helpers
    
    #setup stylus as middleware
    app.use stylus.middleware    
      src: "#{basedir}/public"
      compile: (str, path) ->
        stylus(str).set('filename', path).set('compress', true).use(nib())
  
    
    app.use express.static "#{basedir}/public"

  app.configure 'development', ->
    app.use express.errorHandler(dumpExceptions: true, showStack: true)
    cb() if cb?

  app.configure 'production', ->
    app.use express.errorHandler()
    cb() if cb?
    

#Export to global space
module.exports = setup