local ugs = UserSettings():GetService("UserGameSettings")
local minquality = 1
local maxquality = 10
local function quality()
  local val = ugs.SavedQualityLevel.Value
  if val == 0 then
    print("Automatic")
    return
  end
  if val < minquality then
    print("Lower than minquality")
  elseif val > maxquality then
    print("Higher than maxquality")
  end
end
ugs:GetPropertyChangedSignal("SavedQualityLevel"):Connect(quality)
