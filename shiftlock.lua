local uis = game:GetService("UserInputService")
local activationkey = Enum.KeyCode.LeftShift
local img = script.Parent.ImageLabel
local activated = false
local function pressed(inp)
  if inp.KeyCode == activationkey then
    if activated then
      uis.MouseIconEnabled = false
      uis.MouseBehavior = Enum.MouseBehavior.LockCenter
      img.Visible = true
    else
      img.Visible = false
      uis.MouseIconEnabled = true
      uis.MouseBehavior = Enum.MouseBehavior.Default
    end
  end
end
uis.InputBegan:Connect(pressed)
