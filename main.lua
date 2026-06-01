-- qa0e System v1.3 - Modern Glass UI
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ==================== FIXED KEY ====================
local correctKey = "4819"

print("qa0e System | Key: " .. correctKey)

-- Click Sound
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://535716488"
clickSound.Volume = 0.6
clickSound.Parent = SoundService

local function playClick()
    clickSound:Play()
end

-- ==================== GUI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "qa0eSystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Key System
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 350, 0, 220)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
keyFrame.BackgroundTransparency = 0.2
keyFrame.Parent = screenGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 18)

-- Key UI Elements...
local keyTitle = Instance.new("TextLabel")
keyTitle.Text = "qa0e System"
keyTitle.Size = UDim2.new(1,0,0,50)
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.PlaceholderText = "Enter 4-digit key"
keyInput.Size = UDim2.new(0.8,0,0,45)
keyInput.Position = UDim2.new(0.1,0,0.38,0)
keyInput.BackgroundColor3 = Color3.fromRGB(30,30,45)
keyInput.TextColor3 = Color3.new(1,1,1)
keyInput.TextScaled = true
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0,12)

local unlockBtn = Instance.new("TextButton")
unlockBtn.Text = "Unlock"
unlockBtn.Size = UDim2.new(0.5,0,0,40)
unlockBtn.Position = UDim2.new(0.25,0,0.7,0)
unlockBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
unlockBtn.TextColor3 = Color3.new(1,1,1)
unlockBtn.TextScaled = true
unlockBtn.Parent = keyFrame
Instance.new("UICorner", unlockBtn).CornerRadius = UDim.new(0,12)

unlockBtn.MouseButton1Click:Connect(function()
    playClick()
    if keyInput.Text == correctKey then
        keyFrame:Destroy()
        createMainUI()
    else
        keyInput.Text = "Invalid Key"
        task.wait(1.5)
        keyInput.Text = ""
    end
end)

-- ==================== MAIN UI ====================
function createMainUI()
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 720, 0, 480)
    mainFrame.Position = UDim2.new(0.5, -360, 0.5, -240)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
    mainFrame.BackgroundTransparency = 0.25
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

    -- Top Bar (like in your screenshot)
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 60)
    topBar.BackgroundColor3 = Color3.fromRGB(10, 140, 80) -- Green like your image
    topBar.Parent = mainFrame
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 16)

    -- Player Profile
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 45, 0, 45)
    avatar.Position = UDim2.new(0, 15, 0.5, -22.5)
    avatar.BackgroundTransparency = 1
    avatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    avatar.Parent = topBar

    local username = Instance.new("TextLabel")
    username.Text = "@" .. player.Name
    username.Size = UDim2.new(0.4, 0, 1, 0)
    username.Position = UDim2.new(0, 70, 0, 0)
    username.BackgroundTransparency = 1
    username.TextColor3 = Color3.new(1,1,1)
    username.TextScaled = true
    username.Font = Enum.Font.GothamSemibold
    username.TextXAlignment = Enum.TextXAlignment.Left
    username.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "qa0e System"
    titleLabel.Size = UDim2.new(0.35,0,1,0)
    titleLabel.Position = UDim2.new(0.5,0,0,0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.Parent = topBar

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "✕"
    closeBtn.Size = UDim2.new(0,40,0,40)
    closeBtn.Position = UDim2.new(1,-50,0.5,-20)
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
    closeBtn.TextScaled = true
    closeBtn.Parent = topBar
    closeBtn.MouseButton1Click:Connect(function() playClick() screenGui:Destroy() end)

    -- Example Buttons (expand as needed)
    local function createButton(text, pos, color, parent)
        local btn = Instance.new("TextButton")
        btn.Text = text
        btn.Size = UDim2.new(0.42, 0, 0, 55)
        btn.Position = pos
        btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 70)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamSemibold
        btn.Parent = parent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
        btn.MouseButton1Click:Connect(playClick)
        return btn
    end

    -- Combat Tab Example
    local aimbotBtn = createButton("Aimbot: OFF", UDim2.new(0.05,0,0.2,0), Color3.fromRGB(200,60,60), mainFrame)
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Text = "Speed: 16"
    speedLabel.Position = UDim2.new(0.05,0,0.35,0)
    speedLabel.Size = UDim2.new(0.4,0,0,40)
    speedLabel.BackgroundTransparency = 1
    speedLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
    speedLabel.TextScaled = true
    speedLabel.Parent = mainFrame

    -- Custom Speed
    local speedValue = 16
    local speedSlider = Instance.new("TextBox") -- Simple version, you can replace with real slider
    speedSlider.Text = "Set Speed"
    speedSlider.Position = UDim2.new(0.5,0,0.35,0)
    speedSlider.Size = UDim2.new(0.4,0,0,40)
    speedSlider.Parent = mainFrame
    speedSlider.FocusLost:Connect(function()
        playClick()
        speedValue = tonumber(speedSlider.Text) or 16
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speedValue
        end
        speedLabel.Text = "Speed: " .. speedValue
    end)

    -- Visuals
    local espBtn = createButton("ESP Highlight: OFF", UDim2.new(0.55,0,0.2,0), Color3.fromRGB(200,60,60), mainFrame)

    local saveBtn = createButton("Save Current Settings", UDim2.new(0.05,0,0.55,0), Color3.fromRGB(60, 160, 255), mainFrame)
    local loadBtn = createButton("Load Saved Settings", UDim2.new(0.55,0,0.55,0), Color3.fromRGB(255, 200, 60), mainFrame)

    -- Teleport Behind
    local tpBtn = createButton("Teleport Behind Nearest", UDim2.new(0.05,0,0.7,0), Color3.fromRGB(80, 140, 255), mainFrame)
    tpBtn.MouseButton1Click:Connect(function()
        -- teleport logic (same as before)
        local closest, minDist = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if dist < minDist then minDist = dist closest = plr end
            end
        end
        if closest then
            local root = closest.Character.HumanoidRootPart
            player.Character.HumanoidRootPart.CFrame = CFrame.new(root.Position - root.CFrame.LookVector * 6)
        end
    end)

    -- Hotkeys
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.Insert then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    print("qa0e System loaded successfully!")
end
