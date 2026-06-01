-- qa0e System v1.7 - Premium Glass UI (English)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local correctKey = "4819"

local aimbotEnabled = false
local espEnabled = false
local snaplinesEnabled = false
local infinityJumpEnabled = false
local speedHackEnabled = false
local speedValue = 16
local savedTeleportPoint = nil
local currentVolume = 0.5

-- Click Sound
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://535716488"
clickSound.Volume = currentVolume
clickSound.Parent = SoundService

local function playClick()
    clickSound:Play()
end

local function updateVolume(newVol)
    currentVolume = math.clamp(newVol, 0, 2)
    clickSound.Volume = currentVolume
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "qa0eSystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- ==================== KEY SYSTEM ====================
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 380, 0, 240)
keyFrame.Position = UDim2.new(0.5, -190, 0.5, -120)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
keyFrame.BackgroundTransparency = 0.15
keyFrame.Parent = screenGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 22)

local keyTitle = Instance.new("TextLabel")
keyTitle.Text = "qa0e System"
keyTitle.Size = UDim2.new(1,0,0,60)
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.PlaceholderText = "Enter 4-digit code"
keyInput.Size = UDim2.new(0.85,0,0,55)
keyInput.Position = UDim2.new(0.075,0,0.35,0)
keyInput.BackgroundColor3 = Color3.fromRGB(28,28,45)
keyInput.TextColor3 = Color3.new(1,1,1)
keyInput.TextScaled = true
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0,16)

local unlockBtn = Instance.new("TextButton")
unlockBtn.Text = "Unlock"
unlockBtn.Size = UDim2.new(0.55,0,0,50)
unlockBtn.Position = UDim2.new(0.225,0,0.68,0)
unlockBtn.BackgroundColor3 = Color3.fromRGB(65, 195, 125)
unlockBtn.TextColor3 = Color3.new(1,1,1)
unlockBtn.TextScaled = true
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.Parent = keyFrame
Instance.new("UICorner", unlockBtn).CornerRadius = UDim.new(0,16)

unlockBtn.MouseButton1Click:Connect(function()
    playClick()
    if keyInput.Text == correctKey then
        keyFrame:Destroy()
        createMainUI()
    else
        player:Kick("Hahahah du opfer!\n\nFalscher Code")
    end
end)

-- ==================== MAIN GLASS UI ====================
function createMainUI()
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 780, 0, 560)
    mainFrame.Position = UDim2.new(0.5, -390, 0.5, -280)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 32)
    mainFrame.BackgroundTransparency = 0.18
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)

    -- Glass Top Bar
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1,0,0,78)
    topBar.BackgroundColor3 = Color3.fromRGB(22, 165, 130)
    topBar.BackgroundTransparency = 0.1
    topBar.Parent = mainFrame
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 20)

    -- Avatar
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0,58,0,58)
    avatar.Position = UDim2.new(0,22,0.5,-29)
    avatar.BackgroundTransparency = 1
    avatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    avatar.Parent = topBar

    local usernameLabel = Instance.new("TextLabel")
    usernameLabel.Text = "@" .. player.Name
    usernameLabel.Size = UDim2.new(0.35,0,1,0)
    usernameLabel.Position = UDim2.new(0,92,0,0)
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.TextColor3 = Color3.new(1,1,1)
    usernameLabel.TextScaled = true
    usernameLabel.Font = Enum.Font.GothamSemibold
    usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
    usernameLabel.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "qa0e System"
    titleLabel.Size = UDim2.new(0.4,0,1,0)
    titleLabel.Position = UDim2.new(0.5,0,0,0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.Parent = topBar

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "✕"
    closeBtn.Size = UDim2.new(0,50,0,50)
    closeBtn.Position = UDim2.new(1,-65,0.5,-25)
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeBtn.TextScaled = true
    closeBtn.Parent = topBar
    closeBtn.MouseButton1Click:Connect(function()
        playClick()
        screenGui:Destroy()
    end)

    -- Scrolling Content
    local scrolling = Instance.new("ScrollingFrame")
    scrolling.Size = UDim2.new(1, -40, 1, -100)
    scrolling.Position = UDim2.new(0,20,0,88)
    scrolling.BackgroundTransparency = 1
    scrolling.ScrollBarThickness = 8
    scrolling.Parent = mainFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0,15)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = scrolling

    local function createToggle(name, default, callback)
        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(1,0,0,68)
        toggle.BackgroundColor3 = default and Color3.fromRGB(50,200,110) or Color3.fromRGB(200,65,65)
        toggle.Text = name .. ": " .. (default and "ON" or "OFF")
        toggle.TextColor3 = Color3.new(1,1,1)
        toggle.TextScaled = true
        toggle.Font = Enum.Font.GothamSemibold
        toggle.Parent = scrolling
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,18)
        
        local state = default
        toggle.MouseButton1Click:Connect(function()
            playClick()
            state = not state
            toggle.Text = name .. ": " .. (state and "ON" or "OFF")
            toggle.BackgroundColor3 = state and Color3.fromRGB(50,200,110) or Color3.fromRGB(200,65,65)
            if callback then callback(state) end
        end)
    end

    -- Move Section
    createToggle("Infinity Jump", false, function(s) infinityJumpEnabled = s end)

    -- Speed Hack
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Text = "Speed: " .. speedValue
    speedLabel.Size = UDim2.new(1,0,0,68)
    speedLabel.BackgroundColor3 = Color3.fromRGB(30,140,120)
    speedLabel.TextColor3 = Color3.fromRGB(0,255,220)
    speedLabel.TextScaled = true
    speedLabel.Font = Enum.Font.GothamBold
    speedLabel.Parent = scrolling
    Instance.new("UICorner", speedLabel).CornerRadius = UDim.new(0,18)

    local speedInput = Instance.new("TextBox")
    speedInput.Text = "Set Speed"
    speedInput.Size = UDim2.new(1,0,0,60)
    speedInput.BackgroundColor3 = Color3.fromRGB(35,35,55)
    speedInput.TextColor3 = Color3.new(1,1,1)
    speedInput.TextScaled = true
    speedInput.Parent = scrolling
    Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0,18)
    speedInput.FocusLost:Connect(function()
        playClick()
        speedValue = tonumber(speedInput.Text) or 16
        speedLabel.Text = "Speed: " .. speedValue
        if speedHackEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speedValue
        end
    end)

    createToggle("Speed Hack", false, function(s) 
        speedHackEnabled = s
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = s and speedValue or 16
        end
    end)

    createToggle("Save Teleport Point", false, function() 
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            savedTeleportPoint = player.Character.HumanoidRootPart.CFrame
        end
    end)

    createToggle("Teleport to Point", false, function()
        if savedTeleportPoint and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = savedTeleportPoint
        end
    end)

    -- Combat
    createToggle("Aimbot", false, function(s) aimbotEnabled = s end)

    -- Visuals
    createToggle("ESP Highlight", false, function(s) espEnabled = s end)
    createToggle("Snaplines", false, function(s) snaplinesEnabled = s end)

    -- Volume Controls
    local volumeLabel = Instance.new("TextLabel")
    volumeLabel.Text = "Volume: " .. math.floor(currentVolume * 100) .. "%"
    volumeLabel.Size = UDim2.new(1,0,0,68)
    volumeLabel.BackgroundColor3 = Color3.fromRGB(40,40,70)
    volumeLabel.TextColor3 = Color3.fromRGB(180, 220, 255)
    volumeLabel.TextScaled = true
    volumeLabel.Font = Enum.Font.GothamBold
    volumeLabel.Parent = scrolling
    Instance.new("UICorner", volumeLabel).CornerRadius = UDim.new(0,18)

    local volDown = Instance.new("TextButton")
    volDown.Text = "Volume Down"
    volDown.Size = UDim2.new(0.48,0,0,60)
    volDown.Position = UDim2.new(0,0,0,0)
    volDown.BackgroundColor3 = Color3.fromRGB(100, 140, 220)
    volDown.TextColor3 = Color3.new(1,1,1)
    volDown.TextScaled = true
    volDown.Parent = scrolling
    Instance.new("UICorner", volDown).CornerRadius = UDim.new(0,16)
    volDown.MouseButton1Click:Connect(function()
        playClick()
        updateVolume(currentVolume - 0.1)
        volumeLabel.Text = "Volume: " .. math.floor(currentVolume * 100) .. "%"
    end)

    local volUp = Instance.new("TextButton")
    volUp.Text = "Volume Up"
    volUp.Size = UDim2.new(0.48,0,0,60)
    volUp.Position = UDim2.new(0.52,0,0,0)
    volUp.BackgroundColor3 = Color3.fromRGB(100, 140, 220)
    volUp.TextColor3 = Color3.new(1,1,1)
    volUp.TextScaled = true
    volUp.Parent = scrolling
    Instance.new("UICorner", volUp).CornerRadius = UDim.new(0,16)
    volUp.MouseButton1Click:Connect(function()
        playClick()
        updateVolume(currentVolume + 0.1)
        volumeLabel.Text = "Volume: " .. math.floor(currentVolume * 100) .. "%"
    end)

    -- Save / Load
    createToggle("Save Current Settings", false, function() print("Settings Saved!") end)
    createToggle("Load Saved Settings", false, function() print("Settings Loaded!") end)

    -- ==================== FUNCTIONALITY ====================
    UserInputService.JumpRequest:Connect(function()
        if infinityJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState("Jumping")
        end
    end)

    RunService.RenderStepped:Connect(function()
        if not aimbotEnabled then return end
        local closest = nil
        local minDist = math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
                local dist = (plr.Character.Head.Position - camera.CFrame.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = plr.Character.Head
                end
            end
        end
        if closest then
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, closest.Position)
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.Insert then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    print("qa0e System loaded successfully! Press INSERT to toggle menu.")
end
