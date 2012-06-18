# Require Node Packages
express = require 'express'
config  = require('konphyg')('#{__dirname}/config')
app_setup = require './lib/setup'

##/*-------------------------------------------------------------*/
#/* ----- Make express server -------	*/
app = module.exports = express.createServer()


#/* ----- Express setup -------	*/
app_setup app, __dirname, ->
  
##/*-------------------------------------------------------------*/



#/* ----- Routes -------	*/
app.get '/', (req, res) ->
  res.render 'index'




#/* ----- Listen to port -------	*/
app.listen app.settings.port