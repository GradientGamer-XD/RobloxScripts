return {
	
	['Software_Options'] = {
		['Page_Tone'] = "Default",

		['Modules'] = {

		},

		['Zones'] = {
			--Zone ID. Displayed on the master
			['01'] = {
				['Name'] = "DEFAULT", --All caps, max of 10
				['Dial_Number'] = "4011",
			},

			['O2'] = {
				['Name'] = "AUX",
				['Dial_Number'] = "4012",
			},



		},

		['Pre-Recorded_MSG'] = {
			['07'] = {
				['AssetID'] = 2878722579,
				['Page_First'] = false
			},
		},

	},
	
	['Network_Options'] = { --Wireless Communication with remote intercoms or speakers
		
		['Connect'] = true,
		
		['Network_Address'] = "127.0", --intentionaly 2 entries "000.000"
		['Port'] = "284", --Give a unique port if you have multiple units on the same network to prevent conflicts
		
		
	}
	
}
	

