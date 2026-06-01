-- qa0e System v1.4 - Modern Glass UI (English)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ==================== SETTINGS ====================
local correctKey = "4819"
local menuOpen = true

local aimbotEnabled = false
local espEnabled = false
local infinityJumpEnabled = false
local speedHackEnabled = false
local savedTeleportPoint = nil

print("qa0e System | Key: " .. correctKey)

-- Click Sound
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://535716488"
clickSound.Volume = 0.5
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
keyFrame.Size = UDim2.new(0, 360, 0, 220)
keyFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
keyFrame.BackgroundTransparency = 0.15
keyFrame.Parent = screenGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 20)

local kt = Instance.new("TextLabel", keyFrame)
kt.Text = "qa0e System"
kt.Size = UDim2.new(1,0,0,55)
kt.BackgroundTransparency = 1
kt.TextColor3 = Color3.new(1,1,1)
kt.TextScaled = true
kt.Font = Enum.Font.GothamBlack

local ki = Instance.new("TextBox", keyFrame)
ki.PlaceholderText = "Enter 4-digit code"
ki.Size = UDim2.new(0.8,0,0,50)
ki.Position = UDim2.new(0.1,0,0.35,0)
ki.BackgroundColor3 = Color3.fromRGB(35,35,55)
ki.TextColor3 = Color3.new(1,1,1)
ki.TextScaled = true
Instance.new("UICorner", ki).CornerRadius = UDim.new(0,14)

local ub = Instance.new("TextButton", keyFrame)
ub.Text = "Unlock"
ub.Size = UDim2.new(0.5,0,0,45)
ub.Position = UDim2.new(0.25,0,0.68,0)
ub.BackgroundColor3 = Color3.fromRGB(65, 190, 110)
ub.TextColor3 = Color3.new(1,1,1)
ub.TextScaled = true
ub.Font = Enum.Font.GothamBold
Instance.new("UICorner", ub).CornerRadius = UDim.new(0,14)

ub.MouseButton1Click:Connect(function()
    playClick()
    if ki.Text == correctKey then
        keyFrame:Destroy()
        createMainMenu()
    else
        ki.Text = "Invalid Code!"
        task.wait(1.4)
        ki.Text = ""
    end
end)

-- ==================== MAIN MENU ====================
function createMainMenu()
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 740, 0, 520)
    mainFrame.Position = UDim2.new(0.5, -370, 0.5, -260)
    mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
    mainFrame.BackgroundTransparency = 0.22
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 18)

    -- Top Bar
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1,0,0,68)
    topBar.BackgroundColor3 = Color3.fromRGB(35, 165, 120)
    topBar.Parent = mainFrame
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 18)

    -- Avatar
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0,52,0,52)
    avatar.Position = UDim2.new(0,18,0.5,-26)
    avatar.BackgroundTransparency = 1
    avatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    avatar.Parent = topBar

    local usernameLabel = Instance.new("TextLabel")
    usernameLabel.Text = "@" .. player.Name
    usernameLabel.Size = UDim2.new(0.35,0,1,0)
    usernameLabel.Position = UDim2.new(0,80,0,0)
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.TextColor3 = Color3.new(1,1,1)
    usernameLabel.TextScaled = true
    usernameLabel.Font = Enum.Font.GothamSemibold
    usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
    usernameLabel.Parent = topBar

    local title = Instance.new("TextLabel")
    title.Text = "qa0e System"
    title.Size = UDim2.new(0.4,0,1,0)
    title.Position = UDim2.new(0.5,0,0,0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBlack
    title.Parent = topBar

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "✕"
    closeBtn.Size = UDim2.new(0,45,0,45)
    closeBtn.Position = UDim2.new(1,-55,0.5,-22.5)
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeBtn.TextScaled = true
    closeBtn.Parent = topBar
    closeBtn.MouseButton1Click:Connect(function() playClick() screenGui:Destroy() end)

    -- ==================== MENU BUTTONS ====================
    local yOffset = 90

    local function createToggle(text, defaultState, posY, callback)
        local btn = Instance.new("TextButton")
        btn.Text = text .. ": " .. (defaultState and "ON" or "OFF")
        btn.Size = UDim2.new(0.88, 0, 0, 58)
        btn.Position = UDim2.new(0.06, 0, 0, posY)
        btn.BackgroundColor3 = defaultState and Color3.fromRGB(60, 200, 100) or Color3.fromRGB(200, 70, 70)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamSemibold
        btn.Parent = mainFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)

        local state = defaultState
        btn.MouseButton1Click:Connect(function()
            playClick()
            state = not state
            btn.Text = text .. ": " .. (state and "ON" or "OFF")
            btn.BackgroundColor3 = state and Color3.fromRGB(60, 200, 100) or Color3.fromRGB(200, 70, 70)
            if callback then callback(state) end
        end)
        return btn
    end

    -- Speed
    local speedValue = 16
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Text = "Speed: " .. speedValue
    speedLabel.Size = UDim2.new(0.88,0,0,50)
    speedLabel.Position = UDim2.new(0.06,0,0,yOffset)
    speedLabel.BackgroundColor3 = Color3.fromRGB(40,40,65)
    speedLabel.TextColor3 = Color3.fromRGB(0, 255, 220)
    speedLabel.TextScaled = true
    speedLabel.Font = Enum.Font.GothamBold
    speedLabel.Parent = mainFrame
    Instance.new("UICorner", speedLabel).CornerRadius = UDim.new(0,14)

    local speedBox = Instance.new("TextBox")
    speedBox.Text = "Set Speed"
    speedBox.Size = UDim2.new(0.4,0,0,45)
    speedBox.Position = UDim2.new(0.55,0,0,yOffset)
    speedBox.BackgroundColor3 = Color3.fromRGB(35,35,55)
    speedBox.TextColor3 = Color3.new(1,1,1)
    speedBox.Parent = mainFrame
    Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,12)
    speedBox.FocusLost:Connect(function()
        playClick()
        speedValue = tonumber(speedBox.Text) or 16
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speedValue
        end
        speedLabel.Text = "Speed: " .. speedValue
    end)
    yOffset += 70

    -- Toggles
    createToggle("Aimbot", false, yOffset, function(state) aimbotEnabled = state end); yOffset += 70
    createToggle("ESP Highlight", false, yOffset, function(state) espEnabled = state end); yOffset += 70
    createToggle("Infinity Jump", false, yOffset, function(state) infinityJumpEnabled = state end); yOffset += 70
    createToggle("Speed Hack", false, yOffset, function(state) speedHackEnabled = state end); yOffset += 70

    -- Teleport
    local saveTpBtn = Instance.new("TextButton")
    saveTpBtn.Text = "Save Teleport Point"
    saveTpBtn.Size = UDim2.new(0.42,0,0,58)
    saveTpBtn.Position = UDim2.new(0.06,0,0,yOffset)
    saveTpBtn.BackgroundColor3 = Color3.fromRGB(80, 130, 255)
    saveTpBtn.TextColor3 = Color3.new(1,1,1)
    saveTpBtn.TextScaled = true
    saveTpBtn.Parent = mainFrame
    Instance.new("UICorner", saveTpBtn).CornerRadius = UDim.new(0,14)
    saveTpBtn.MouseButton1Click:Connect(function()
        playClick()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            savedTeleportPoint = player.Character.HumanoidRootPart.CFrame
            print("Teleport point saved!")
        end
    end)

    local loadTpBtn = Instance.new("TextButton")
    loadTpBtn.Text = "Teleport to Point"
    loadTpBtn.Size = UDim2.new(0.42,0,0,58)
    loadTpBtn.Position = UDim2.new(0.52,0,0,yOffset)
    loadTpBtn.BackgroundColor3 = Color3.fromRGB(80, 130, 255)
    loadTpBtn.TextColor3 = Color3.new(1,1,1)
    loadTpBtn.TextScaled = true
    loadTpBtn.Parent = mainFrame
    Instance.new("UICorner", loadTpBtn).CornerRadius = UDim.new(0,14)
    loadTpBtn.MouseButton1Click:Connect(function()
        playClick()
        if savedTeleportPoint and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = savedTeleportPoint
        end
    end)

    yOffset += 75

    -- Save / Load Settings
    local saveSettingsBtn = Instance.new("TextButton")
    saveSettingsBtn.Text = "Save Current Settings"
    saveSettingsBtn.Size = UDim2.new(0.42,0,0,55)
    saveSettingsBtn.Position = UDim2.new(0.06,0,0,yOffset)
    saveSettingsBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    saveSettingsBtn.TextColor3 = Color3.new(1,1,1)
    saveSettingsBtn.TextScaled = true
    saveSettingsBtn.Parent = mainFrame
    Instance.new("UICorner", saveSettingsBtn).CornerRadius = UDim.new(0,14)

    local loadSettingsBtn = Instance.new("TextButton")
    loadSettingsBtn.Text = "Load Saved Settings"
    loadSettingsBtn.Size = UDim2.new(0.42,0,0,55)
    loadSettingsBtn.Position = UDim2.new(0.52,0,0,yOffset)
    loadSettingsBtn.BackgroundColor3 = Color3.fromRGB(255, 190, 60)
    loadSettingsBtn.TextColor3 = Color3.new(1,1,1)
    loadSettingsBtn.TextScaled = true
    loadSettingsBtn.Parent = mainFrame
    Instance.new("UICorner", loadSettingsBtn).CornerRadius = UDim.new(0,14)

    -- ==================== FUNCTIONALITY ====================
    -- Infinity Jump
    UserInputService.JumpRequest:Connect(function()
        if infinityJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState("Jumping")
        end
    end)

    -- Aimbot
    RunService.RenderStepped:Connect(function()
        if not aimbotEnabled then return end
        if not player.Character then return end

        local closest = nil
        local shortest = math.huge

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
                local dist = (plr.Character.Head.Position - camera.CFrame.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = plr.Character.Head
                end
            end
        end

        if closest then
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, closest.Position)
        end
    end)

    -- ESP (Basic Highlight)
    -- (You can expand this with Drawing API if needed)

    print("qa0e System loaded successfully!")
    print("Press INSERT to toggle menu")
end
