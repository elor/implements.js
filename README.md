# Implements.js

Implements.js is a JavaScript library which aims to provide Java-inspired interface and implementation validation in Javascript.

An interface is defined as a JS object with a certain structure. See Examples.

## Installation

Just copy implements.js into your JavaScript project.

## The Implements Object

    /**
    * shorthand for validate() and match(), depending on the number of
    * arguments.
    *
    * Implements() / new Implements() -> create new empty interface object
    * 
    * Implements(interface) -> Implements.validate(interface)
    * 
    * Implements(intf, implementation) -> Implements.match(intf, implementation)
    * 
    * Implements(intf, impl, opts) -> Implements.match(intf, impl, opts)
    */
    Implements = function(){
    };

    /**
    * validate an interface
    *
    * @param interface the interface to validate
    * @returns a string of errors. '' on success
    */
    Implements.validate(interface)

    /**
    * match an implementation of an interface
    * 
    * @param interface the interface to match against
    * @param implementation the supposed implementation of the interface
    * @param options a string of options (optional)
    * @returns a string of errors. '' on success
    */
    Implements.match(interface, implementation, options)

Match Options:

The option string is any combination of up to four characters from the list below.
Examples: "irfm", "rf", "", ...

* 'i': run an interface validation
* 'r': recursively match all subinterfaces
* 'f': forbid additional functions
* 'm': forbid additional members

    /**
    * create an interface object that combines all arguments using .Extends
    * 
    * @param intfX any number of interfaces
    * @returns a new interface with all interfaces inside the Extends array
    */
    Implements.combine(intf1, intf2, ...)

    /**
    * an interface of Implements for self-matching. Recursive self-matching is
    * known to fail on this interface, which is wanted behaviour at this point
    */
    Implements.selfInterface;

## Interface Objects

An interface is an object which consists at least of the following:

    {
      Interface: {}
    }

The actual match of an implementation is against the Interface subobject, not the whole object. This is likely to change in the future.

An interface usually contains a few functions, which will be name-checked when matching against an implementation.
In addition, an interface can contain any number of subinterfaces, numbers, strings, regexps, dates, booleans and arrays of any of them, including nested arrays. 

    {
      Interface: {
        a: function(){},
        b: 2,
        c: [3, /4/, "5"]
      }
    }

Your wrapper object can contain global functions and constants:

    {
      Interface: {},
      globalFunction: function(){},
      CONSTANT: "global constant"
      CONSTANTARRAY: [1, 2, 3, 4, 5],
      CONSTANTOBJECT: {
        STARTED: 0,
        RUNNING: 1,
        FINISHED: 2
      }
    }

In case you want to automatically validate other interfaces which are required by the global function, you can use the Requires array:

    {
      Interface:{},
      Requires: {requiredInterface}
    }

You can extend one or more interfaces using the Extends property:

    {
      Interface:{
        newFunction: function(){}
      },
      Extends: [anotherInterface]
    }

## Examples

Large Interface Example:

    {
      Interface: {
        myNumber: 1,
        myFunction(){
        },
        mySubInterface: {
          Interface:{}
        },
        myArray: [1, "2"] // elements must be of either type
      },
      Extends: [],
      Requires: [],
      myGlobalFunction: function(){
      },
      MYGLOBALCONSTANT: 5,
      MYGLOBALCONSTANTS: {
        A: true,
        B: 2,
        C: /3/,
        D: '4',
        E: new Date(5)
      }
    }

Interface validation:

    errors = Implements.validate(myInterface);
    if (errors !== '') {
      console.log('myInterface doesn't validate. Errors:');
      console.log(errors);
    }

    // Implements() with one argument defaults to Implements.validate()
    var errors = Implements(myInterface);
    if (errors !== '') {
      console.log('myInterface doesn't validate. Errors:');
      console.log(errors);
    }


