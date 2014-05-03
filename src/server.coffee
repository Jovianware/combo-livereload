# Connect Middleware
fs = require 'fs'

io = undefined
server = undefined

module.exports =
  connect: (_server) ->
    server = _server
    io = require('socket.io').listen server, log: false

  reloadImage: (path) -> io.sockets.emit 'reloadImage', path

  middleware: require('connect-inject') {
    snippet: """
      <script type='application/javascript' src='/socket.io/socket.io.js'></script>
      <script type='application/javascript' src='/combo-livereload.js'></script>
    """
  }

  'combo-livereload.js': (req, res) ->
    fs.readFile __dirname + '/plugin.js', (err, data) ->
      if err
        res.writeHead 500, err
        return res.end err
      res.end data