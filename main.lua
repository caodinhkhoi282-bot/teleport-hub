local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    game.CoreGui:FindFirstChild("TeleportGUI"):Destroy()
end)

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TeleportGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 260, 0, 190)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Frame.Active = true
Frame.Draggable = true

local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(0,170,255)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,30)
Title.Text = "Teleport Player"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.TextScaled = true

local Dropdown = Instance.new("TextButton", Frame)
Dropdown.Size = UDim2.new(0.8,0,0,30)
Dropdown.Position = UDim2.new(0.1,0,0.3,0)
Dropdown.Text = "Chọn người chơi"
Dropdown.BackgroundColor3 = Color3.fromRGB(20,20,20)
Dropdown.TextColor3 = Color3.fromRGB(255,255,255)

local SelectedPlayer = nil

local ListFrame = Instance.new("Frame", Frame)
ListFrame.Size = UDim2.new(0.8,0,0,80)
ListFrame.Position = UDim2.new(0.1,0,0.5,0)
ListFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
ListFrame.Visible = false

local Layout = Instance.new("UIListLayout", ListFrame)

Dropdown.MouseButton1Click:Connect(function()
    ListFrame.Visible = not ListFrame.Visible

    for _,v in pairs(ListFrame:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end

    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local Btn = Instance.new("TextButton", ListFrame)
            Btn.Size = UDim2.new(1,0,0,25)
            Btn.Text = plr.Name
            Btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Btn.TextColor3 = Color3.fromRGB(255,255,255)

            Btn.MouseButton1Click:Connect(function()
                SelectedPlayer = plr
                Dropdown.Text = plr.Name
                ListFrame.Visible = false
            end)
        end
    end
end)

local TeleportBtn = Instance.new("TextButton", Frame)
TeleportBtn.Size = UDim2.new(0.8,0,0,35)
TeleportBtn.Position = UDim2.new(0.1,0,0.8,0)
TeleportBtn.Text = "Teleport"
TeleportBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)

TeleportBtn.MouseButton1Click:Connect(function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame =
            SelectedPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(3,0,0)
    end
end)
