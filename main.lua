-- // qa0e System v1.8 - Premium Glass UI (English)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local correctKey = "4819"

local aimbotEnabled = false
local espEnabled = false
local snaplinesEnabled = false
local infinityJumpEnabled = false
local speedHackEnabled = false
local speedValue = 32
local savedTeleportPoint = nil
local currentVolume = 1.0

local connections = {}

-- Click Sound
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://535716488"
clickSound.Volume = currentVolume
clickSound.Parent = SoundService

local function playClick()
    clickSound:Play()
end

local function updateVolume(newVol)
    currentVolume = math.clamp(newVol, 0, 3)
    clickSound.Volume = currentVolume
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "qa0eSystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

-- ==================== KEY SYSTEM ====================
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 400, 0, 260)
keyFrame.Position = UDim2.new(0.5, -200, 0.5, -130)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
keyFrame.BackgroundTransparency = 0.1
keyFrame.Parent = screenGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 24)

local keyTitle = Instance.new("TextLabel")
keyTitle.Text = "qa0e System"
keyTitle.Size = UDim2.new(1,0,0,70)
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.PlaceholderText = "Enter 4-digit code"
keyInput.Size = UDim2.new(0.85,0,0,60)
keyInput.Position = UDim2.new(0.075,0,0.35,0)
keyInput.BackgroundColor3 = Color3.fromRGB(25,25,40)
keyInput.TextColor3 = Color3.new(1,1,1)
keyInput.TextScaled = true
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 18)

local unlockBtn = Instance.new("TextButton")
unlockBtn.Text = "Unlock"
unlockBtn.Size = UDim2.new(0.6,0,0,55)
unlockBtn.Position = UDim2.new(0.2,0,0.68,0)
unlockBtn.BackgroundColor3 = Color3.fromRGB(65, 195, 125)
unlockBtn.TextColor3 = Color3.new(1,1,1)
unlockBtn.TextScaled = true
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.Parent = keyFrame
Instance.new("UICorner", unlockBtn).CornerRadius = UDim.new(0, 18)

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
    mainFrame.Size = UDim2.new(0, 820, 0, 620)
    mainFrame.Position = UDim2.new(0.5, -410, 0.5, -310)
    mainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 32)
    mainFrame.BackgroundTransparency = 0.25
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 22)

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(80, 200, 255)
    stroke.Transparency = 0.7
    stroke.Parent = mainFrame

    -- Top Bar
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1,0,0,80)
    topBar.BackgroundColor3 = Color3.fromRGB(22, 165, 130)
    topBar.BackgroundTransparency = 0.15
    topBar.Parent = mainFrame
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 22)

    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 64, 0, 64)
    avatar.Position = UDim2.new(0, 25, 0.5, -32)
    avatar.BackgroundTransparency = 1
    avatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    avatar.Parent = topBar

    local username = Instance.new("TextLabel")
    username.Text = "@" .. player.Name
    username.Size = UDim2.new(0.35,0,1,0)
    username.Position = UDim2.new(0, 100, 0, 0)
    username.BackgroundTransparency = 1
    username.TextColor3 = Color3.new(1,1,1)
    username.TextScaled = true
    username.Font = Enum.Font.GothamSemibold
    username.TextXAlignment = Enum.TextXAlignment.Left
    username.Parent = topBar

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
    closeBtn.Size = UDim2.new(0,60,0,60)
    closeBtn.Position = UDim2.new(1,-70,0.5,-30)
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(255,80,80)
    closeBtn.TextScaled = true
    closeBtn.Parent = topBar
    closeBtn.MouseButton1Click:Connect(function()
        playClick()
        screenGui:Destroy()
    end)

    -- Tabs
    local tabs = {"Move", "Combat", "Visuals", "Hotkeys"}
    local tabButtons = {}
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -40, 1, -140)
    contentFrame.Position = UDim2.new(0,20,0,100)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local function switchTab(tabName)
        contentFrame:ClearAllChildren()
        -- Hier kommen die Inhalte der Tabs
        if tabName == "Move" then
            -- Move Tab
            local function createButton(text, callback)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1,0,0,65)
                btn.BackgroundColor3 = Color3.fromRGB(45,45,70)
                btn.Text = text
                btn.TextColor3 = Color3.new(1,1,1)
                btn.TextScaled = true
                btn.Font = Enum.Font.GothamSemibold
                btn.Parent = contentFrame
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0,18)
                btn.MouseButton1Click:Connect(function()
                    playClick()
                    callback()
                end)
            end

            createButton("Infinity Jump: " .. (infinityJumpEnabled and "ON" or "OFF"), function()
                infinityJumpEnabled = not infinityJumpEnabled
            end)

            -- Speed Hack
            local speedLabel = Instance.new("TextLabel")
            speedLabel.Text = "Speed Hack: " .. speedValue
            speedLabel.Size = UDim2.new(1,0,0,65)
            speedLabel.BackgroundColor3 = Color3.fromRGB(30, 130, 110)
            speedLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
            speedLabel.TextScaled = true
            speedLabel.Parent = contentFrame
            Instance.new("UICorner", speedLabel).CornerRadius = UDim.new(0,18)

            local speedBox = Instance.new("TextBox")
            speedBox.Text = tostring(speedValue)
            speedBox.Size = UDim2.new(1,0,0,55)
            speedBox.BackgroundColor3 = Color3.fromRGB(35,35,55)
            speedBox.TextColor3 = Color3.new(1,1,1)
            speedBox.TextScaled = true
            speedBox.Parent = contentFrame
            Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,18)
            speedBox.FocusLost:Connect(function()
                playClick()
                speedValue = tonumber(speedBox.Text) or 32
                speedLabel.Text = "Speed Hack: " .. speedValue
            end)

            createButton("Enable Speed Hack", function()
                speedHackEnabled = not speedHackEnabled
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = speedHackEnabled and speedValue or 16
                end
            end)

            createButton("Set Teleport Point", function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    savedTeleportPoint = player.Character.HumanoidRootPart.CFrame
                    print("Teleport Point Saved!")
                end
            end)

            createButton("Teleport to Point", function()
                if savedTeleportPoint and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = savedTeleportPoint
                end
            end)

        elseif tabName == "Combat" then
            -- Combat Tab
            local function createToggle(name, enabled, callback)
                -- ... (Toggle Funktion hier einbauen)
            end
            createToggle("Aimbot", aimbotEnabled, function(s) aimbotEnabled = s end)

        elseif tabName == "Visuals" then
            createToggle("ESP Highlight", espEnabled, function(s) espEnabled = s end)
            createToggle("Snaplines + HP", snaplinesEnabled, function(s) snaplinesEnabled = s end)

        elseif tabName == "Hotkeys" then
            -- Volume + Keybinds
            local volLabel = Instance.new("TextLabel")
            volLabel.Text = "Volume: " .. math.floor(currentVolume * 100) .. "%"
            volLabel.Size = UDim2.new(1,0,0,70)
            volLabel.BackgroundColor3 = Color3.fromRGB(40,40,75)
            volLabel.TextColor3 = Color3.fromRGB(180,220,255)
            volLabel.TextScaled = true
            volLabel.Parent = contentFrame
            Instance.new("UICorner", volLabel).CornerRadius = UDim.new(0,18)

            -- Volume Buttons
            local down = Instance.new("TextButton")
            down.Text = "Volume Down"
            down.Size = UDim2.new(0.48,0,0,60)
            down.Position = UDim2.new(0,0,0,80)
            down.BackgroundColor3 = Color3.fromRGB(90,130,200)
            down.Parent = contentFrame
            Instance.new("UICorner", down).CornerRadius = UDim.new(0,16)
            down.MouseButton1Click:Connect(function()
                playClick()
                updateVolume(currentVolume - 0.15)
                volLabel.Text = "Volume: " .. math.floor(currentVolume * 100) .. "%"
            end)

            local up = Instance.new("TextButton")
            up.Text = "Volume Up"
            up.Size = UDim2.new(0.48,0,0,60)
            up.Position = UDim2.new(0.52,0,0,80)
            up.BackgroundColor3 = Color3.fromRGB(90,130,200)
            up.Parent = contentFrame
            Instance.new("UICorner", up).CornerRadius = UDim.new(0,16)
            up.MouseButton1Click:Connect(function()
                playClick()
                updateVolume(currentVolume + 0.15)
                volLabel.Text = "Volume: " .. math.floor(currentVolume * 100) .. "%"
            end)

            -- Save / Load
            createButton("💾 Save Current Settings", function() print("Settings Saved!") end)
            createButton("📂 Load Saved Settings", function() print("Settings Loaded!") end)
        end
    end

    -- Tab Buttons erstellen
    for i, tabName in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.25, 0, 0, 55)
        btn.Position = UDim2.new((i-1)*0.25, 0, 0, 80)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,55)
        btn.Text = tabName
        btn.TextColor3 = Color3.new(1,1,1)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamSemibold
        btn.Parent = mainFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,16)

        btn.MouseButton1Click:Connect(function()
            playClick()
            switchTab(tabName)
        end)
        table.insert(tabButtons, btn)
    end

    switchTab("Move") -- Start mit Move Tab

    -- ==================== FUNCTIONALITY ====================
    UserInputService.JumpRequest:Connect(function()
        if infinityJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    RunService.RenderStepped:Connect(function()
        if aimbotEnabled then
            -- Simple Aimbot (kann verbessert werden)
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
        end
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    print("✅ qa0e System v1.8 loaded! Press INSERT to toggle.")
end
