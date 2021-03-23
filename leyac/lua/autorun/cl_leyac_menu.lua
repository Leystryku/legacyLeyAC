if ( SERVER ) then AddCSLuaFile( ) return end

local Menu_Func = "kkkkimabestever" -- has to be the same one as in the config!

local Cheaters = {}

local welcome = [[
<!DOCTYPE html>
<html>
	<head>
		<title>LeyAC Management Panel</title>
		<style type="text/css">
		body { background-color:rgb(255,255,255); }
		</style>
	</head>
	<body>
		<h1 align="center"style="font-family:Verdana">Welcome to the LeyAC Management Panel !</h1>
		<h3 align="center" style="font-family:Verdana">Left-Click a SteamID to read the user's cheating history. ( Fast )</h3>
		<br/>
		<br/>
		<h3 align="center" style="font-family:Verdana">Right-Click a SteamID to see the person cheating. ( Slow )</h3>
	</body>
</html>

]]

local function MenuToggle()

	RunConsoleCommand("leyac_getdata", "0", "init")

end

concommand.Add(Menu_Func, MenuToggle)

local LeyAC_Scr = ""
local LeyAC_ScrParts = {}
local LeyAC_DlCache = {}
LeyAC_DlCache["img"] = {}
LeyAC_DlCache["img_p"] = {}
LeyAC_DlCache["txt"] = {}

local function Menu()

	if ( not file.Exists( "leyac", "DATA" ) ) then
		file.CreateDir( "leyac" )
	end
	
	if ( not file.Exists( "leyac/download", "DATA" ) ) then
		file.CreateDir( "leyac/download" )
	end

	local main = vgui.Create("DFrame")
	LeyAC_Menu = main

	main:Center()
	main:SetSize( 600, 600 )
	main:SetVisible(true)
	main:SetDraggable(true)
	main:SetSizable(true)

	main:MakePopup()
	main:SetTitle("Ley AC - Management")

	local html = vgui.Create("HTML", main)
	html:SetPos( 170, 30 )
	local w, h = main:GetSize()
	html:SetSize( w*0.70, h*0.90 )
	html:SetHTML( welcome )
	html.Think = function(pnl)
		if ( not main or not html or not IsValid(main) or not IsValid(html) ) then return end
		local w, h = main:GetSize()
		
		if ( w > 1000 ) then
			w = w*1.20
		end

		--if ( h > 1000 ) then
		--	h = h*1.09
		--end

		html:SetSize( w*0.70, h*0.90 )
	end

	LeyAC_Menu_html = html
	
	local list = vgui.Create("DListView", main)
	list:SetPos( 10, 30 )
	list:SetSize( 150, 550 )
	list:AddColumn("Steam ID")
	LeyAC_Menu_list = list

	list.OnClickLine = function( pnl, line, is_select )
		
		local sid = line:GetColumnText(1)
		local safe_sid = string.lower(string.gsub(sid, ":", "_"))
		
		if ( input.IsMouseDown(MOUSE_RIGHT) ) then

			local savedhtml = file.Read("leyac/download/" .. safe_sid .. "/scr.txt")
			
			if ( not savedhtml ) then
				savedhtml =  file.Read("leyac/download/" .. safe_sid .. "/scr.html")
			end

			if ( not savedhtml ) then
				savedhtml =  file.Read("leyac/download/" .. safe_sid .. "/scr.htm")
			end

			if ( savedhtml ) then
				if ( IsValid(LeyAC_Menu_html) ) then
					LeyAC_Menu_html:SetHTML( savedhtml )
				end
				return
			end

			if ( LeyAC_DlCache["img"][safe_sid] ) then
				local html = [[<!DOCTYPE html>
								<html>
									<head>
										<title>LeyAC Management Panel</title>
									</head>
									<body>
										<img width="1280" height="1024" src="data:image/jpeg;base64, ]] .. LeyAC_DlCache["img"][safe_sid] .. [[" />
									</body>
								</html>
				]]

				LeyAC_Menu_html:SetHTML( html )
				return
			end

			if ( LeyAC_DlCache["img_p"][safe_sid] ) then
				local tmpscr = ""
				for k,v in pairs( LeyAC_DlCache["img_p"][safe_sid] ) do
					tmpscr = tmpscr .. v
				end
				local html = [[<!DOCTYPE html>
								<html>
									<head>
										<title>LeyAC Management Panel</title>
									</head>
									<body>
										<img width="1280" height="1024" src="data:image/jpeg;base64, ]] .. tmpscr .. [[" />
									</body>
								</html>
				]]

				LeyAC_Menu_html:SetHTML( html )
				return
			end

			chat.AddText(Color(255,0,0), "Downloading Image. Please be patient...")
			RunConsoleCommand("leyac_getdata", safe_sid, "proof")

			return
		else
			
			
			if ( input.IsMouseDown(MOUSE_LEFT) ) then
				
				--[[
				local savedhtml = file.Read("leyac/download/" .. safe_sid .. "/cheater.txt")
				
				if ( not savedhtml ) then
					savedhtml =  file.Read("leyac/download/" .. safe_sid .. "/scr.html")
				end

				if ( not savedhtml ) then
					savedhtml =  file.Read("leyac/download/" .. safe_sid .. "/scr.htm")
				end

				if ( savedhtml ) then
					if ( IsValid(LeyAC_Menu_html) ) then
						LeyAC_Menu_html:SetHTML( savedhtml )
					end
					return
				end
				--]]
				-- disabled for txt, txt loads pretty fast and is more prone to change

				if ( LeyAC_DlCache["txt"][safe_sid] ) then

					local html = [[<!DOCTYPE html>
									<html>
										<head>
											<title>LeyAC Management Panel</title>
											<style type="text/css">
											body { background-color:rgb(255,255,255); }
											</style>
										</head>
										<body>
											]] .. LeyAC_DlCache["txt"][safe_sid] .. [[
										</body>
									</html>
					]]
					
					if ( IsValid(LeyAC_Menu_html) ) then
						LeyAC_Menu_html:SetHTML( html )
					end
					
					return
				end
				chat.AddText(Color(255,0,0), "Downloading Infraction. Please be patient...")
				RunConsoleCommand("leyac_getdata", safe_sid, "infract")
			end
		
		end

	end
	
	

end

net.Receive( Menu_Func, function(l)
	
	local tp = net.ReadString()
	
	if ( tp == "a" ) then
		local sids = net.ReadTable()
		Menu()
		for k,v in pairs(sids) do
			
			local rsid = v:upper():gsub("_", ":"):gsub("STEAM:", "STEAM_")
			
			
			LeyAC_Menu_list:AddLine( rsid )
		end

		return
	end

	if ( not LeyAC_Menu_html ) then
		return
	end

	if ( tp == "b" ) then

		local safe_sid = net.ReadString()
		local infract = net.ReadString()
		infract = infract:gsub( "\n", "<br />")

		if ( not file.Exists( "leyac/download/" .. safe_sid, "DATA" ) ) then
			file.CreateDir( "leyac/download/" .. safe_sid )
		end

		LeyAC_DlCache["txt"][safe_sid] = infract

		local html = [[<!DOCTYPE html>
						<html>
							<head>
								<title>LeyAC Management Panel</title>
								<style type="text/css">
								body { background-color:rgb(255,255,255); }
								</style>
							</head>
							<body>
								]] .. infract .. [[
							</body>
						</html>
		]]
		
		file.Write("leyac/download/" .. safe_sid .. "/cheater.txt", html)

		if ( IsValid(LeyAC_Menu_html) ) then
			LeyAC_Menu_html:SetHTML( html )
		end

		return
	end

	if ( tp == "c" ) then
		
		local safe_sid = net.ReadString()
		local totalparts = net.ReadFloat()
		local partnum = net.ReadFloat()
		local sizeof_data = net.ReadUInt(32)
		local scrpart = net.ReadData( sizeof_data )

		if ( not file.Exists( "leyac/download/" .. safe_sid, "DATA" ) ) then
			file.CreateDir( "leyac/download/" .. safe_sid )
		end

		if ( partnum > totalparts ) then return end -- should never happen

		LeyAC_DlCache["img_p"][safe_sid] = LeyAC_DlCache["img_p"][safe_sid] or {}
		LeyAC_DlCache["img_p"][safe_sid][partnum] = scrpart

		if ( partnum == totalparts ) then
			
			local tmpscr = ""
			for k,v in pairs( LeyAC_DlCache["img_p"][safe_sid]  ) do
				tmpscr = tmpscr .. v
			end
			
			LeyAC_DlCache["img"][safe_sid] = tmpscr

			local html = [[<!DOCTYPE html>
							<html>
								<head>
									<title>LeyAC Management Panel</title>
								</head>
								<body>
									<img width="1280" height="1024" src="data:image/jpeg;base64, ]] .. tmpscr .. [[" />
								</body>
							</html>
			]]

			if ( IsValid(LeyAC_Menu_html) ) then
				LeyAC_Menu_html:SetHTML( html )
			end
			
			file.Write("leyac/download/" .. safe_sid .. "/scr.txt", html)
			
			print("[LeyAC][Menu] Loading Image [FINISHED !]" )  
			chat.AddText(Color(255,0,0), "Image downloaded successfully !")
		else
			print("[LeyAC][Menu] Loading Image - pt: " .. tostring(partnum) .. "[" .. tostring(totalparts) .. "]" )  
			
			local tmpscr = ""
			for k,v in pairs( LeyAC_DlCache["img_p"][safe_sid] ) do
				tmpscr = tmpscr .. v
			end

			local html = [[<!DOCTYPE html>
							<html>
								<head>
									<title>LeyAC Management Panel</title>
								</head>
								<body>
									<img width="1280" height="1024" src="data:image/jpeg;base64, ]] .. tmpscr .. [[" />
								</body>
							</html>
			]]

			if ( IsValid(LeyAC_Menu_html) ) then
				LeyAC_Menu_html:SetHTML( html )
			end

		end

		return
	end

end)