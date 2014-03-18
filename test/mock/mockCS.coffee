class Mock
    self = []
    methodCalls = {}

    createMockFunction = (methodName) ->
        return () ->
            self.registerMethodCall(methodName, arguments)
            return

    constructor: (prototypeObject) ->
        self = @
        for own attrName, attrValue of prototypeObject
            if typeof attrValue is 'function' and typeof @[attrName] isnt 'function'
                @[attrName] = createMockFunction(attrName)

    registerMethodCall: (methodName, args) ->
        argsArray = Array::slice.call args
        if methodName not in methodCalls
            methodCalls[methodName] = []
        methodCalls[methodName].push argsArray
        return

    getMethodCalls: (methodName) ->
        if typeof methodCalls[methodName] is 'undefined'
            []
        else
            methodCalls[methodName]

    reset: ->
        methodCalls = {}
        return @

module.exports = Mock
