--// =========================
--// UI
--// =========================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Rebirth Mania Script 🎁",
    LoadingTitle = "Itay Hub",
    LoadingSubtitle = "by Itay"
})

local Tab = Window:CreateTab("Main", nil)

--// =========================
--// SERVICES
--// =========================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

--// =========================
--// REMOTES
--// =========================
local Knit = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")

local PlaceBest = Knit
    :WaitForChild("Services")
    :WaitForChild("ContainerService")
    :WaitForChild("RF")
    :WaitForChild("PlaceBest")

local SellAll = Knit
    :WaitForChild("Services")
    :WaitForChild("InventoryService")
    :WaitForChild("RF")
    :WaitForChild("SellAllBrainrots")

--// =========================
--// STATES
--// =========================
local autoFarm = false
local autoLoop = false

--// =========================
--// AUTO PLACE + SELL
--// =========================
local function AutoPlaceSell()
    while autoLoop do
        pcall(function()
            PlaceBest:InvokeServer()
        end)

        task.wait(5)

        pcall(function()
            SellAll:InvokeServer()
        end)

        task.wait(300) -- 5 דקות
    end
end

--// =========================
--// GET PLAYER MODEL
--// =========================
local function GetMyModel()
    local folder = workspace:WaitForChild("RunningModels")

    for _, obj in ipairs(folder:GetChildren()) do
        if obj:IsA("Model") and obj:GetAttribute("OwnerId") == player.UserId then
            return obj
        end
    end

    return nil
end

--// =========================
--// AUTO FARM
--// =========================
local function AutoFarm()
    while autoFarm do
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")

        local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")

        -- התחלה
        root.CFrame = CFrame.new(715, 39, -2122)
        task.wait(0.5)

        humanoid:MoveTo(Vector3.new(710, 39, -2122))

        -- חיפוש מודל (עם timeout)
        local myModel = nil
        for i = 1, 20 do
            if not autoFarm then return end
            myModel = GetMyModel()
            if myModel then break end
            task.wait(0.3)
        end

        if not myModel then continue end

        -- טלפורט לסוף
        local part = myModel.PrimaryPart or myModel:FindFirstChildWhichIsA("BasePart")
        if part then
            part.CFrame = target.CFrame
        end

        task.wait(1)

        -- דחיפה למטה
        if myModel.Parent then
            part = myModel.PrimaryPart or myModel:FindFirstChildWhichIsA("BasePart")
            if part then
                part.CFrame = target.CFrame * CFrame.new(0, -5, 0)
            end
        end

        -- מחכה לסיום (עם הגבלה)
        local timeout = 0
        while autoFarm and myModel.Parent and timeout < 20 do
            task.wait(0.3)
            timeout += 1
        end

        if not autoFarm then return end

        -- 🔥 בריחה מהבוס (חשוב)
        local newChar = player.Character or player.CharacterAdded:Wait()
        local newRoot = newChar:WaitForChild("HumanoidRootPart")

        newRoot.CFrame = CFrame.new(737, 39, -2118)

        task.wait(1) -- אחרי respawn
    end
end

--// =========================
--// TOGGLES
--// =========================
Tab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        autoFarm = Value
        if Value then
            task.spawn(AutoFarm)
        end
    end
})

Tab:CreateToggle({
    Name = "Auto Place + Sell",
    CurrentValue = false,
    Callback = function(Value)
        autoLoop = Value
        if Value then
            task.spawn(AutoPlaceSell)
        end
    end
})

--// =========================
--// NOTIFY
--// =========================
Rayfield:Notify({
    Title = "Script Loaded",
    Content = "Clean & Stable Version ✅",
    Duration = 5
})
