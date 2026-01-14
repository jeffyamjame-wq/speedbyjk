local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- ตั้งค่าความเร็ว
local normalSpeed = 16
local runSpeed = 100

-- 1. สร้างตัว GUI หลัก
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedSystemGUI"
screenGui.ResetOnSpawn = false -- ตายแล้วเมนูไม่หาย
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 2. สร้างปุ่มเมนูเล็กๆ (Open Button) ไว้มุมซ้าย
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 120, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.5, -25) -- ตำแหน่งกลางซ้ายของจอ
openBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- สีฟ้า
openBtn.Text = "เมนูวิ่งไว"
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.TextSize = 20
openBtn.Font = Enum.Font.GothamBold
openBtn.Parent = screenGui

-- ทำมุมโค้งสวยๆ ให้ปุ่ม
local corner1 = Instance.new("UICorner")
corner1.CornerRadius = UDim.new(0, 10)
corner1.Parent = openBtn

-- 3. สร้างหน้าต่างเมนูหลัก (Main Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100) -- กลางจอเป๊ะ
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- สีดำเทา
mainFrame.Visible = false -- ซ่อนไว้ก่อน
mainFrame.Parent = screenGui

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 15)
corner2.Parent = mainFrame

-- 4. ปุ่มปิดหน้าต่าง (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(1, 0) -- วงกลม
corner3.Parent = closeBtn

-- 5. ปุ่มสวิตช์วิ่งไว (Toggle Speed)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.8, 0, 0, 60)
toggleBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- เริ่มต้นสีเทา
toggleBtn.Text = "Speed: OFF"
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.TextSize = 24
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = mainFrame

local corner4 = Instance.new("UICorner")
corner4.CornerRadius = UDim.new(0, 10)
corner4.Parent = toggleBtn

-- --- ส่วนของโค้ดการทำงาน (Logic) ---

local isRunning = false

-- ฟังก์ชันเปิด/ปิด เมนู
openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- ฟังก์ชันกดปุ่มวิ่ง
toggleBtn.MouseButton1Click:Connect(function()
	local character = player.Character
	local humanoid = character and character:FindFirstChild("Humanoid")

	if humanoid then
		isRunning = not isRunning -- สลับสถานะ

		if isRunning then
			-- เปิดโหมดวิ่ง
			humanoid.WalkSpeed = runSpeed
			toggleBtn.Text = "Speed: ON !!!"
			toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- เปลี่ยนเป็นสีเขียว
		else
			-- ปิดโหมดวิ่ง
			humanoid.WalkSpeed = normalSpeed
			toggleBtn.Text = "Speed: OFF"
			toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- กลับเป็นสีเทา
		end
	end
end)

-- กันตายแล้วความเร็วหาย (Reset speed on respawn)
player.CharacterAdded:Connect(function(char)
	local hum = char:WaitForChild("Humanoid")
	if isRunning then
		hum.WalkSpeed = runSpeed
	end
end)
