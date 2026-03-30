-- UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Rebirth Mania Script 🎁",
   LoadingTitle = "Itay Hub",
   LoadingSubtitle = "by Itay",
})

local Tab = Window:CreateTab("Main", nil)
local Section = Tab:CreateSection("Auto Systems")

-- SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- STATES
local autoFarm = false
local autoPlaceSell = false

-- FUNCTIONS
local function PlaceBest()
    ReplicatedStorage
        :WaitForChild("Packages")
        :WaitForChild("_Index")
        :WaitForChild("sleitnick_knit@1.7.0")
        :WaitForChild("knit")
        :WaitForChild("Services")
        :WaitForChild("ContainerService")
        :WaitForChild("RF")
        :WaitForChild("PlaceBest")
        :InvokeServer()
end

local function SellAll()
    ReplicatedStorage
        :WaitForChild("Packages")
        :WaitForChild("_Index")
        :WaitForChild("sleitnick_knit@1.7.0")
        :WaitForChild("knit")
        :WaitForChild("Services")
        :WaitForChild("InventoryService")
        :WaitForChild("RF")
        :WaitForChild("SellAllBrainrots")
        :InvokeServer()
end

-- AUTO PLACE + SELL LOOP
task.spawn(function()
    while true do
        task.wait(300) -- 5 דקות

        if autoPlaceSell then
            PlaceBest()
            print("Placed Best")

            task.wait(5)

            SellAll()
            print("Sold All")
        end
    end
end)

-- AUTO FARM LOOP
task.spawn(function()
    while true do
        if autoFarm then
            local character = player.Character or player.CharacterAdded:Wait()
            local root = character:WaitForChild("HumanoidRootPart")
            local humanoid = character:WaitForChild("Humanoid")

            local userId = player.UserId
            local modelsFolder = workspace:WaitForChild("RunningModels")
            local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")

            -- התחלה
            root.CFrame = CFrame.new(715, 39, -2122)
            task.wait(0.3)

            humanoid:MoveTo(Vector3.new(710, 39, -2122))

            local ownedModel = nil

            repeat
                task.wait(0.3)
                for _, obj in ipairs(modelsFolder:GetChildren()) do
                    if obj:IsA("Model") and obj:GetAttribute("OwnerId") == userId then
                        ownedModel = obj
                        break
                    end
                end
            until ownedModel ~= nil or not autoFarm

            if not autoFarm then continue end

            -- שיגור לבוס
            if ownedModel then
                if ownedModel.PrimaryPart then
                    ownedModel:SetPrimaryPartCFrame(target.CFrame)
                else
                    local part = ownedModel:FindFirstChildWhichIsA("BasePart")
                    if part then
                        part.CFrame = target.CFrame
                    end
                end
            end

            task.wait(0.7)

            -- דחיפה למטה
            if ownedModel and ownedModel.PrimaryPart then
                ownedModel:SetPrimaryPartCFrame(target.CFrame * CFrame.new(0, -5, 0))
            end

            -- מחכה לסיום
            repeat
                task.wait(0.3)
            until not autoFarm or ownedModel == nil or ownedModel.Parent ~= modelsFolder

            if not autoFarm then continue end

            -- ריספאון
            local oldCharacter = player.Character
            repeat
                task.wait(0.2)
            until not autoFarm or (player.Character ~= oldCharacter and player.Character ~= nil)

            if not autoFarm then continue end

            -- ⬅️ חשוב
            task.wait(1)

            local newChar = player.Character
            local newRoot = newChar:WaitForChild("HumanoidRootPart")

            newRoot.CFrame = CFrame.new(737, 39, -2118)

            task.wait(2)
        else
            task.wait(1)
        end
    end
end)

-- UI TOGGLES
Tab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Callback = function(Value)
      autoFarm = Value
   end,
})

Tab:CreateToggle({
   Name = "Auto Place + Sell",
   CurrentValue = false,
   Callback = function(Value)
      autoPlaceSell = Value
   end,
})

-- NOTIFY
Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Everything Ready ✅",
   Duration = 5,
})
