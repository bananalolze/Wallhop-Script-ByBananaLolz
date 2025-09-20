-- WALLHOP SCRIPT BY BananaLolz

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local wallHopEnabled = false
local hopForce = 5
local wallCheckDistance = 3

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WallHopGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "WALLHOP-SCRIPT BY BananaLolz"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

local onButton = Instance.new("TextButton")
onButton.Size = UDim2.new(0.4, 0, 0, 40)
onButton.Position = UDim2.new(0.05, 0, 0.25, 0)
onButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
onButton.Text = "ON"
onButton.TextColor3 = Color3.fromRGB(255,255,255)
onButton.Font = Enum.Font.SourceSansBold
onButton.TextSize = 18
onButton.Parent = frame

local offButton = Instance.new("TextButton")
offButton.Size = UDim2.new(0.4, 0, 0, 40)
offButton.Position = UDim2.new(0.55, 0, 0.25, 0)
offButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
offButton.Text = "OFF"
offButton.TextColor3 = Color3.fromRGB(255,255,255)
offButton.Font = Enum.Font.SourceSansBold
offButton.TextSize = 18
offButton.Parent = frame

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(0.9, 0, 0, 20)
sliderLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "WallHop Force: "..hopForce
sliderLabel.TextColor3 = Color3.fromRGB(255,255,255)
sliderLabel.Font = Enum.Font.SourceSans
sliderLabel.TextSize = 16
sliderLabel.Parent = frame

local sliderBar = Instance.new("Frame")
sliderBar.Size = UDim2.new(0.9, 0, 0, 10)
sliderBar.Position = UDim2.new(0.05, 0, 0.75, 0)
sliderBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
sliderBar.BorderSizePixel = 0
sliderBar.Parent = frame

local sliderHandle = Instance.new("Frame")
sliderHandle.Size = UDim2.new(hopForce/10, 0, 1, 0)
sliderHandle.Position = UDim2.new(0, 0, 0, 0)
sliderHandle.BackgroundColor3 = Color3.fromRGB(0, 200, 200)
sliderHandle.BorderSizePixel = 0
sliderHandle.Parent = sliderBar

local dragging = false
sliderHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

sliderHandle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local relativePos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        hopForce = math.floor(relativePos * 10)
        if hopForce < 1 then hopForce = 1 end
        sliderHandle.Size = UDim2.new(hopForce/10, 0, 1, 0)
        sliderLabel.Text = "WallHop Force: "..hopForce
    end
end)

onButton.MouseButton1Click:Connect(function()
    wallHopEnabled = true
end)

offButton.MouseButton1Click:Connect(function()
    wallHopEnabled = false
end)

local function canWallHop()
    local rayOrigin = rootPart.Position
    local rayDirection = rootPart.CFrame.LookVector * wallCheckDistance
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    return result ~= nil
end

RunService.RenderStepped:Connect(function()
    if wallHopEnabled and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        if canWallHop() then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            rootPart.Velocity = rootPart.Velocity + Vector3.new(0, hopForce*10, 0)
        end
    end
end)
