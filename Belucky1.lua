-- UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Rebirth Mania Script 🎁",
   LoadingTitle = "Itay Hub",
   LoadingSubtitle = "by Itay",
   ConfigurationSaving = {
      Enabled = false
   }
})

local Tab = Window:CreateTab("Main", nil)
local Section = Tab:CreateSection("Farming")

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- REMOTES
local PlaceBest = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("ContainerService")
    :WaitForChild("RF")
    :WaitForChild("PlaceBest")

local SellAll = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("InventoryService")
    :WaitForChild("RF")
    :WaitForChild("SellAllBrainrots")

-- STATES
local autoFarm = false
local autoLoop = false

--------------------------------------------------
-- AUTO PLACE + SELL (כל 5 דקות)
--------------------------------------------------
local function StartAutoLoop()
    autoLoop = true
    task.spawn(function()
        while autoLoop do
            pcall(function()
                PlaceBest:InvokeServer()
            end)

            print("Placed Best")

            task.wait(5)

            pcall(function()
                SellAll:InvokeServer()
            end)

            print("Sold All")

            task.wait(300) -- 5 דקות
        end
    end)
end

--------------------------------------------------
-- AUTO FARM
--------------------------------------------------
local function StartAutoFarm()
    autoFarm = true
    task.spawn(function()
        while autoFarm do
            local character = player.Character or player.CharacterAdded:Wait()
            local root = character:WaitForChild("HumanoidRootPart")
            local humanoid = character:WaitForChild("Humanoid")

            local modelsFolder = workspace:WaitForChild("RunningModels")
            local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")

            -- התחלה
            root.CFrame = CFrame.new(715, 39, -2122)
            task.wait(0.5)

            humanoid:MoveTo(Vector3.new(710, 39, -2122))

            -- מוצא מודל
            local myModel = nil
            repeat
                task.wait(0.3)
                for _, obj in ipairs(modelsFolder:GetChildren()) do
                    if obj:IsA("Model") and obj:GetAttribute("OwnerId") == player.UserId then
                        myModel = obj
                        break
                    end
                end
            until myModel or not autoFarm

            if not autoFarm then break end

            -- טלפורט לסוף
            if myModel then
                local part = myModel.PrimaryPart or myModel:FindFirstChildWhichIsA("BasePart")
                if part then
                    part.CFrame = target.CFrame
                end
            end

            task.wait(1)

            -- דחיפה למטה
            if myModel and myModel.Parent == modelsFolder then
                local part = myModel.PrimaryPart or myModel:FindFirstChildWhichIsA("BasePart")
                if part then
                    part.CFrame = target.CFrame * CFrame.new(0, -5, 0)
                end
            end

            -- מחכה לסיום
            repeat
                task.wait(0.3)
            until not autoFarm or (myModel == nil or myModel.Parent ~= modelsFolder)

            if not autoFarm then break end

            -- מחכה לrespawn
            local oldChar = character
            repeat
                task.wait(0.2)
            until not autoFarm or (player.Character ~= oldChar and player.Character ~= nil)

            if not autoFarm then break end

            task.wait(1) -- 🔥 חשוב
        end
    end)
end

--------------------------------------------------
-- TOGGLES
--------------------------------------------------

Tab:CreateToggle({
   Name = "Auto Farm Best",
   CurrentValue = false,
   Callback = function(Value)
      autoFarm = Value
      if Value then
         StartAutoFarm()
      end
   end,
})

Tab:CreateToggle({
   Name = "Auto Place + Sell (5 min)",
   CurrentValue = false,
   Callback = function(Value)
      autoLoop = Value
      if Value then
         StartAutoLoop()
      end
   end,
})

--------------------------------------------------
-- NOTIFY
--------------------------------------------------
Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Everything Ready 🔥",
   Duration = 5
})
