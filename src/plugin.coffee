cg.gfx.BaseTexture::reload = ->
  source = new Image
  @hasLoaded = false
  source.onload = =>
    @source = source
    cg.gfx.texturesToUpdate.push @
    cg.gfx.__combo__texturesToUpdate.push @
    @dispatchEvent( { type: 'loaded', content: @ } )
  source.src = @imageUrl + '?t=' + Date.now()


setTimeout ->
  socket = io.connect()

  socket.on 'reloadImage', (path) ->
    cg.log 'reloading image ' + path
    cg.AssetManager._textureCache[path]?.baseTexture?.reload()
, 250