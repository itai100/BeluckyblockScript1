local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Rebirth Mania Script 🎁",
   LoadingTitle = "Itay Hub",
   LoadingSubtitle = "by Itay",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local MainTab = Window:CreateTab("🎁Home", nil)

Rayfield:Notify({
   Title = "Script Loaded",
   Content = "GL 🔥",
   Duration = 5,
})

----------------------------------------------------
-- 🔥 AUTO FARM BOSS (מתוקן)
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
               local userId = player.UserId

               local modelsFolder = workspace:WaitForChild("RunningModels")
               local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")

               -- טלפורט התחלה
               root.CFrame = CFrame.new(715, 39, -2122)
               task.wait(0.5)

               local ownedModel = nil
               local startTime = tick()

               -- חיפוש מודל (עם הגנה מלהיתקע)
               repeat
                  for _, obj in ipairs(modelsFolder:GetChildren()) do
                     if obj:IsA("Model") and obj:GetAttribute("OwnerId") == userId then
                        ownedModel = obj
                        break
                     end
                  end
                  task.wait(0.2)
               until ownedModel or tick() - startTime > 5 or not AutoFarm

               if not AutoFarm then break end
               if not ownedModel then continue end

               -- שולח לבוס
               if ownedModel.PrimaryPart then
                  ownedModel:SetPrimaryPartCFrame(target.CFrame)
               end

               task.wait(0.5)

               -- דחיפה פנימה
               if ownedModel.Parent == modelsFolder then
                  ownedModel:SetPrimaryPartCFrame(target.CFrame * CFrame.new(0, -5, 0))
               end

               -- מחכה שייעלם (עם timeout)
               local startTime2 = tick()
               repeat
                  task.wait(0.2)
               until not AutoFarm or ownedModel.Parent ~= modelsFolder or tick() - startTime2 > 5

               task.wait(0.5)
            end
         end)
      end
   end,
})

----------------------------------------------------
-- 💰 AUTO PLACE + SELL
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

               -- 🔥 פעם ראשונה מיד
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

               task.wait(5)

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

               -- ⏱ כל 5 דקות
               for i = 1, 300 do
                  if not AutoManage then break end
                  task.wait(1)
               end

            end
         end)
      end
   end,
})
