local light = game:GetService("Lighting")
local rus = game:GetService("RunService")
local day = 1440
local interval = 1
while true do
  wait(interval)
  light:SetMinutesAfterMidnight((light:GetMinutesAfterMidnight()+interval)%day)
end
