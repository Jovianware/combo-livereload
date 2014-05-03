# combo-livereload

Automatic hot-swapping of assets during combo game development.

## Usage

Made mostly to integrate with [`generator-combo`](http://github.com/Jovianware/generator-combo).

```coffee
connect = require 'connect'

livereload = require 'combo-livereload'

app = connect()
  .use livereload
  .use connect.static './src'

server = require('http').createServer(app).listen(3000)
livereload.listen server # Sets up a socket.io context; REQUIRED.
```

```coffee
gulp.watch ['src/assets/*.png', 'src/assets/*.jpg'], {}, (event) ->
  livereload.reloadImage event.path.replace(__dirname + '/src/', '')
```
