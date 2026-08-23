-- All-in-One GUI + Fly + Noclip + Speed Controller
-- by Aira X for Delta Mobile

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ===== STATE =====
local flyMode = false
local noclipMode = false
local speedMultiplier = 2.0
local flySpeed = 50
local baseSpeed = 16

-- ===== BODY VELOCITY =====
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.Name = "FlyVelocity"
bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
bodyVelocity.Velocity = Vector3.new(0, 0, 0)
bodyVelocity.Parent = rootPart

-- ===== FUNGSI TOGGLE =====
local function toggleFly()
    flyMode = not flyMode
    if flyMode then
        humanoid.PlatformStand = true
        humanoid.AutoRotate = false
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        print("[Fly] ON")
    else
        humanoid.PlatformStand = false
        humanoid.AutoRotate = true
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        print("[Fly] OFF")
    end
end

local function toggleNoclip()
    noclipMode = not noclipMode
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noclipMode
        end
    end
    print("[Noclip] " .. (noclipMode and "ON" or "OFF"))
end

local function updateSpeed(value)
    speedMultiplier = math.clamp(value, 0.5, 4.0)
    humanoid.WalkSpeed = baseSpeed * speedMultiplier
    print("[Speed] " .. tostring(humanoid.WalkSpeed))
end

-- ===== BUAT UI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaGUI"
screenGui.Parent = player.PlayerGui

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 300) -- diperbesar dikit biar muat credit
mainFrame.Position = UDim2.new(0, 20, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Drag
local dragging = false
local dragStartPos, startMousePos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStartPos = mainFrame.Position
        startMousePos = input.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if dragging then
        local delta = Vector2.new(mouse.X - startMousePos.X, mouse.Y - startMousePos.Y)
        mainFrame.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
    end
end)

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316041018"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ZIndex = 0
shadow.Parent = mainFrame

-- Judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "✧ DELTA ✧"
title.TextColor3 = Color3.fromRGB(255, 200, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Tombol Fly
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 80, 0, 50)
flyBtn.Position = UDim2.new(0.5, -90, 0, 40)
flyBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 80)
flyBtn.BorderSizePixel = 0
flyBtn.Text = "🪽 FLY"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextScaled = true
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = mainFrame

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 12)
flyCorner.Parent = flyBtn

-- Tombol Noclip
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0, 80, 0, 50)
noclipBtn.Position = UDim2.new(0.5, 10, 0, 40)
noclipBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
noclipBtn.BorderSizePixel = 0
noclipBtn.Text = "🌀 NOCLIP"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextScaled = true
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Parent = mainFrame

local noclipCorner = Instance.new("UICorner")
noclipCorner.CornerRadius = UDim.new(0, 12)
noclipCorner.Parent = noclipBtn

-- Label Speed
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 25)
speedLabel.Position = UDim2.new(0, 0, 0, 100)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "🏃 SPEED"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Parent = mainFrame

-- Slider
local speedSlider = Instance.new("Frame")
speedSlider.Size = UDim2.new(0.8, 0, 0, 8)
speedSlider.Position = UDim2.new(0.1, 0, 0, 130)
speedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
speedSlider.BorderSizePixel = 0
speedSlider.Parent = mainFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 4)
sliderCorner.Parent = speedSlider

local fillBar = Instance.new("Frame")
fillBar.Size = UDim2.new(0.5, 0, 1, 0)
fillBar.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
fillBar.BorderSizePixel = 0
fillBar.Parent = speedSlider

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 4)
fillCorner.Parent = fillBar

-- Thumb
local thumb = Instance.new("TextButton")
thumb.Size = UDim2.new(0, 30, 0, 30)
thumb.Position = UDim2.new(0.5, -15, 0.5, -15)
thumb.BackgroundColor3 = Color3.fromRGB(220, 180, 255)
thumb.BorderSizePixel = 0
thumb.Text = ""
thumb.ZIndex = 2
thumb.Parent = speedSlider

local thumbCorner = Instance.new("UICorner")
thumbCorner.CornerRadius = UDim.new(1, 0)
thumbCorner.Parent = thumb

-- Status
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0, 25)
statusText.Position = UDim2.new(0, 0, 0, 155)
statusText.BackgroundTransparency = 1
statusText.Text = "Speed: 2.0"
statusText.TextColor3 = Color3.fromRGB(150, 150, 200)
statusText.TextScaled = true
statusText.Font = Enum.Font.Gotham
statusText.Parent = mainFrame

-- ===== CREDIT =====
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 0, 185)
credit.BackgroundTransparency = 1
credit.Text = "Created by Rey(AldX)"
credit.TextColor3 = Color3.fromRGB(120, 120, 180)
credit.TextScaled = true
credit.Font = Enum.Font.Gotham
credit.TextXAlignment = Enum.TextXAlignment.Center
credit.Parent = mainFrame

-- ===== SLIDER LOGIC =====
local sliderDragging = false
local function updateSlider(value)
    local clamped = math.clamp(value, 0, 1)
    fillBar.Size = UDim2.new(clamped, 0, 1, 0)
    thumb.Position = UDim2.new(clamped, -15, 0.5, -15)
    local speedValue = 0.5 + (clamped * 3.5)
    statusText.Text = "Speed: " .. string.format("%.1f", speedValue)
    updateSpeed(speedValue)
end

thumb.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = true
    end
end)

thumb.InputEnded:Connect(function()
    sliderDragging = false
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if sliderDragging then
        local framePos = speedSlider.AbsolutePosition
        local frameSize = speedSlider.AbsoluteSize
        local relativeX = (mouse.X - framePos.X) / frameSize.X
        local clamped = math.clamp(relativeX, 0, 1)
        fillBar.Size = UDim2.new(clamped, 0, 1, 0)
        thumb.Position = UDim2.new(clamped, -15, 0.5, -15)
        local speedValue = 0.5 + (clamped * 3.5)
        statusText.Text = "Speed: " .. string.format("%.1f", speedValue)
        updateSpeed(speedValue)
    end
end)

-- Tombol click
flyBtn.MouseButton1Click:Connect(toggleFly)
noclipBtn.MouseButton1Click:Connect(toggleNoclip)

-- ===== FLY MOVEMENT =====
local userInput = game:GetService("UserInputService")
game:GetService("RunService").Heartbeat:Connect(function()
    if not flyMode then
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        return
    end
    if not character or not character.Parent then return end

    local moveDirection = Vector3.new()
    if userInput:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Vector3.new(0, 0, -1) end
    if userInput:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection + Vector3.new(0, 0, 1) end
    if userInput:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection + Vector3.new(-1, 0, 0) end
    if userInput:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Vector3.new(1, 0, 0) end
    if userInput:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
    if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection + Vector3.new(0, -1, 0) end

    local speed = flySpeed + (speedMultiplier * 10)
    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit * speed
        local camera = workspace.CurrentCamera
        local camCFrame = camera.CFrame
        local forward = camCFrame.LookVector * moveDirection.Z
        local right = camCFrame.RightVector * moveDirection.X
        local up = camCFrame.UpVector * moveDirection.Y
        bodyVelocity.Velocity = forward + right + up
    else
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- ===== RESET KARAKTER =====
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    rootPart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    bodyVelocity.Parent = rootPart

    if flyMode then
        humanoid.PlatformStand = true
        humanoid.AutoRotate = false
    else
        humanoid.PlatformStand = false
        humanoid.AutoRotate = true
    end

    if noclipMode then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    humanoid.WalkSpeed = baseSpeed * speedMultiplier
end)

-- Inisialisasi awal
updateSpeed(2.0)
print("✅ Delta GUI loaded! Tekan F untuk Fly, G untuk Noclip.")
print("📝 Created by Rey(AldX)")
