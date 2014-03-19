Mock = require './mockCS'
Loader = require './../../loader'

# A mock of the Loader class.
class MockLoader extends Mock
    _data = {}
    _allowSet = true

    # Creates a MockLoader with the initial data `data`.
    # If the `allowSet` parameter is `false`, calls to .set
    # will not be allowed to modify the data.
    constructor: (data, allowSet = true) ->
        super(Loader::)
        if typeof data is 'object'
            _data = data
        allowSet = !!allowSet

    # get is overriden manually as it requires a return value.
    get: (key) ->
        this.registerMethodCall('get', arguments)
        _data[key]

    # set is overriden manually as it should also call this.save
    set: (key) ->
        this.registerMethodCall('set', arguments)
        if _allowSet
            _data[key] = value
        this.save()
        return

module.exports = MockLoader