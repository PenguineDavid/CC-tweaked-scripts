-- Install Info:
-- install https://raw.githubusercontent.com/TheInsaneCoderOG/CC-tweaked-scripts/main/turtle.lua turtle.lua

-- Functions
local function cRefuel(count,slot,fuelCount)
	if turtle.getFuelLevel() < fuelCount + 1 then
		local prevSlot = turtle.getSelectedSlot()
		turtle.select(slot)
		turtle.refuel(count)
		turtle.select(prevSlot)
	end
end

-- Main Loop
while true do
	cRefuel(1,15,80)
end
