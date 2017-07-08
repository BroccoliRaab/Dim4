-[[
MIT License

Copyright (c) 2017 Robert Herlihy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local dim4 = {}
dim4.timers = {}
function dim4:newTimer(clock, sec, fnct, runOnCreation, index)
	local timer = {}

	timer.delay = sec
	timer.funct = fnct
	
	timer.running = true
	timer.cTime = 0
	timer.isClock = clock
	
	if runOnCreation == true then
		timer.funct()
	end

	if index then
		timer.index = index
		self.timers[index] = timer
	else
		local nxtind = #self.timers + 1
		table.insert(self.timers, nxtind, timer)
		timer.index = nxtind
	end

	function timer:update(dt)
		if not self.running then return end
		self.cTime = self.cTime + dt
		if self.cTime >= self.delay then
			self.funct()
			if self.isClock then
				self.cTime = 0
			end
		end
	end
		
	function timer:stop()
		self.running = false		
	end

	function timer:start()
		self.running = true
	end

	function timer:reset(startOnReset)
		self.cTime = 0
		self.running = startOnReset 
	end

	function timer:destroy()
		table.remove(dim4, self.index)
	end  

	return timer
end

function dim4:updateAllTimers(dt)
	for i, v in pairs(dim4.timers) do
		v:update(dt)
	end
end

return dim4
