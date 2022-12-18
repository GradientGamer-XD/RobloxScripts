--[[
███████╗ █████╗ ███████╗███████╗██╗     ██╗ ██████╗ ██╗  ██╗████████╗██╗███╗   ██╗ ██████╗ 
██╔════╝██╔══██╗██╔════╝██╔════╝██║     ██║██╔════╝ ██║  ██║╚══██╔══╝██║████╗  ██║██╔════╝ 
███████╗███████║█████╗  █████╗  ██║     ██║██║  ███╗███████║   ██║   ██║██╔██╗ ██║██║  ███╗
╚════██║██╔══██║██╔══╝  ██╔══╝  ██║     ██║██║   ██║██╔══██║   ██║   ██║██║╚██╗██║██║   ██║
███████║██║  ██║██║     ███████╗███████╗██║╚██████╔╝██║  ██║   ██║   ██║██║ ╚████║╚██████╔╝
╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ 

▒█▀▄▒▄▀▄░▀█▀░█▄█▒█▀░█░█▄░█░█▀▄▒██▀▒█▀▄░░░▄▀▀▒██▀▒█▀▄░█▒██▀░▄▀▀
░█▀▒░█▀█░▒█▒▒█▒█░█▀░█░█▒▀█▒█▄▀░█▄▄░█▀▄▒░▒▄██░█▄▄░█▀▄░█░█▄▄▒▄██

Real Life model brand and name: Emergi-lite Revelation series

Safelighting Pathfinder Series

Model: PFL-005B3

Thank you for your purchase


░█░░░▀░░█▀▀░█▀▄░█▀▀░█▀▀▄░█▀▀░█▀▀░░░█▀▀▄░█▀▀▀░█▀▀▄░█▀▀░█▀▀░█▀▄▀█░█▀▀░█▀▀▄░▀█▀
░█░░░█▀░▀▀▄░█░░░█▀▀░█░▒█░▀▀▄░█▀▀░░░█▄▄█░█░▀▄░█▄▄▀░█▀▀░█▀▀░█░▀░█░█▀▀░█░▒█░░█░
░▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░░▀░▀▀▀░▀▀▀░░░▀░░▀░▀▀▀▀░▀░▀▀░▀▀▀░▀▀▀░▀░░▒▀░▀▀▀░▀░░▀░░▀░
Liscencce agreement

By owning this product, You agree to the following

	1. You MAY NOT REDISTRIBUTE any scripts or entire model without permission
	2. If you make "Improvements" to the model, contact GamerG#9980 on Discord if you wish to publish it.
	3. You Can make changes to the code and mess with it as long as you dont publish it
]]


--Source code---

--Import calls
local this = script
local isPowered = this.Connected
local import = script.Parent
local run = import.Run
local lamp1 = import.LampUnit.Lamp["1"].Light
local lamp2 = import.LampUnit.Lamp["2"].Light
local servo = import.LampUnit.Motor.HingeConstraint

local circut = import.Control

local battery = circut.Battery

local ACPower = circut.L1
local BatteryE = circut.L2
local Lamp1E = circut.L3
local Lamp2E = circut.L4
local pilot = circut.Button



--Main Class


function activate () --Emergency Mode
	servo.LowerAngle = 175
	servo.AngularVelocity = 1.5
	wait(2.25)
	servo.LowerAngle = 180
	servo.AngularVelocity = 4
	lamp1.Material = Enum.Material.Neon
	lamp1.SurfaceLight.Enabled = true
	lamp2.Material = Enum.Material.Neon
	lamp2.SurfaceLight.Enabled = true
end

function retract() --Dormat Mode
	lamp1.Material = Enum.Material.Metal
	lamp1.SurfaceLight.Enabled = false
	lamp2.Material = Enum.Material.Metal
	lamp2.SurfaceLight.Enabled = false
	wait(.25)
	servo.UpperAngle = 5
	servo.AngularVelocity = -1.5
	wait(2.25)
	servo.AngularVelocity = -8
	servo.UpperAngle = 0
end


isPowered.Changed:Connect(function()
	if isPowered.Value == true then
		retract()
		battery.Battery.Enabled = true
		battery.Battery.Disabled = false
		if battery.Charge.Value == 0 then
			battery.Charge.Value = 50
		end
		battery.Battery.Enabled = true
		battery.Battery.Disabled = false
		ACPower.Color = Color3.fromRGB(0)
		BatteryE.Color = Color3.fromRGB(0)
		Lamp1E.Color = Color3.fromRGB(0)
		Lamp2E.Color = Color3.fromRGB(0)
		pilot.Color = Color3.fromRGB(0)
		ACPower.Color = Color3.fromRGB(255)
		wait(.1)
		ACPower.Color = Color3.fromRGB(0)
		BatteryE.Color = Color3.fromRGB(255)
		wait(.1)
		BatteryE.Color = Color3.fromRGB(0)
		Lamp1E.Color = Color3.fromRGB(255)
		wait(.1)
		Lamp1E.Color = Color3.fromRGB(0)
		Lamp2E.Color = Color3.fromRGB(255)
		wait(.1)
		Lamp2E.Color = Color3.fromRGB(0)
		wait(.1)
		pilot.Color = Color3.fromRGB(0,255)
		wait(.1)
		pilot.Color = Color3.fromRGB(255,255)
		wait(.1)
		pilot.Color = Color3.fromRGB(255)
		wait(.5)
		pilot.Color = Color3.fromRGB(0)
		wait(.25)
		pilot.Color = Color3.fromRGB(255)
		ACPower.Color = Color3.fromRGB(255)
		BatteryE.Color=Color3.fromRGB(255,255)
		wait(3)
		import.BatteryStatus.Changed:Connect(function()
			if import.BatteryStatus.Value == 0 then
				pilot.Color = Color3.fromRGB(0, 255)
				BatteryE.Color = Color3.fromRGB(0,255)
			elseif import.BatteryStatus.Value == 1 then
				pilot.Color = Color3.fromRGB(255)
				ACPower.Color = Color3.fromRGB(255)
				BatteryE.Color = Color3.fromRGB(255,255)
			elseif import.BatteryStatus.Value == 2 then
				pilot.Color = Color3.fromRGB(0)
				ACPower.Color = Color3.fromRGB(0)
				BatteryE.Color = Color3.fromRGB(255)
			end
		end)
		run.Changed:Connect(function()
			if run.Value == true and script.Connected.Value == true then
				battery.Usage.Value = true
				wait(2)
				activate()
			else
				battery.Usage.Value = false
				wait(2.5)
				retract()
			end
		end)
	else
		ACPower.Color = Color3.fromRGB(0)
		BatteryE.Color = Color3.fromRGB(0)
		Lamp1E.Color = Color3.fromRGB(0)
		Lamp2E.Color = Color3.fromRGB(0)
		pilot.Color = Color3.fromRGB(0)
		battery.Usage.Value = false
		battery.Battery.Enabled = false
		battery.Battery.Disabled = true
		retract()
	end
	
end)
