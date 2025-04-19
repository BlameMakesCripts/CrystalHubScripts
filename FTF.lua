-- Crystal Hub: Flee the Facility Script

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- UI
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/raindropxhub/kinx/main/source.lua"))()
local win = lib:Window("Crystal Hub | FTF", Color3.fromRGB(85,170,255), Enum.KeyCode.RightControl)

-- Main
local main = win:Tab("Main")
main:Toggle("Auto Hack Computers", false, function(state)
    _G.AutoHack = state
    while _G.AutoHack and task.wait(0.1) do
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") and obj.Name == "HackPrompt" then
                fireproximityprompt(obj)
            end
        end
    end
end)

main:Button("Teleport to Exit", function()
    for _, exit in ipairs(Workspace:GetDescendants()) do
        if exit.Name:lower():find("exit") and exit:IsA("Part") then
            LocalPlayer.Character:PivotTo(exit.CFrame + Vector3.new(0, 5, 0))
            break
        end
    end
end)

-- ESP
local espTab = win:Tab("ESP")

local function createHighlight(obj, color)
    local hl = Instance.new("Highlight")
    hl.Adornee = obj
    hl.FillColor = color
    hl.FillTransparency = 0.5
    hl.OutlineColor = Color3.new(1, 1, 1)
    hl.OutlineTransparency = 0
    hl.Parent = obj
end

espTab:Toggle("Show Computers", false, function(state)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v.Name == "ComputerTable" and v:IsA("Model") then
            if state then
                createHighlight(v, Color3.fromRGB(0, 170, 255))
            else
                if v:FindFirstChildOfClass("Highlight") then
                    v:FindFirstChildOfClass("Highlight"):Destroy()
                end
            end
        end
    end
end)

espTab:Toggle("Show Beasts", false, function(state)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("BeastPowers") then
                if state then
                    createHighlight(char, Color3.fromRGB(255, 0, 0))
                else
                    if char:FindFirstChildOfClass("Highlight") then
                        char:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                end
            end
        end
    end
end)

-- Misc
local misc = win:Tab("Misc")
misc:Slider("WalkSpeed", 16, 100, 16, function(v)
    LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

misc:Slider("JumpPower", 50, 150, 50, function(v)
    LocalPlayer.Character.Humanoid.JumpPower = v
end)

-- UI Settings
local settings = win:Tab("Settings")
settings:Colorpicker("UI Color", Color3.fromRGB(85, 170, 255), function(c)
    lib:ChangeColor(c)
end)

settings:Button("Destroy UI", function()
    lib:Destroy()
end)
