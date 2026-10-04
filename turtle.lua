-- Functions
local function cRefuel(count,slot,fuelCount)
  local prevSlot = turtle.getSelectedSlot()
  turtle.select(slot)
  if turtle.getFuelLevel() < fuelCount + 1
    turtle.refuel(count)
  end
  turtle.select(prevSlot)
end
-- Main Loop
while true do
    cRefuel(1,15,80)
end

-- Install Info:
-- install https://raw.githubusercontent.com/TheInsaneCoderOG/CC-tweaked-scripts/main/turtle.lua turtle.lua
