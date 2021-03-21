local light = game:GetService("Lighting")
local rus = game:GetService("RunService")
local day = 1440
local interval = 1
while true do
  lastsec = tick()
  while true do
    rus.Heartbeat:Wait()
    if tick()-lastsec >= interval then
      break
    end
  end
  light:SetMinutesAfterMidnight((light:GetMinutesAfterMidnight()+interval)%day)
end
