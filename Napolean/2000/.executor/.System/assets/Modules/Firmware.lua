local Napolean2000 = {}


assets = script.Parent.Parent
logger = require(assets.Logger)


--to get code insight working. Config and Instance variables are pre-set. make them comments before finalizing


Napolean2000.Initialize = function (cTarget, cConfig, cTargetModel, autoStart, logMode)
	
	local Config = require(cConfig)
	
	--to get code insight working. Config and Instance variables are pre-set. make them comments before finalizing
	 --cTarget = script.Parent.Parent.Parent.Parent
	 --Config = require(script.Parent.Parent.Parent.Parent.Setup)
	 --cTargetModel = cTarget.Parent
	
	
	
	local getInd = cTargetModel.Indicator
	local getButtons = cTargetModel.Buttons
	

	local ready = true
	local power = false
	local networkAddr
	local networkPort
	
	
	getInd.PowerInd.Power.Value = true

	cTargetModel.Controller.Power.Changed:Connect(function()
		ready =false
		if cTargetModel.Controller.Power.Value == true then
			getButtons.Power.Button.Material = Enum.Material.Neon
			getButtons.Power.Button.Color = Color3 .fromRGB(255, 176, 0)
			
			wait(.5)
			for i, v in pairs(getInd:GetChildren()) do
				v.Power.Value = true
			end
			wait(.3)
			cTargetModel.Controller.Display1.Value = ("NAPOLEAN")
			cTargetModel.Controller.Display2.Value = ("2000")
			logger.Info("Napolean 2000")
			logger.Info("System Initializing")
			wait(1)
			for i, v in pairs(getInd:GetChildren()) do
				v.Power.Value = false
			end
			getInd.PowerInd.Power.Value = true
			wait(4)
			
			logger.Info("Establishing Network")
			if Config.Network_Options.Connect == true then
				if logMode == "Trace" then
					logger.Info("Configuring the network")
					logger.Info("Applying network properties")
				end
				networkAddr = Config.Network_Options.Network_Address
				networkPort = Config.Network_Options.Port
				if logMode == "Trace" then
					logger.Info("Establishing network on network address: "..tostring(networkAddr)..":"..tostring(networkPort))
					logger.Info("Successfully established network")
				end
				getInd.NetworkInd.Power.Value = true
			else
				if logMode == "Trace" then
					logger.Info("Network option is not enabled. Sipping")
				end
			end
			
			cTargetModel.Controller.Display1.Value = ("NORMAL")
			cTargetModel.Controller.Display2.Value = ("00")
			logger.Info("Ready")
			ready = true
		else
			for i, v in pairs(getInd:GetChildren()) do
				v.Power.Value = false
			end
			ready = false
			getInd.PowerInd.Power.Value = true
			cTargetModel.Controller.Display1.Value = ("")
			cTargetModel.Controller.Display2.Value = ("")
			networkAddr = nil
			networkPort = nil
			logger.Info("Powering down")
			wait(1)
			getButtons.Power.Button.Material = Enum.Material.SmoothPlastic
			getButtons.Power.Button.BrickColor = BrickColor.new("Institutional white")
			ready = true
		end
		
	end)

		
	
	if autoStart == true then
		cTargetModel.Controller.Power.Value = true

	end
	
	getButtons.Power.Button.SurfaceGui.Button.MouseButton1Down:Connect(function()

		if ready == true then
			if cTargetModel.Controller.Power.Value == false then
				cTargetModel.Controller.Power.Value = true
			elseif cTargetModel.Controller.Power.Value == true then
				cTargetModel.Controller.Power.Value = false
			end
		else
			logger.Warn("Cant process this action yet")
		end
	end)
	
	
end




return Napolean2000




