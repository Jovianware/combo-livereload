fs = require 'fs'

io = undefined
server = undefined

# Combine middleware into one:
# Adapted from https://gist.github.com/nemtsov/6148720
combine = (middlewares) -> (req, res, next) ->
  iter = (i) ->
    middlware = middlewares[i]
    return next()  unless middlware
    middlware req, res, (err) ->
      return next(err)  if err
      iter i + 1
      return
    return
  iter(0)
  return

serve_livereload_file = (req, res, next) ->
  if req.url.indexOf('/combo-livereload.js') isnt 0
    return next()
  else
    fs.readFile __dirname + '/combo-livereload.js', (err, data) ->
      if err
        res.writeHead 500, err
        return res.end err
      res.end data

inject_scripts = require('connect-inject') {
  snippet: """
    <script type='application/javascript' src='/socket.io/socket.io.js'></script>
    <script type='application/javascript' src='/combo-livereload.js'></script>
  """
}

livereload = module.exports = combine [serve_livereload_file, inject_scripts]

livereload.listen = (_server) ->
  server = _server
  io = require('socket.io').listen server, log: false

livereload.reloadImage = (path) -> io.sockets.emit 'reloadImage', path