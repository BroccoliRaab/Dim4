# Dim4
A small timer and clock centered lua library designed for love2d 1.10.x

# API

```
local dim4 = require("dim4")
local timer = dim4:newTimer(isClock, delay, function, runOnCreation, index)
``` 

This will create a new timer and return it

```isClock``` when true will repeatedly execute ```function``` after a period of ```delay``` seconds. And when false will execute ```function``` only once after ```delay``` seconds.

If ```runOnCreation``` is true then ```function``` will run once ```newTimer``` is called. ```index``` dictates the index of ```timer``` in the table ```dim4.timers```

```runOnCreation``` and ```index``` are both optional unless ```index``` is given an boolean value and the ```runOnCreation``` arguement is completely left blank.

``` 
love.update(dt)
  timer:update(dt)
end
```
This will update and individual timer

``` 
love.update(dt)
  dim4:updateAllTimers(dt)
end
```
This will update every timer

Every timer must be updated by the ```love.update``` function in order to work properly either individually with ```timer:update(dt)``` or ```dim4:updateAllTimers(dt)```.

```timer:stop()``` will stop the timer

```timer:start()``` will start the timer if it has been stopped or ```runOnCreation``` was not true

```timer:reset(startOnReset)``` will restart the timer. If ```startOnReset``` is not true ```timer:start()``` will have to be run in order to start it

```timer:destroy``` will stop the timer and remove it from ```dim4.timers```

Every timer can be accessed using ```dim4.timers[index]``` where index is either what was specified in ```dim4:newTimer(isClock, delay, function, runOnCreation, index)``` or an integer.

Timers have the following properties

* ```timer.index``` the index of the timer in the table ```dim4.timers```

* ```timer.cTime``` the current time on the timer, if the timer is a clock this will reset to 0 after the function is executed

* ```timer.running``` boolean of wether or not the tiemr is currently running

* ```timer.delay``` the delay specified at the timer's creation

* ```timer.funct``` the function the timer will execute after ```delay``` has passed.

# Installation
Place the Dim4.lua file in your project and use require.
```local dim4 = require("dim4")```
