Mock = require('./mockCS')
Loader = require('./../../loader')

class MockLoader extends Mock
  _data = {}
  _allowSet = true

  constructor: (data, allowSet) ->
    super(Loader::)
    if typeof data is 'object'
      _data = data
    allowSet = !!allowSet

  get: (key) ->
    @.registerMethodCall('get', arguments)
    _data[key]

  set: (key) ->
    @.registerMethodCall('set', arguments)
    if _allowSet
      _data[key] = value
    @.save()
    return


module.exports = MockLoader