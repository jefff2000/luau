local int = 3
local obj = workspace:WaitForChild("CameraPart")
local round, clamp = math.round, math.clamp
local cam = workspace.CurrentCamera
local rus = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local plrs = game:GetService("Players")
local lplr = plrs.LocalPlayer
local gui = lplr:WaitForChild("PlayerGui")
local screen = Instance.new("ScreenGui")
screen.Name = "Screen Size Measure"
screen.IgnoreGuiInset = true
local frame = Instance.new("Frame")
frame.BackgroundTransparency = 1
frame.ZIndex = -9
frame.Size = UDim2.new(1,0,1,0)
frame.Parent = screen
screen.Parent = gui
int = math.rad(3)
rus:BindToRenderStep("ChooseCamCursor", Enum.RenderPriority.Input.Value+1, function()
	cam.CameraType = Enum.CameraType.Scriptable
	local mouse = uis:GetMouseLocation()
	local screen = frame.AbsoluteSize
	local middle = Vector2.new(round(screen.X/2), round(screen.Y/2))
	local difference = (mouse-middle)/middle*int
	local x,y,z = cam.CFrame:ToEulerAnglesYXZ()
	local v3 = Vector3.new(clamp(-difference.Y, -int, int), clamp(-difference.X, -int, int), 0)
	cam.CFrame = obj.CFrame*CFrame.Angles(v3.X, v3.Y, v3.Z)
end)
