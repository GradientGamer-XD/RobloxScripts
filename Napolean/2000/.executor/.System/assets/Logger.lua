local logger = {}

logger.Info = function (text)
	print("Logger/INFO: "..text)
end

logger.Warn =  function (text)
	warn("Logger/WARN: "..text)
end

logger.Error = function (text)
	warn("Logger/ERROR: "..text)
end

logger.Fatal = function (text)
	error("Logger/FATAL: "..text)
end

return logger
