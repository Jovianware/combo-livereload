// Generated by CoffeeScript 1.7.1
cg.plugin({
  init: function() {
    var socket;
    cg.gfx.BaseTexture.prototype.reload = function() {
      var source;
      source = new Image;
      this.hasLoaded = false;
      source.onload = (function(_this) {
        return function() {
          _this.source = source;
          cg.gfx.texturesToUpdate.push(_this);
          cg.gfx.__combo__texturesToUpdate.push(_this);
          return _this.dispatchEvent({
            type: 'loaded',
            content: _this
          });
        };
      })(this);
      return source.src = this.imageUrl + '?t=' + Date.now();
    };
    socket = io.connect();
    return socket.on('reloadImage', function(path) {
      var _ref, _ref1;
      cg.log('reloading image ' + path);
      return (_ref = cg.AssetManager._textureCache[path]) != null ? (_ref1 = _ref.baseTexture) != null ? _ref1.reload() : void 0 : void 0;
    });
  }
});
