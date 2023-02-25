
local Controller = {}
-- Jar version 0.01 DEV. created by TheKevin809 and GradientGamer(No Roblox Account)
-- Console scripts
local function logger_INFO(data)
	print("\n"..os.date().." Sportsbox Module THREAD: " .. data)
end
local function responseOK()
	print("𝐑𝐄𝐒𝐏𝐎𝐍𝐒𝐄: 𝐎𝐊!")
end
local function logger_WARN(data)
	warn(data)
end
local function logger_ERROR(data)
	error("𝐑𝐄𝐒𝐏𝐎𝐍𝐒𝐄: 𝐄𝐑𝐑𝐎𝐑!! ".. data)
end
Controller.init =  function(Client)
	logger_INFO("\n Sportsbox Controller initializing . . . ")
	wait(2)
	logger_INFO("Getting assets")
	--Client = workspace["SportsBox RV 1"]["Executor.exe"]
	local main = Client.Parent
	logger_INFO("Downloading Assets")
	local data = main:FindFirstChild("Data") or Instance.new('Folder', main)
	data.Name = "Data"
	local power = main:FindFirstChild("Power") or Instance.new('BoolValue', data)
	power.Name = "Power"
	power.Value = false
	local arrowDir = main:FindFirstChild("Arrow_Direction") or Instance.new('StringValue', data)
	arrowDir.Name = "Arrow_Direction"
	local broadcast = main:FindFirstChild("Broadcast") or Instance.new('NumberValue', data)
	broadcast.Name = "Broadcast"
	local channel = main:FindFirstChild("Channel") or Instance.new('NumberValue', data)
	channel.Name = "Channel"
	local tickRate = main:FindFirstChild("Count") or Instance.new('NumberValue', data)
	tickRate.Name = "Count"
	local display = main:FindFirstChild("Display") or Instance.new('StringValue', data)
	display.Name = "Display"	
	local miliSec = main:FindFirstChild("Mili") or Instance.new('StringValue', data)
	miliSec.Name = "Mili"	
	local minute = main:FindFirstChild("Min") or Instance.new('StringValue', data)
	minute.Name = "Min"
	local setPhase = main:FindFirstChild("Phase") or Instance.new('StringValue', data)
	setPhase.Name = "Phase"
	local currentButton = main:FindFirstChild("Pressed_Buttons") or Instance.new('StringValue', data)
	currentButton.Name = "Pressed_Buttons"	
	local second = main:FindFirstChild("Sec") or Instance.new('StringValue', data)
	second.Name = "Sec"	
	local setDisplay = main:FindFirstChild("TextData") or Instance.new('StringValue', data)
	setDisplay.Name = "TextData"
	local home = main:FindFirstChild("Home") or Instance.new('NumberValue', data)
	home.Name = "Home"
	local guest = main:FindFirstChild("Guest") or Instance.new('NumberValue', data)
	guest.Name = "Guest"
	local period = main:FindFirstChild("Period") or Instance.new('NumberValue', data)
	period.Name = "Period"
	local controllerAPI = game:GetService("ReplicatedStorage"):FindFirstChild("SportsBOX_Controller_API") or Instance.new('BindableEvent', game:GetService("ReplicatedStorage"))
	controllerAPI.Name = "SportsBOX_Controller_API"
	local getButtons = main:WaitForChild("Buttons")
	local getConfig
	local min, sec, milisec
	local function defaultTime()
		min = 1
		sec = 10
		milisec = 0
	end
	local function send(arg1, arg2, arg3, arg4, arg5, arg6)
		if arg1 == "Time" and arg2 == "P1" then
			controllerAPI:Fire(main,"TIME","P1",min, second.Value)
		end
		if arg1 == "Time" and arg2 == "P2" then
			controllerAPI:Fire(main,"TIME","P2", second.Value, milisec)
		end
		if arg1 == "Score" and arg2 == "Home" then
			controllerAPI:Fire(main,"SCORE", "HOME", home.Value)
		end
		if arg1 == "Score" and arg2 == "Guest" then
			controllerAPI:Fire(main,"SCORE", "GUEST", guest.Value)
		end
		if arg1 == "ALL" then
			controllerAPI:Fire(main,"DisplayALL", min, second.Value, home.Value, guest.Value, period.Value)
		end
		if arg1 == "Clear" then
			controllerAPI:Fire(main, "Clear")
		end
		if arg1 == "Horn" and arg2 == true then
			controllerAPI:Fire(main, "HORN", true)
		end
		if arg1 == "Horn" and arg2 == false then
			controllerAPI:Fire(main, "HORN", false)
		end
	end
	local paused = false
	local usage = false
	local showGuest = false
	local showHome = false
	local showPeriod = false
	local showSet = false
	local showHorn = false
	local showTime = true
	local meta, debugger, tickspeed, dallas
	local function updateNums (arg1, arg2, arg3, arg4)-- arg5, arg6, arg7, arg8, arg9, arg10
		if arg1 == "Time" then
				second.Value = sec
				minute.Value = min	
				if sec <=9 then
					second.Value = ("0"..sec)
				end
				if min <=9 then
					minute.Value = ("0"..min)
			end
			if showTime == true then
				if showHorn == true then
					display.Value = (minute.Value.."*"..second.Value.."."..milisec)
				else
					display.Value = (minute.Value..":"..second.Value.."."..milisec)
				end
			end
		end
	end
	second.Value = ("00")
	power.Changed:Connect(function ()
		if power.Value then
			logger_INFO("Controller Powered ON")
			display.Value = ("**********") -- MAX 10 Characters (includes spacing)
			arrowDir.Value = "B"
			wait(1.1)
			display.Value = ("0000000000")
			wait(1.1)
			display.Value = ""
			arrowDir.Value = ""
			wait(1)
			display.Value = "PLS WAIT"
			showGuest = false
			showHome = false
			showPeriod = false
			showSet = false
			showHorn = false
			showTime = true
			broadcast.Value = 1
			channel.Value = 1
			arrowDir.Value = "D"
			if min == nil then 
				defaultTime()
			end
			updateNums("Time")
			send("ALL")
			paused = false
			usage = false
		else
			display.Value = "" --Build a shutdown script soon
			arrowDir.Value = ""
			send("Clear")
		end
	end)
	local function CHKTMN()
		if min == 0 then
			send("Time", "P2")
		else
			send("Time", "P1")
		end
	end	
	getButtons.Run.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value and not usage then
			usage = true
			paused = false	
			local function timeHorn()
				showHorn = true
				send("Horn", true)
				updateNums("Time")
				wait(3)
				showHorn = false
				send("Horn", false)
				updateNums("Time")
			end
			
			while power.Value do
				if paused then
					usage = false
					break
				else
					if min == 0 and sec ==0 and milisec ==0 then
						paused = true
						timeHorn()
					else
						milisec -=1
						if milisec < 0 then
							milisec = 9
							sec -= 1
							if sec < 0 then
								sec = 59
								min -=1
							end
						end
					end
				end
				updateNums("Time")
				CHKTMN()
				task.wait(0.1)
			end
		else
			return nil
		end                
	end)
	getButtons.Stop.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			paused = true
		end                
	end)
	getButtons.Horn.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			showHorn = true
			send("Horn", true)
			updateNums("Time")
		end	
		getButtons.Horn.SurfaceGui.Button.MouseButton1Up:Connect(function()
			if power.Value then
				showHorn = false
				send("Horn", false)
				updateNums("Time")
			end
		end)
	end)
	getButtons.On.SurfaceGui.Button.MouseButton1Down:Connect(function()
		power.Value = not power.Value
	end)
	getButtons.Reset.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			if showTime == true then
				defaultTime()
				updateNums("Time")
				CHKTMN()
			end
			if showHome == true then
				home.Value = 0
				display.Value = ("HOME   "..home.Value)
				send("Score", "Home")
			end
			if showGuest == true then
				guest.Value = 0
				display.Value = ("GUEST  "..guest.Value)
				send("Score", "Guest")
			end
		end
	end)
	getButtons.Home.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			showTime = false
			showHome = true
			showGuest = false
			display.Value = ("HOME   "..home.Value)
		end
	end)
	getButtons.Guest.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			showTime = false
			showHome = false
			showGuest = true
			display.Value = ("GUEST  "..guest.Value)
		end
	end)
	getButtons.Add_3.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			if showGuest == true then
				guest.Value +=3
				send("Score", "Guest")
				display.Value = ("GUEST  "..guest.Value)
			elseif showHome == true then
				home.Value +=3
				send("Score", "Home")
				display.Value = ("HOME   "..home.Value)
			end
		end
	end)
	getButtons.Add_2.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			if showGuest == true then
				guest.Value +=2
				send("Score", "Guest")
				display.Value = ("GUEST  "..guest.Value)
			elseif showHome == true then
				home.Value +=2
				send("Score", "Home")
				display.Value = ("HOME   "..home.Value)	
			end
		end
	end)
	getButtons.Add_1.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			if showGuest == true then
				guest.Value +=1
				send("Score", "Guest")
				display.Value = ("GUEST  "..guest.Value)
			elseif showHome == true then
				home.Value +=1
				send("Score", "Home")
				display.Value = ("HOME   "..home.Value)
			end
		end
	end)
	getButtons.Clear.SurfaceGui.Button.MouseButton1Down:Connect(function()
		if power.Value then
			showGuest = false
			showHome = false
			showPeriod = false
			showSet = false
			showHorn = false
			showTime = true
			updateNums("Time")
		end	
	end)
end
responseOK()
return Controller
