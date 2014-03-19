# A class that takes an object (or an object prototype),
# finds all methods and creates a new mock object with the same methods
# as the provided object.
#
# This is limited in the sense that no method will return any values.
# If a mock return is necessary one will have to override the
# appropriate method and make it call registerMethodCall. See the example
# below.
#
# Also note that the lookup of methods is not recursive, only methods
# directly attached to the provided objectPrototype will be mocked.
#
# Example on how to extend and to use this class;
# ```
# class MockIrcClient extends Mock
#   constructor: () ->
#       super(irc.Client::)
#
#       connect: () ->
#           this.registerMethodCall('get', arguments)
#           true
#
# var mock = new MockIrcClient();
# # Pass the mock instance instead of the real instance
# mock.say 'abc'               # Returns nothing, only registers
# mock.connect();              # Calls the MockIrcClient.connect above.
# # In the tests, one can now access the list of method calls
# mock.getMethodCalls 'say'    # [['abc']]
# mock.reset()                 # Removes all registered calls
# mock.getMethodCalls('say');  # []
# ```
class Mock
    # A reference to this
    self = []

    # Map of method calls
    methodCalls = {}

    # Helper function for creating a basic mock function
    # that when called only registers the call
    createMockFunction = (methodName) ->
        return () ->
            self.registerMethodCall(methodName, arguments)
            return

    # Creates the mock by (shallow) finding all methods attatched
    # to the `prototypeObject` and extends itself with a mock
    # method for each such method found.
    constructor: (prototypeObject) ->
        self = this
        for own attrName, attrValue of prototypeObject
            # Have to check against already registered functions on this,
            # as a subclass might want to provide a more specific mock
            # implementation of one or many methods
            if typeof attrValue is 'function' and typeof this[attrName] isnt 'function'
                this[attrName] = createMockFunction(attrName)

    # Registers a call to a method `methodName`. The `args` parameter
    # should be the magic `arguments` object passed to the method
    registerMethodCall: (methodName, args) ->
        argsArray = Array::slice.call args
        if methodName not in methodCalls
            methodCalls[methodName] = []
        methodCalls[methodName].push argsArray
        return

    # Returns an array of all calls made to the method `methodName`
    getMethodCalls: (methodName) ->
        if typeof methodCalls[methodName] is 'undefined'
            []
        else
            methodCalls[methodName]

    # Resets the list of recorded methodCalls. Returns this for
    # easier chaining
    reset: ->
        methodCalls = {}
        return this

module.exports = Mock
