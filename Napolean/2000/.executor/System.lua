
--Napolean Paging Systmems Inc

--Not to be confused with the Nimbus 2000 or Nimbus Racing Broom Company

--Napolean 2000 advanced paging system

--Modular and Multi-purpose

--View this on the Github page

--To update the firmware, replace everything here with new code from the GitHub page

--Credits of all 3rd party assets used in the model go to their respective owner.

--System loader version: 0.02

local Napolean2000 = {}


 logger = require(script.Assets.Logger)



Napolean2000.loadSystem = function(target, config, targetModel, autoStart, logMode)
	logger.Info("System Initializng")
	
	if logMode == "Trace" then
		logger.Warn("Tracing mode is enabled. Printing Diagnostic data")
		logger.Info("Target Model: "..tostring(target))
		logger.Info("System Config: "..tostring(config))
		logger.Info("Automatically Start Unit? "..tostring(autoStart))
	end
	
	
	--Look for required instances to safeley load module
	
	local findDotSysInfo = target.Parent:FindFirstChild(".sysinfo")
	if not findDotSysInfo then
		logger.Fatal("Unable to load firmware to the model '"..tostring(target.Parent).."'! Is this the targeted model a Napolean 2000?")
	end
	
	
	require(script.Assets.Modules.Firmware).Initialize(target, config, targetModel, autoStart, logMode)
	

end


return Napolean2000
