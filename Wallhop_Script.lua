-- WALLHOP SCRIPT BY BananaLolz

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local wallHopEnabled = false
local hopForce = 60
local wallCheckDistance = 3

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WallHopGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "WALLHOP-SCRIPT BY BananaLolz"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

local onButton = Instance.new("TextButton")
onButton.Size = UDim2.new(0.45, 0, 0, 40)
onButton.Position = UDim2.new(0.05, 0, 0.5, 0)
onButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
onButton.Text = "ON"
onButton.TextColor3 = Color3.fromRGB(255,255,255)
onButton.Font = Enum.Font.SourceSansBold
onButton.TextSize = 18
onButton.Parent = frame

local offButton = Instance.new("TextButton")
offButton.Size = UDim2.new(0.45, 0, 0, 40)
offButton.Position = UDim2.new(0.5, 0, 0.5, 0)
offButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
offButton.Text = "OFF"
offButton.TextColor3 = Color3.fromRGB(255,255,255)
offButton.Font = Enum.Font.SourceSansBold
offButton.TextSize = 18
offButton.Parent = frame

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
            rootPart.Velocity = rootPart.Velocity + Vector3.new(0, hopForce, 0)
        end
    end
end)
