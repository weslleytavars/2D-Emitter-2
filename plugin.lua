local toolbar = plugin:CreateToolbar("2DEmitter")
local button = toolbar:CreateButton(
	"Open",
	"Opens the particle editor prompt",
	"rbxassetid://12214312431") 
local info = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Right,
	false,false,
	350,400,
	150,150
)
local widget = plugin:CreateDockWidgetPluginGui(
	"2D Emitter", 
	info
)
local frame = script._main
frame.Parent = widget
local module = require(script["2DEmitterV2"])
local selection = game:GetService("Selection")
button.Click:Connect(function()
	widget.Enabled = not widget.Enabled
end)

local enabled = false
local selected

selection.SelectionChanged:Connect(function()
	local items = selection:Get()
	for i,item in pairs(items) do
		if item:IsA("Frame") or item:IsA("ImageLabel") or item:IsA("TextButton") or item:IsA("ImageButton") or item:IsA("ScrollingFrame") or item:IsA("TextBox") then
			selected = item
			break
		else
			selected = nil
			continue
		end
	end
	if selected then
		frame.frame_info.Text = ("Selected %s: %s"):format(typeof(selected),selected.Name)
	else
		frame.frame_info.Text = ("Selected Frame: None, select a frame to continue.")
	end
end)

frame.Enable.MouseButton1Click:Connect(function()
	enabled = not enabled
	if not enabled then
		frame.Enable.BackgroundColor3 = Color3.fromRGB(66, 176, 36)
		frame.Enable.Text = "Enable"
	else
		frame.Enable.BackgroundColor3 = Color3.fromRGB(255, 62, 62)
		frame.Enable.Text = "Disable"
	end
end)

local setting 

frame.script.MouseButton1Click:Connect(function()
	if not selected then return end
	local scpt = script._handler:Clone()
	scpt.Parent = selected
	scpt.Disabled = false
	if (setting) then
		scpt.LifeTime.Min.Value = setting.LifeTime.X
		scpt.LifeTime.Max.Value = setting.LifeTime.Y
		
		scpt.Acceleration.X.Value = setting.Acceleration.X
		scpt.Acceleration.Y.Value = setting.Acceleration.Y
		
		scpt.Texture.Value = setting.Texture
		scpt.Size.Value = setting.Size
		scpt.Speed.Value = setting.Speed
		scpt.Rotation.Value = setting.Rotation
		scpt.Amount.Value = setting.Amount
		
		for i,color in pairs(setting.Colors) do
			local val = Instance.new("Color3Value",scpt.Colors)
			val.Value = color
		end
	end
end)

frame.setting.MouseButton1Click:Connect(function()
	if setting then
		
		local s = ""
		for key,value in pairs(setting) do
			s ..= key .. ' = ' .. value
		end
		
		local mo = Instance.new("ModuleScript")
		mo.Name = "Exported_2DEmitter_Settings"
		mo.Parent = game:GetService("ReplicatedStorage")
		mo.Source = ("return {"..s.."}")
		selection:Set({mo})
	end
end)

frame.module.MouseButton1Click:Connect(function()
	local s = script["2DEmitterV2"]:Clone()
	s.Parent = game.ReplicatedStorage
	selection:Set({s})
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if enabled and selected then
		local m = module.new(selected["Position"])
		setting = m:GetSettings()
		frame.particle_icon.Image = setting.Texture
		m:Set({
			Amount = tonumber(frame.ScrollingFrame.Amount.Text),
			Size = tonumber(frame.ScrollingFrame.SizeBox.Text),
			Speed = tonumber(frame.ScrollingFrame.Speed.Text),
			Texture = tonumber(frame.ScrollingFrame.TextureId.Text),
			Acceleration = UDim2.fromOffset(tonumber(frame.ScrollingFrame.acceleration.x.Text),tonumber(frame.ScrollingFrame.acceleration.y.Text)),
			LifeTime = Vector2.new(tonumber(frame.ScrollingFrame.lifetime.min),tonumber(frame.ScrollingFrame.lifetime.max)),
			Rotation = tonumber(frame.ScrollingFrame.RotationBox.Text)
		})
		m:Emit()
	end
end)
