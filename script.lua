-- โค้ดสำหรับรันผ่าน Executor บนมือถือ (Client-Side) - ระบบกระเด้งเมื่อแตะพื้น (ปรับความสูง 1-120 ได้)
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- ป้องกันสร้างซ้ำซ้อนถ้ากดรันหลายรอบ
if CoreGui:FindFirstChild("BounceScriptUI") then
	CoreGui.BounceScriptUI:Destroy()
end

-- สร้าง ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BounceScriptUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==========================================
-- 1. สร้างโลโก้ลอย (Floating Logo) แบบลากได้
-- ==========================================
local LogoButton = Instance.new("TextButton")
LogoButton.Name = "LogoButton"
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0, 50, 0, 150)
LogoButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LogoButton.Text = "FROY" 
LogoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoButton.TextSize = 14
LogoButton.Font = Enum.Font.GothamBold
LogoButton.Parent = ScreenGui

local UICornerLogo = Instance.new("UICorner")
UICornerLogo.CornerRadius = UDim.new(1, 0)
UICornerLogo.Parent = LogoButton

local UIStrokeLogo = Instance.new("UIStroke")
UIStrokeLogo.Color = Color3.fromRGB(100, 200, 255)
UIStrokeLogo.Thickness = 2
UIStrokeLogo.Parent = LogoButton

-- ==========================================
-- 2. สร้างหน้าต่าง UI เมนูหลัก
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 230)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -115)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Color = Color3.fromRGB(80, 80, 80)
UIStrokeMain.Thickness = 1
UIStrokeMain.Parent = MainFrame

-- หัวข้อหน้าต่าง UI
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Auto Bounce System"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

-- ==========================================
-- 3. ปุ่มเปิด/ปิดระบบ (Toggle Button)
-- ==========================================
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 45)
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- สีแดงแปลว่าปิดอยู่
ToggleButton.Text = "สถานะระบบ: ปิดใช้งาน"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 13
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = MainFrame

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(0, 8)
UICornerToggle.Parent = ToggleButton

-- ==========================================
-- 4. ส่วนปรับความสูงการเด้ง (1 - 120)
-- ==========================================
local HeightLabel = Instance.new("TextLabel")
HeightLabel.Size = UDim2.new(1, -20, 0, 25)
HeightLabel.Position = UDim2.new(0, 10, 0, 95)
HeightLabel.BackgroundTransparency = 1
HeightLabel.Text = "ความสูงการเด้ง (Power): 50"
HeightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
HeightLabel.TextSize = 13
HeightLabel.Font = Enum.Font.Gotham
HeightLabel.TextXAlignment = Enum.TextXAlignment.Left
HeightLabel.Parent = MainFrame

-- ปุ่มลดค่าความสูง (-)
local DecButton = Instance.new("TextButton")
DecButton.Size = UDim2.new(0, 45, 0, 35)
DecButton.Position = UDim2.new(0, 10, 0, 125)
DecButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DecButton.Text = "-10"
DecButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DecButton.TextSize = 14
DecButton.Font = Enum.Font.GothamBold
DecButton.Parent = MainFrame

local UICornerDec = Instance.new("UICorner")
UICornerDec.CornerRadius = UDim.new(0, 6)
UICornerDec.Parent = DecButton

-- กล่องแสดงความสูงตรงกลาง
local HeightBox = Instance.new("TextBox")
HeightBox.Size = UDim2.new(1, -120, 0, 35)
HeightBox.Position = UDim2.new(0, 60, 0, 125)
HeightBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
HeightBox.Text = "50"
HeightBox.TextColor3 = Color3.fromRGB(100, 255, 255)
HeightBox.TextSize = 15
HeightBox.Font = Enum.Font.GothamBold
HeightBox.Parent = MainFrame

local UICornerBox = Instance.new("UICorner")
UICornerBox.CornerRadius = UDim.new(0, 6)
UICornerBox.Parent = HeightBox

-- ปุ่มเพิ่มค่าความสูง (+)
local IncButton = Instance.new("TextButton")
IncButton.Size = UDim2.new(0, 45, 0, 35)
IncButton.Position = UDim2.new(1, -55, 0, 125)
IncButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
IncButton.Text = "+10"
IncButton.TextColor3 = Color3.fromRGB(255, 255, 255)
IncButton.TextSize = 14
IncButton.Font = Enum.Font.GothamBold
IncButton.Parent = MainFrame

local UICornerInc = Instance.new("UICorner")
UICornerInc.CornerRadius = UDim.new(0, 6)
UICornerInc.Parent = IncButton

-- ปุ่มปิดหน้าต่าง UI
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(1, -20, 0, 30)
CloseButton.Position = UDim2.new(0, 10, 1, -38)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CloseButton.Text = "ซ่อนหน้าต่าง"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.Gotham
CloseButton.Parent = MainFrame

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 6)
UICornerClose.Parent = CloseButton

-- ==========================================
-- 5. ระบบควบคุมตัวแปรการทำงาน
-- ==========================================
local isEnabled = false
local bouncePower = 50 -- ค่าเริ่มต้นความสูง (1-120)

-- ควบคุมปุ่มเปิด/ปิด
ToggleButton.MouseButton1Click:Connect(function()
	isEnabled = not isEnabled
	if isEnabled then
		ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- สีเขียว
		ToggleButton.Text = "สถานะระบบ: เปิดใช้งานแล้ว!"
	else
		ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- สีแดง
		ToggleButton.Text = "สถานะระบบ: ปิดใช้งาน"
	end
end)

-- ควบคุมปุ่มปรับค่าความสูง (+/-)
DecButton.MouseButton1Click:Connect(function()
	bouncePower = math.clamp(bouncePower - 10, 1, 120)
	HeightBox.Text = tostring(bouncePower)
	HeightLabel.Text = "ความสูงการเด้ง (Power): " .. bouncePower
end)

IncButton.MouseButton1Click:Connect(function()
	bouncePower = math.clamp(bouncePower + 10, 1, 120)
	HeightBox.Text = tostring(bouncePower)
	HeightLabel.Text = "ความสูงการเด้ง (Power): " .. bouncePower
end)

HeightBox.FocusLost:Connect(function()
	local num = tonumber(HeightBox.Text)
	if num then
		bouncePower = math.clamp(math.floor(num), 1, 120)
	end
	HeightBox.Text = tostring(bouncePower)
	HeightLabel.Text = "ความสูงการเด้ง (Power): " .. bouncePower
end)

-- ==========================================
-- 6. ระบบลากโลโก้บนหน้าจอมือถือ
-- ==========================================
local dragging, dragInput, dragStart, startPos

LogoButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = LogoButton.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

LogoButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		LogoButton.Position = UDim2.new(
			startPos.X.Scale, 
			startPos.X.Offset + delta.X, 
			startPos.Y.Scale, 
			startPos.Y.Offset + delta.Y
		)
	end
end)

LogoButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

-- ==========================================
-- 7. ระบบตรวจจับการสัมผัสพื้นและดีดตัวขึ้น (Bounce)
-- ==========================================
local function setupBounceSystem(character)
	local hrp = character:WaitForChild("HumanoidRootPart")
	local humanoid = character:WaitForChild("Humanoid")

	humanoid.StateChanged:Connect(function(oldState, newState)
		-- เมื่อตัวละครสัมผัสพื้นหรือวัตถุอื่นๆ (Landed)
		if newState == Enum.HumanoidStateType.Landed and isEnabled then
			-- ใช้ Velocity ดันตัวละครพุ่งขึ้นฟ้าทันทีตามค่า bouncePower (คูณด้วย 30 เพื่อให้ได้ความสูงตามหน่วย Studs จริง)
			local currentVel = hrp.AssemblyLinearVelocity
			local jumpForceMultiplier = bouncePower * 30
			
			hrp.AssemblyLinearVelocity = Vector3.new(currentVel.X, jumpForceMultiplier, currentVel.Z)
		end
	end)
end

if LocalPlayer.Character then
	setupBounceSystem(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setupBounceSystem)
