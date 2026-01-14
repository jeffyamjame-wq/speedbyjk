local uis = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local isRunning = false -- ตัวแปรเช็คว่าวิ่งอยู่หรือเปล่า

-- ฟังก์ชันทำงานเมื่อกดปุ่ม
uis.InputBegan:Connect(function(input, gameProcessed)
	-- ถ้าเราพิมพ์แชทอยู่ ไม่ต้องทำอะไร (กันมันวิ่งเองตอนพิมพ์)
	if gameProcessed then return end

	-- เช็คว่าเป็นปุ่ม Ctrl ฝั่งซ้ายไหม
	if input.KeyCode == Enum.KeyCode.LeftControl then
		
		-- หาตัวละครของผู้เล่น
		local character = player.Character
		local humanoid = character and character:FindFirstChild("Humanoid")

		-- ถ้ามีตัวละครอยู่
		if humanoid then
			if not isRunning then
				-- ถ้ายังไม่วิ่ง -> ปรับให้วิ่งไว (แก้เลข 100 ได้ถ้าไวไป)
				humanoid.WalkSpeed = 100 
				isRunning = true
			else
				-- ถ้าวิ่งอยู่แล้ว -> ปรับให้เดินปกติ (ปกติคือ 16)
				humanoid.WalkSpeed = 16 
				isRunning = false
			end
		end
	end
end)
