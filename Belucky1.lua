local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Rebirth Mania Script 🎁",
   LoadingTitle = "Itay Hub",
   LoadingSubtitle = "by Itay",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

local MainTab = Window:CreateTab("🎁Home", nil)

Rayfield:Notify({
   Title = "Script Loaded",
   Content = "GL 🔥",
   Duration = 5,
})

----------------------------------------------------
-- 🔥 AUTO FARM BOSS
----------------------------------------------------

local AutoFarm = false

MainTab:CreateToggle({
   Name = "Auto Farm Boss 🧠",
   CurrentValue = false,
   Callback = function(Value)
      AutoFarm = Value
      
      if AutoFarm then
         task.spawn(function()
            while AutoFarm do
               local player = game.Players.LocalPlayer
               local character = player.Character or player.CharacterAdded:Wait()
               local root = character:WaitForChild("HumanoidRootPart")
               local humanoid = character:WaitForChild("Humanoid")
               local userId = player.UserId

               local modelsFolder = workspace:WaitForChild("RunningModels")
               local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")

               -- טלפורט התחלה
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
               until ownedModel ~= nil or not AutoFarm

               if not AutoFarm then break end

               -- שולח לבוס
               if ownedModel.PrimaryPart then
                  ownedModel:SetPrimaryPartCFrame(target.CFrame)
               end

               task.wait(0.7)

               -- דחיפה פנימה
               if ownedModel and ownedModel.Parent == modelsFolder then
                  ownedModel:SetPrimaryPartCFrame(target.CFrame * CFrame.new(0, -5, 0))
               end

               -- מחכה שיסתיים
               repeat
                  task.wait(0.3)
               until not AutoFarm or (ownedModel == nil or ownedModel.Parent ~= modelsFolder)

               if not AutoFarm then break end

               -- ריספון
               local oldCharacter = player.Character
               repeat task.wait(0.2)
               until not AutoFarm or (player.Character ~= oldCharacter)

               if not AutoFarm then break end

               task.wait(0.5)
            end
         end)
      end
   end,
})

----------------------------------------------------
-- 💰 AUTO PLACE + SELL (5 דקות)
----------------------------------------------------

local AutoManage = false

MainTab:CreateToggle({
   Name = "Auto Place + Sell 💰",
   CurrentValue = false,
   Callback = function(Value)
      AutoManage = Value

      if AutoManage then
         task.spawn(function()
            while AutoManage do

               -- ⏱ כל 5 דקות
               task.wait(300)

               if not AutoManage then break end

               -- 🔥 שם הכי טובים
               pcall(function()
                  game:GetService("ReplicatedStorage")
                  :WaitForChild("Packages")
                  :WaitForChild("_Index")
                  :WaitForChild("sleitnick_knit@1.7.0")
                  :WaitForChild("knit")
                  :WaitForChild("Services")
                  :WaitForChild("ContainerService")
                  :WaitForChild("RF")
                  :WaitForChild("PlaceBest")
                  :InvokeServer()
               end)

               -- ⏱ 5 שניות אחרי
               task.wait(5)

               -- 💰 מוכר הכל
               pcall(function()
                  game:GetService("ReplicatedStorage")
                  :WaitForChild("Packages")
                  :WaitForChild("_Index")
                  :WaitForChild("sleitnick_knit@1.7.0")
                  :WaitForChild("knit")
                  :WaitForChild("Services")
                  :WaitForChild("InventoryService")
                  :WaitForChild("RF")
                  :WaitForChild("SellAllBrainrots")
                  :InvokeServer()
               end)

            end
         end)
      end
   end,
})
