local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Rebirth Mania Script 🎁",
   LoadingTitle = "Itay Hub",
   LoadingSubtitle = "by Itay",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Rebirth Mania | key 🔑 ",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = true,
      Key = {"https://pastebin.com/raw/WXng6d0M"}
   }
})

local MainTab = Window:CreateTab("🎁Home", nil)
local MainSection = MainTab:CreateSection("Teleport")    

Rayfield:Notify({
   Title = "You executed the script",
   Content = "GL",
   Duration = 5,
})

----------------------------------------------------
-- 🔥 AUTO FARM BOSS 18
----------------------------------------------------

local AutoFarm = false

MainTab:CreateToggle({
   Name = "Auto Farm Boss 18 🧠",
   CurrentValue = false,
   Flag = "AutoFarmBoss18",
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
               else
                  local part = ownedModel:FindFirstChildWhichIsA("BasePart")
                  if part then
                     part.CFrame = target.CFrame
                  end
               end

               task.wait(0.7)

               -- דחיפה פנימה
               if ownedModel and ownedModel.Parent == modelsFolder then
                  if ownedModel.PrimaryPart then
                     ownedModel:SetPrimaryPartCFrame(target.CFrame * CFrame.new(0, -5, 0))
                  else
                     local part = ownedModel:FindFirstChildWhichIsA("BasePart")
                     if part then
                        part.CFrame = target.CFrame * CFrame.new(0, -5, 0)
                     end
                  end
               end

               -- מחכה שיסתיים
               repeat
                  task.wait(0.3)
               until not AutoFarm or (ownedModel == nil or ownedModel.Parent ~= modelsFolder)

               if not AutoFarm then break end

               -- ריספון
               local oldCharacter = player.Character
               repeat
                  task.wait(0.2)
               until not AutoFarm or (player.Character ~= oldCharacter and player.Character ~= nil)

               if not AutoFarm then break end

               task.wait(0.4)

               local newChar = player.Character
               local newRoot = newChar:WaitForChild("HumanoidRootPart")

               newRoot.CFrame = CFrame.new(737, 39, -2118)
               task.wait(2)
            end
         end)
      end
   end,
})
