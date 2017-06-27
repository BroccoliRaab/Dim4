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