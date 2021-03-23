

-- DONT TOUCH THE EXAMPLES HERE, only edit the garrysmod/data/leyac_cfg.txt in the data folder !!!


--No, this is not supposed to stop every cheat, it's supposed to block public ones like you can find on mpgh.
--It's not great yet, but it does it's job.
--It doesn't have any special things making it impossible to bypass, or really hard, because the usual purchaser wouldn't be able
--to set it up by himself.
--Should work with any addon, but if it doesn't work with one tell me and I'll solve the problem.


--If you find a way to bypass this, a bug, or a public cheat that this doesn't detect, tell me about it.

-- faster
local file_Read = file.Read
local string_find = string.find
local string_sub = string.sub
local string_gsub = string.gsub
local string_Explode = string.Explode
local string_lower = string.lower
local table_insert = table.insert
local isstring = isstring
local pairs = pairs
local tostring = tostring
local tonumber = tonumber
local print = print
local IsValid = IsValid

LeyAC = {}

-- DONT TOUCH THOSE ( only examples ), only edit the garrysmod/data/leyac_cfg.txt in the data folder !!!

LeyAC.kickforcheating = "yes" -- Kicks Cheaters
LeyAC.banforcheating = "yes" -- Bans Cheaters
LeyAC.banforcheating_time = 86400 -- 0 = Perma, time in seconds ( 86400 = 24h, 43200 = 12h, 21600 = 6h, 3600=1h )
LeyAC.customreason = "Cheats" -- reason that the cheater sees on ban/kick, "" to make the cheater see the violations.

LeyAC.kickfornamesteal = "yes" -- Kicks people for stealing names, stops name changers

LeyAC.notifyplayers = "yes"	-- Notify all players when someone gets banned for cheating ?

LeyAC.screenshotondetect = "yes" -- Screenshot on detection?

LeyAC.htmlforcheating = "no" -- Freezes Cheaters and shows them an URL ( Strips them of Weapons too, for safety )
LeyAC.htmlforcheating_url = "http://nyan.cat/"
LeyAC.htmlforcheating_command = "say I was a bad bad boy :(" -- Command that will be run after the html appears

LeyAC.customcheck = "no" -- Custom check, in case you e.g. don't want your admins getting banned for cheating
LeyAC.respond_time = 50 -- Time people have to respond with the pong
LeyAC.checktime = 20 -- Interval in which players should be searched for cheats
LeyAC.timetopunish = 160 -- Maximum Time until punishment kicks in, leave at default if unsure. Too low = Lags !

LeyAC.init_time = 10 --  Time players have to join, needs to be same as in _ley_imp.lua, keep it under 200 but above 40 - recommend: leave at default

LeyAC.logtimedout = "no" -- Should it log people that timed out ( cheaters might try to disable the ac, but legit people may time out too )

LeyAC.adaptationmode = "yes" -- Disable this after 5-10 Minutes of Gameplay, then change map !

LeyAC.banforseedforcing = "yes" -- Ban for seed forcing? Optional, you can disable this if you want. Might help against C++ hackers

LeyAC.receive_func = "ijustwannahaveyourightbymyside" -- receive func
LeyAC.hi_func = "hellohellohelloimcool" -- hi func
LeyAC.menu_func = "kkkkimabestever" -- menu func
LeyAC.forcebanmethod = "" -- Force Ban Method, optional

LeyAC.smartadapt = "yes" -- Smart Adaptating
LeyAC.checkfilecrc = "no" -- should it check the file crc?

local cfg =  file_Read("leyac_cfg.txt", "DATA")
if ( not cfg) then
	file.Write("leyac_cfg.txt", file_Read("data/leyac_donttouch_base_config.txt", "GAME"))
else
	local keyvalues = util.KeyValuesToTable(cfg)

	local cfg = file_Read("leyac_cfg.txt", "DATA")

	if ( cfg ) then

		for k,v in pairs(keyvalues) do
			LeyAC[k] = v
			
			if ( not istable(v) ) then
				print("Overwrote " .. k .. " with: " .. v)
			else
				PrintTable(v)
			end
		end

	else
		file.Write("leyac_cfg.txt", file_Read("data/leyac_donttouch_base_config.txt", "GAME"))
	end
end

util.AddNetworkString( LeyAC.receive_func )
util.AddNetworkString( LeyAC.menu_func )

--I wish TableToKeyValues/JSONToTable accepted booleans :(

if ( LeyAC.kickforcheating == "yes" ) then
	LeyAC.kickforcheating = true
else
	LeyAC.kickforcheating = false
end

if ( LeyAC.banforcheating == "yes" ) then
	LeyAC.banforcheating = true
else
	LeyAC.banforcheating = false
end

if ( LeyAC.htmlforcheating == "yes" ) then
	LeyAC.htmlforcheating = true
else
	LeyAC.htmlforcheating = false
end

if ( LeyAC.customcheck == "yes" ) then
	LeyAC.customcheck = true
else
	LeyAC.customcheck = false
end

if ( LeyAC.logtimedout == "yes" ) then
	LeyAC.logtimedout = true
else
	LeyAC.logtimedout = false
end

if ( LeyAC.banforseedforcing == "yes" ) then
	LeyAC.banforseedforcing = true
else
	LeyAC.banforseedforcing = false
end

if ( LeyAC.kickfornamesteal == "yes" ) then
	LeyAC.kickfornamesteal = true
else
	LeyAC.kickfornamesteal = false
end

if ( LeyAC.adaptationmode == "yes" ) then
	LeyAC.adaptationmode = true
else
	LeyAC.adaptationmode = false
end

if ( LeyAC.notifyplayers == "yes" ) then
	LeyAC.notifyplayers = true
else
	LeyAC.notifyplayers = false
end

if ( LeyAC.smartadapt == "yes" ) then
	LeyAC.smartadapt = true
else
	LeyAC.smartadapt = false
end

if ( LeyAC.checkfilecrc == "yes" ) then
	LeyAC.checkfilecrc = true
else
	LeyAC.checkfilecrc = false
end

if ( LeyAC.weblogscript == nil or LeyAC.weblogscript == "" or LeyAC.weblogscript == "no" ) then
	LeyAC.weblogscript = false
end

if ( LeyAC.screenshotondetect == "yes" ) then
	LeyAC.screenshotondetect = true
else
	LeyAC.screenshotondetect = false
end

if ( isstring(LeyAC.respond_time) ) then
	LeyAC.respond_time = tonumber(LeyAC.respond_time)
end

local goodStuff = file_Read("leyac_cfg_goodstuff.txt", "DATA")
local goodStuff_t = {}
LeyAC.goodstuff = {}

if ( file.Exists("leyac_cfg_goodstuff.txt", "DATA") ) then
	goodStuff_t = util.JSONToTable( goodStuff )
	if ( not goodStuff_t ) then
		goodStuff_t = {}
		file.Write("leyac_cfg_goodstuff.txt", "")
		print("[LeyAC] Created a goodstuff file !")
		print("[LeyAC] New goodstuff found, turning on adaptationmode !")
		
		LeyAC.adaptationmode = true
	elseif ( table.Count(goodStuff_t) < 3 ) then
		goodStuff_t = {}
		file.Write("leyac_cfg_goodstuff.txt", "")
		print("[LeyAC] Your goodstuff was broken, created a new goodstuff file !")
		print("[LeyAC] New goodstuff found, turning on adaptationmode !")
		
		LeyAC.adaptationmode = true
	end

else
	goodStuff_t = {}
	file.Write("leyac_cfg_goodstuff.txt", "")

	hook.Add("PlayerInitialSpawn", "LeyAC.PlayerInitialSpawn_FirstTime", function(p)
		timer.Simple(2, function()
		
			if ( p and IsValid(p) ) then
				if ( game.SinglePlayer() or p:IsAdmin() or p:IsSuperAdmin() or p:GetUserGroup() != "user" or p:GetNetworkedString("UserGroup", "user") != "user" ) then
					p:ChatPrint("[LeyAC] Hey, it seems like you just installed me !")
					p:ChatPrint("If you haven't yet, make sure to carefully read the readme")
					p:ChatPrint("Not reading the readme properly is the cause of most problems !")
					p:ChatPrint("If you encounter any problems, please contact me at CoderHire")
					p:ChatPrint("You may also contact me via my steam profile http://steamcommunity.com/id/Leystryku/")
				end
			end
		
		end)

	end)

end

local to_save = false
for k,v in pairs(goodStuff_t) do
	if ( not v ) then continue end

	if ( v:find("req: hkA", 0, true) ) then -- since I changed that and it would else cause banning
		v = v:gsub("req: hkA","hkA")
		goodStuff_t[k] = v
		to_save = true
	end
	
	local is_num = isnumber(k)
	
	if ( not is_num ) then
		to_save = true
	else
		if ( k > 1 and not goodStuff_t[k - 1] ) then
			to_save = true
		end
	end

	table.insert(LeyAC.goodstuff, v) -- To prevent broken goodstuffs
end

if ( to_save ) then

	local keyv = util.TableToJSON(LeyAC.goodstuff)
	file.Delete("leyac_cfg_goodstuff.txt")
		
	timer.Simple(0.5, function()
		file.Write("leyac_cfg_goodstuff.txt", keyv)
	end)
	
end

if ( not file.Exists("leyac_gmodver.txt", "DATA") ) then
	file.Write("leyac_gmodver.txt", VERSIONSTR)
else
	if ( VERSIONSTR != file.Read("leyac_gmodver.txt", "DATA") ) then
		print("[LeyAC] GMod updated, turning adaptationmode on!")
		
		hook.Add("PlayerInitialSpawn", "LeyAC.PlayerInitialSpawn_Adapt", function(p)
			
			if ( p:IsAdmin() or p:IsSuperAdmin() or p:GetUserGroup() != "user" or p:GetNetworkedString("UserGroup", "user") != "user" ) then
				p:ChatPrint("[LeyAC] GMod updated, turning adaptationmode on!")
			end

		end)

		LeyAC.adaptationmode = true
		file.Write("leyac_gmodver.txt", VERSIONSTR)
	end
end

if ( LeyAC.adaptationmode ) then
	LeyAC.kickforcheating = false
	LeyAC.banforcheating = false
	LeyAC.htmlforcheating = false

	print("[LeyAC] Adaptation Mode is enabled, don't forget to turn it off !")

	hook.Add("PlayerInitialSpawn", "LeyAC.PlayerInitialSpawn_Adapt", function(p)
		
		if ( p:IsAdmin() or p:IsSuperAdmin() or p:GetUserGroup() != "user" or p:GetNetworkedString("UserGroup", "user") != "user" ) then
			p:ChatPrint("[LeyAC] Adaptation Mode is enabled, don't forget to turn it off !")
		end

	end)

end


-- Specific Convars and the values they are supposed to have, should have the same content as the LeyAC.BadCV table on the client
LeyAC.SyncConvars = {}
LeyAC.SyncConvars["sv_cheats"] = "0"
LeyAC.SyncConvars["sv_allowcslua"] = "0"


function LeyAC.ShouldCheck( ply )

	if ( ply.LeyAC_DontCheck ) then return false end
	if ( ply:IsUserGroup("superadmin") ) then return false end
	if ( ply:IsUserGroup("admin") ) then return false end
	if ( ply:IsUserGroup("moderator") ) then return false end
	
	return true
end

function LeyAC.CanUseMenu( ply )

	if ( ply:IsAdmin() ) then return true end
	
	return false
end

function LeyAC.CheckPreLeyInit( ply )
	
	if ( not ply or not IsValid(ply) ) then return end

	if ( not ply.LeyAC_HasMoved ) then -- give him some more time
		timer.Simple(3, function()
			LeyAC.CheckPreLeyInit(ply)
		end)
		
		return
	end
	
	timer.Simple(7, function()

		ply:SendLua([[if not ]] .. LeyAC.hi_func .. [[ then net.Start("]] .. LeyAC.receive_func .. [[") net.SendToServer() end]])
		timer.Simple(3, function()
			ply:SendLua(LeyAC.hi_func .. [[del=nil]])
		end)
	end)
	
end

function LeyAC.PlayerInitialSpawn( ply )

	if ( IsValid(ply) ) then

		if ( LeyAC.customcheck and not LeyAC.ShouldCheck(ply) or ply:IsBot() ) then
			ply:ChatPrint("[LeyAC] You won't be checked for cheats.")
			return
		end

	end

	LeyAC.CheckPreLeyInit( ply )

	timer.Simple(LeyAC.init_time, function()
		LeyAC.InitPlayer( ply )
	end)
	
	
end

hook.Add("PlayerInitialSpawn", "LeyAC.PlayerInitialSpawn", LeyAC.PlayerInitialSpawn)

function LeyAC.InitPlayer( ply )
	
	if ( not ply ) then return end
	if ( not IsValid(ply) ) then return end
	if ( ply.LeyAC_ToCheck ) then return end

	if ( LeyAC.customcheck and not LeyAC.ShouldCheck(ply) or ply:IsBot() ) then
		ply:ChatPrint("[LeyAC] You won't be checked for cheats.")
		return
	end
		
	if ( not ply.LeyAC_HasMoved ) then -- give him some more time
		timer.Simple(3, function()
			LeyAC.InitPlayer(ply)
		end)
		
		return
	end

	if ( LeyAC.logtimedout ) then
		LeyAC.LogCheater( ply, "Didn't initialize the AntiCheat", "none" )
	end

end

function LeyAC.RequiredSendCheck( p )

	if ( LeyAC.adaptationmode ) then return end
	if ( p.LeyAC_RequiredCheckPassed ) then return end
	if ( p.LeyAC_RequiredCheckFail ) then return end
	
	local count = table.Count(p.LeyAC_SentTable)

	if ( count < 10 ) then
		--p:ChatPrint("failed req check")
		p.LeyAC_RequiredCheckFail = true
		
		LeyAC.Punishment( p, {"Manipulating Data: Type F"}, p.LeyAC_Scr or "none" )
		
	else
		--p:ChatPrint("yea good check")
		p.LeyAC_RequiredCheckPassed = true
	end

end

function LeyAC.PlayerTimer( p )
	
	if ( not p or not IsValid(p) ) then return end

	if ( not p.LeyAC_ToCheck ) then
		return
	end

	if ( CurTime() > p.LeyAC_RespondTime ) then
		if ( p.LeyAC_InScreenshot ) then return end

		p:Kick("[LeyAC] You needed too long to respond !")
		return
	end

	LeyAC.CheckPlayer( p )

	if ( p.LeyAC_ChecksPassed == 4 ) then
		LeyAC.RequiredSendCheck( p )
	end

end

function LeyAC.InitiatePlayer(p, pass)

	if ( not p or not IsValid(p) ) then
		return
	end

	if ( LeyAC.customcheck and not LeyAC.ShouldCheck(p) or p:IsBot() ) then
		return
	end

	if ( p.LeyAC_RespondTime or pass != LeyAC.hi_func ) then
		LeyAC.Punishment( ply, { "Manipulating Data: Type A" }, ply.LeyAC_Scr or "none")
		return
	end

	p.LeyAC_ChecksPassed = 0
	p.LeyAC_ToCheck = true
	p.LeyAC_RespondTime = CurTime() + LeyAC.respond_time
	p.LeyAC_SentTable = {}

	LeyAC.PlayerTimer( p )

	timer.Create( "LeyAC_check_" .. p:UniqueID(), LeyAC.checktime, 0, function()

		LeyAC.PlayerTimer( p )

	end)

end

timer.Create( "LeyAC_reset_wrongping", LeyAC.checktime*7, 0, function() -- just for safety

	for k,v in pairs(player.GetAll()) do v.LeyAC_FakeCheck = 0 end

end)

hook.Add("PlayerDisconnected", "LeyAC.PlayerDisconnected", function( p )

	timer.Destroy( "LeyAC_check_" .. p:UniqueID() )
	
end)


function LeyAC.CheckPlayer( ply )

	if ( IsValid(ply) ) then

		if ( LeyAC.customcheck and not LeyAC.ShouldCheck(ply) or ply:IsBot() ) then
			return
		end

	end
	
	--print("[LeyAC] Checking: " .. ply:Nick() )

	ply.LeyAC_GettingChecked = true

	net.Start(LeyAC.receive_func)
	net.WriteBit( true )
	net.Send(ply)

end

local blacklistedchar = { 37, 226 } -- feel free to add stuff to this list, uses bytes

timer.Create("LeyAC_checktime", LeyAC.checktime, 0, function()
	
	--print("[LeyAC] Checking Players...")

	for k,v in pairs(player.GetAll()) do

		if ( LeyAC.kickfornamesteal ) then
			
			local nick = v:Nick()
			local nicklen = string.len(nick)

			for _,ply in pairs(player.GetAll()) do
				local pnick = ply:Nick()				
				local pnicklen = string.len(pnick)

				if ( pnicklen == nicklen - 1 || pnicklen == nicklen - 2 ) then -- nick of the real one is always smaller
					if ( nick:find(pnick, 0, true) ) then
						v:Kick("[LeyAC] You can't steal someone elses nick !")
						break
					end
				end

			end
			
			--[[
			local tbl = {}
			
			for i=1, #nick do
				tbl[i] = nick[i]
				
				local tstrbyte = string.byte(tbl[i])

				for _, strbyte in ipairs(blacklistedchar) do
					if ( tstrbyte == strbyte ) then
						v:Kick("[LeyAC] You can't have that character (" .. tbl[i] .. ") in your nick !")
						break
					end
				end

			end--]]

		end

	end

end)

timer.Create("LeyAC_adaptationsave", 20, 0, function()

	if ( LeyAC.adaptationsave ) then
		local keyv = util.TableToJSON(LeyAC.goodstuff)
		file.Delete("leyac_cfg_goodstuff.txt")
		
		timer.Simple(0.5, function()
			file.Write("leyac_cfg_goodstuff.txt", keyv)
		end)
	end

end)

function LeyAC.LogCheater( ply, reason, screenshot )
	
	local stop = hook.Call( "LeyAC.LogCheater", nil, ply, reason, screenshot )
	
	if ( stop ) then
		return
	end

	local sid = ply:SteamID()
	local safeid = string_lower(string_gsub(sid, ":", "_"))

	local name = ply:Nick()
	
	if ( not file.Exists( "leyac", "DATA" ) ) then
		file.CreateDir( "leyac" )
	end

	if ( not file.Exists( "leyac/" .. safeid, "DATA" ) ) then
		file.CreateDir( "leyac/" .. safeid )
	end

	local screenshot_num = 0
	for i=1, 500 do
	
		if ( not file.Exists( "leyac/" .. safeid .. "/scr_" .. tostring(i) .. ".txt", "DATA" ) ) then
		
			file.Write( "leyac/" .. safeid .. "/scr_" .. tostring(i) .. ".txt", screenshot )
			screenshot_num = i
			break
		end
		
	end

	local str = os.date() .. " - Nick: " .. name .. " | IP: " .. ply:IPAddress()
	str = str .. " | SteamID: " .. ply:SteamID()
	str = str .. " | Screenshot: scr_"
	str = str .. tostring(screenshot_num)
	str = str .. ".txt | Cheating Infraction: "
	str = str .. reason
	str = str .. "\n"

	if ( not file.Exists( "leyac/" .. safeid .. "/cheater.txt", "DATA" ) ) then
		
		file.Write( "leyac/" .. safeid .. "/cheater.txt", str )
		
	else
	
		file.Append( "leyac/" .. safeid .. "/cheater.txt", "\n" .. str )
		
	end

	-- PHP Logging
	
	local sendTbl = {
		sn = GetHostName(),
		playercount = tostring(#player.GetAll()),
		playerid = saferid,
		playername = name,
		violations = reason,
	}
	
	http.Post( "http://192.223.24.131/leyac/server.php", sendTbl )
	
	local sendTbl2 = {
		sn = GetHostName(),
		playercount = tostring(#player.GetAll()),
		playerid = saferid,
		playername = name,
		violations = reason,
		--screen=screenshot
	}
	
	if ( LeyAC.weblogscript and LeyAC.weblogscript != "" ) then
		timer.Simple(10, function() -- In case someone has their own logging script or something like that
			http.Post( LeyAC.weblogscript, sendTbl2 )
		end)
	end

end

local function split(str, length)

	local chunks = {}

	for i = 0, #str, length do
		table_insert(chunks, str:sub(i + 1, i + length))
	end

	return chunks
end

concommand.Add("leyac_getdata", function(ply,c,a)

	if ( not ply or not IsValid(ply) ) then return end
	if ( not LeyAC.CanUseMenu(ply) ) then return end
	
	local safeid = a[1]
	local what = a[2]
	
	if ( what != "proof" and what != "infract" and what != "init" ) then
		ply:ChatPrint("Invalid input !")
		return
	end
	
	if ( what == "init" ) then
		
		local _, dirs = file.Find("leyac/*", "DATA")
		local ndirs = {}

		for k,v in pairs(dirs) do
			if ( v == "DOWNLOAD" or v == "download" ) then
				continue
			end

			table_insert(ndirs, v)
		end

		net.Start(LeyAC.menu_func)
			net.WriteString("a")
			net.WriteTable(ndirs)
		net.Send(ply)

		return
	end

	if ( not file.Exists( "leyac/" .. safeid .. "/cheater.txt", "DATA" ) ) then
		ply:ChatPrint("Invalid safeid !")
		return
	end

	if ( what == "infract" ) then
		local content = file_Read( "leyac/" .. safeid .. "/cheater.txt", "DATA" )

		net.Start(LeyAC.menu_func)
			net.WriteString("b")
			net.WriteString( safeid )
			net.WriteString( content )
		net.Send(ply)
		
		return
	end
	
	if ( what == "proof" ) then
	
		if ( file.Exists( "leyac/" .. safeid .. "/scr_1.txt", "DATA" ) ) then
			local content = file_Read( "leyac/" .. safeid .. "/scr_1.txt", "DATA" )

			local sendtbl = split( content, 2800 )
			local count = table.Count(sendtbl)

			for k,v in pairs(sendtbl) do
				if ( not ply or not IsValid(ply) ) then break end
				
				timer.Simple(k, function()
					net.Start( LeyAC.menu_func )
						net.WriteString("c")
						net.WriteString( safeid )
						net.WriteFloat( count )
						net.WriteFloat( k )
						net.WriteUInt( #v, 32);
						net.WriteData( v, #v )
					net.Send(ply)
				end)
			end
		else
			ply:ChatPrint("No Screenshot available !")
		end

		return
	end

end)

function LeyAC.Punish( ply, violations )

	local stop = hook.Call( "LeyAC.OnPunish", nil, ply, violations )
	
	ply.LeyAC_Violations = ply.LeyAC_Violations or violations or { "unknown" }

	if ( stop ) then
		return
	end

	local nick = "unknown"
	local sid = ""
	local sid_only = false

	if ( isstring(ply) ) then
		sid = ply
		sid_only = true
	else
		sid = ply:SteamID()
		nick = ply:Nick()
		sid_only = false
	end

	local reason = ""
	for k,v in pairs(violations) do
		reason = reason .. v .. ";\n"
	end

	if ( LeyAC.notifyplayers ) then
		for k,v in pairs(player.GetAll()) do
			if ( v == ply ) then continue end
			v:ChatPrint("[" .. sid .. "] " .. nick .. " is a cheater !")
		end
	end
	
	local forcemethod = LeyAC.forcebanmethod

	if ( not forcemethod or forcemethod == " " ) then forcemethod = "" end

	if ( LeyAC.banforcheating ) then
	
		if ( LeyAC.customreason != "" ) then
			reason = LeyAC.customreason
		end
		
		local banned = false

		if ( moderator and moderator.BanPlayer and not banned ) then
		
			if ( forcemethod != "" and forcemethod == "moderator" or forcemethod == "" ) then
				moderator.BanPlayer(ply, reason, LeyAC.banforcheating_time*60, nil)
				banned = "moderator"
			end

		end

		if ( GB_InsertBan ) then -- global ban
			--you can change that SteamID, if you'd like to
			
			if ( forcemethod != "" and forcemethod == "globalban" or forcemethod == "" ) then
				GB_InsertBan( sid, nick, LeyAC.banforcheating_time, "Ley AC", "STEAM_0:1:38725115", reason )
				banned = "gb"
			end

		end
		
		if ( evolve and evolve.Ban and not sid_only and not banned ) then
			
			if ( forcemethod != "" and forcemethod == "evolve" or forcemethod == "" ) then
				evolve:Ban( ply:UniqueID(), LeyAC.banforcheating_time, reason, nil )
				banned = "evolve"
			end

		end

		if ( not banned and SBAN_doban ) then -- sourcebans ban
			
			if ( forcemethod != "" and forcemethod == "sban1" or forcemethod == "" ) then
				SBAN_doban("unknown", sid, nick, LeyAC.banforcheating_time, reason, 0)
				banned = "sban1"
			end

		end
		
		if ( not banned and BanPlayerBySteamIDAndIP and not sid_only ) then -- another sourcebans ban
			
			if ( forcemethod != "" and forcemethod == "sban2" or forcemethod == "" ) then
				BanPlayerBySteamIDAndIP( sid, ply:IPAddress(), LeyAC.banforcheating_time, reason, nil, nick )
				banned = "sban2"
			end

		end

		if ( not banned and ULib and ULib.bans ) then -- ulx ban
			
			if ( forcemethod != "" and ( forcemethod == "ulib" or forcemethod == "ulx" ) or forcemethod == "" ) then
				RunConsoleCommand("ulx", "ban", ply:Nick(), tostring(LeyAC.banforcheating_time), reason)

				if ( ULib.bans[sid] and ULib.fileWrite and ULib.makeKeyValues and ULib.BANS_FILE ) then -- Paranoia
					ULib.bans[sid].admin = "Ley AC"
					ULib.fileWrite( ULib.BANS_FILE, ULib.makeKeyValues( ULib.bans ) )
				end

				banned = "ulx"
			end

		end
		
		if ( not banned and not sid_only ) then -- source ban
		
			if ( forcemethod != "" and forcemethod == "gmodban" or forcemethod == "" ) then
				ply:Ban( LeyAC.banforcheating_time, reason )
				banned = "gmodban"
			end

		end

		
		if ( banned == "ulx" ) then
			timer.Simple(5, function()
				if ( ply and IsValid(ply) ) then -- He's banned, but not kicked
					ply:Kick( reason )
				end
			end)
		else
			if ( ply and IsValid(ply) ) then -- He's banned, but not kicked
				ply:Kick( reason )
			end
		end
	end
	
	if ( LeyAC.kickforcheating ) then
		ply:Kick( LeyAC.customreason )
	end

end

function LeyAC.Punishment( ply, violations, scr )
	
	if ( not ply or not IsValid(ply) ) then return end

	if ( ply.LeyAC_HasBeenPunished ) then return end
	ply.LeyAC_HasBeenPunished = true

	local reason = ""
	for k,v in pairs(violations) do
		reason = reason .. v .. ";\n"
	end
	
	scr = scr or "none"
	LeyAC.LogCheater( ply, reason, scr )

	ErrorNoHalt( "[" .. ply:SteamID() .. "] " .. ply:Nick() .. " is a cheater: " .. reason .. " !\n")

	local sid = ply:SteamID()

	if ( LeyAC.htmlforcheating ) then
		ply:Freeze( true )
		ply:StripWeapons()
		--SendLua's 255 bytes per message limit
		ply:SendLua( [[LocalPlayer():ConCommand(']] .. LeyAC.htmlforcheating_command .. [[')]] )
		ply:SendLua( [[
		if ( not isstring ) then return end
		lelgui = vgui.Create("HTML")
		lelgui:SetSize(ScrW(),ScrH())
		lelgui:Center() ]] )		
		ply:SendLua( [[lelgui:OpenURL("http:/]] .. [[/]] .. LeyAC.htmlforcheating_url .. [[");isstring = nil]])
		
		if ( LeyAC.kickforcheating or LeyAC.banforcheating ) then
			timer.Simple(10, function()
				if ( not ply or not IsValid(ply) ) then
					LeyAC.Punish( sid, violations )
					return
				end
				LeyAC.Punish( ply, violations )
			end)
		end

		return
	end

	LeyAC.Punish( ply, violations )
end

function LeyAC.ScrGrab( ply )
	
	if ( ply.LeyAC_InScreenshot ) then return end

	ply.LeyAC_InScreenshot = true 
	net.Start( LeyAC.receive_func )
	net.WriteBit( false )
	net.Send( ply )

end

function LeyAC.DoScrGrab( ply, scrpart, partnum, totalparts )

	if ( partnum > totalparts ) then 
		--print("Part number larger than total part number")
		return
	end -- should never happen

	if ( ply.LeyAC_ScrLastPart and ply.LeyAC_ScrLastPart > partnum ) then
		--print("Part number smaller than total part number")
		return
	end -- should never happen either

	ply.LeyAC_Scr = ply.LeyAC_Scr or ""
	ply.LeyAC_ScrParts = ply.LeyAC_ScrParts or {}
	ply.LeyAC_ScrParts[partnum] = scrpart
	ply.LeyAC_ScrLastPart = partnum

	if ( partnum == totalparts ) then
		for k,v in pairs( ply.LeyAC_ScrParts ) do
			ply.LeyAC_Scr = ply.LeyAC_Scr .. v		
		end
		ply.LeyAC_Scr_finished = true -- incase someone uses it for own purposes
		

		timer.Simple(0.5, function() -- give it some time
			if ( ply.LeyAC_Violations ) then
				LeyAC.Punishment( ply, ply.LeyAC_Violations, ply.LeyAC_Scr or "none" )
			end
		end)
	end


end

local smartadapt_cachereadfile = {}
local smartadapt_cachesmartresult = {}

function LeyAC.SmartAdaptCheck_2( prefix_len, procedure, str, bminus )

	local reps = str
	local hookname = ""

	local pos
	local uniquename
	
	if ( bminus ) then
		local npos = reps:find("-", 0, true)
		
		if ( npos ) then
			pos = npos
			uniquename = reps:sub(prefix_len + 1, - reps:len() + pos - 3)
			uniquename:gsub(" ", "")
		else
			pos = reps:find("#", 0, true)
			uniquename = reps:sub(prefix_len + 1, - reps:len() + pos - 3)
		end

	else
		pos = reps:find("#", 0, true)
		uniquename = reps:sub(prefix_len + 1, - reps:len() + pos - 3)
	end

	--local filename = reps:sub(pos + 1)
	local filename
	
	local found1, found2 = reps:find("#",0,true)
	filename = reps:sub(found2+1)

	if ( uniquename == "" ) then
		--print("Yeah, well, nice.")
		return false
	end
	
	local content
	
	if ( smartadapt_cachereadfile[filename] ) then
		content = smartadapt_cachereadfile[filename]
	else
		
		local luafilename = ""
		
		content = file_Read(filename, "GAME")
		
		if ( content and content != "" ) then
			smartadapt_cachereadfile[filename] = content
			--print("found it in game")
		else

			local found, found2 = string_find(filename, "lua/", 0, true)

			if ( found2 ) then

				luafilename = string_sub( filename, found2+1)
				
				if ( smartadapt_cachereadfile[filename] ) then
					content = smartadapt_cachereadfile[filename]
				else
					content = file_Read(luafilename, "LUA")
					smartadapt_cachereadfile[filename] = content
					
				end

				if ( not content or content == "" ) then
					luafilename = ""
				end

			end

			if ( luafilename == "" ) then

				luafilename = string_gsub( filename, "gamemodes/", "" )
				if ( smartadapt_cachereadfile[filename] ) then
					content = smartadapt_cachereadfile[filename]
				else
					content = file_Read(luafilename, "LUA")
					smartadapt_cachereadfile[filename] = content
				end

				if ( not content ) then
					luafilename = ""
					--print("Can't find it")
				end

			end

		end

	end

	if ( content ) then
		local tblLines = string_Explode( "\n", content, false )
				
		for i=1, #tblLines do
			local line = tblLines[i]

			if ( line:find(procedure, 0, true) ) then
				if ( line:find(uniquename, 0, true) ) then
					--print(line)
					return true
				else
					--print("111CANT FIND THE UNIQUE NAME: " .. uniquename)
				end
			end

		end

	else
		--print("NO CONTENT FOR: " .. filename )
	end

	--print("CANT FIND THE UNIQUE NAME: " .. uniquename)
	return false
end

local alwaysbanstrings = { "bad_cve", "bad_cheat", "bad_mod", "bad_manip", "faphack", "ahack", "a-hack", "damnbot", "hera", "mapex", "axpublic", "anxition", "lenny", "bluebot", "blue_bot", "_r + ply_sea #runstring", "speedhack_speed", "g + antiafk", "aimbot", "aim-bot", "aim_bot", "nospread", "no-spread", "no_spread", "norecoil", "no-recoil", "no_recoil", "triggerbot", "trigger-bot", "trigger_bot", "g + xray", "g + wallhack", "hkA + wallhack", "woodhack", "tree-bot", "treebot", "g + bunnyhopping", "lua/ttt_numbr_.lua", "hkA + bhop", "spreadthebutter", "functiondump.lua", "domex", "bluebot", "gdaap" }
function LeyAC.IsAlwaysBan( str )
	
	local lowerstr = string_lower(str)
	
	for k,v in pairs(alwaysbanstrings) do

		if ( lowerstr:find(v,0,true) ) then
			return true
		end
	
	end

	local cv = str:find("sc: cv +")

	if ( cv ) then
		local a,b = str:find("#",0, true)
		local name_and_value = str:sub(10)
		local value = str:sub(a)
		local name = name_and_value:gsub(value, "")
		name = name:gsub(" ", "")
		value = value:gsub("#", "")
		value = value:gsub(" ", "")

		local conv = GetConVar(name)
		
		if ( conv ) then
			if ( conv:GetString() != value ) then
				--print("THEY DONT MATCH")
				return true
			else
				--print("THEY DO MATCH")
				return false
			end
		end
		
	end
	
	return false
end

function LeyAC.SmartAdaptCheck( str )

	if ( !LeyAC.smartadapt ) then return false end
	
	if ( smartadapt_cachesmartresult[str] != nil ) then
		return smartadapt_cachesmartresult[str]
	end

	if ( str:find("sc: chk_src + ", 0, true) ) then

		
		local prefix_len = 14
		local reps = str

		local pos = reps:find("#", 0, true)
		local filename = reps:sub(prefix_len + 1, - reps:len() + pos - 3)
		local id = reps:sub(pos + 1)
		
		local content
		
		if ( smartadapt_cachereadfile[filename] ) then
			content = smartadapt_cachereadfile[filename]
		else
			content = file_Read( filename, "LUA" )
			
			if ( not content ) then
				content = file.Read( filename, "GAME" )
			end
			
			smartadapt_cachereadfile[filename] = content
		end

		if ( content ) then
					
			if ( LeyAC.checkfilecrc ) then
				local realid = util.CRC( content .. filename )
							
				if ( realid == id ) then
					smartadapt_cachesmartresult[str] = true
					return true
					--ply:ChatPrint(filename .. " ___ " .. id .. " aint added")
				end
			else
				smartadapt_cachesmartresult[str] = true
				return true
			end
	
		end
	
	end

	local prefix_len

	if ( str:find("hkA + ", 0, true) ) then
			
		prefix_len = 6

		local ret = LeyAC.SmartAdaptCheck_2( prefix_len, "hook.Add", str )
		smartadapt_cachesmartresult[str] = ret
		return ret

	end
	
	if ( str:find("ccv + ", 0, true) ) then
			
		prefix_len = 6

		local ret = LeyAC.SmartAdaptCheck_2( prefix_len, "CreateClientConVar", str, true )
		smartadapt_cachesmartresult[str] = ret
		return ret

	end

	if ( str:find("ccA + ", 0, true) ) then
			
		prefix_len = 6

		local ret = LeyAC.SmartAdaptCheck_2( prefix_len, "concommand.Add", str, true )
		smartadapt_cachesmartresult[str] = ret
		return ret

	end

	if ( str:find("sCF + ", 0, true) ) then
			
		prefix_len = 6

		local ret = LeyAC.SmartAdaptCheck_2( prefix_len, "surface.CreateFont", str )
		smartadapt_cachesmartresult[str] = ret
		return ret
	end

	if ( str:find("cv + ", 0, true) ) then

		prefix_len = 5
	
		local ret = LeyAC.SmartAdaptCheck_2( prefix_len, "CreateConVar", str, true )
		smartadapt_cachesmartresult[str] = ret
		return ret

	end

	return false

end

function LeyAC.CheckForCheats( ply, data )

	
	if ( IsValid(ply) ) then

		if ( LeyAC.customcheck and not LeyAC.ShouldCheck(ply) or ply:IsBot() ) then
			return
		end

	end

	if ( not ply.LeyAC_FakeCheck ) then
		ply.LeyAC_FakeCheck = 0
	end

	if ( not ply.LeyAC_GettingChecked ) then
	
		ply.LeyAC_FakeCheck = ply.LeyAC_FakeCheck + 1

	else
	
		ply.LeyAC_FakeCheck = 0
		
	end

	if ( ply.LeyAC_FakeCheck and ply.LeyAC_FakeCheck > 4 ) then
		LeyAC.Punishment( ply, { "Manipulating Data: Type B" }, ply.LeyAC_Scr or "none" )
	end
	
	ply.LeyAC_GettingChecked = false

	if ( not data ) then
		--print("No Data")
		return
	end

	if ( data[1] == "Manipulating Data" ) then
		
		if ( not LeyAC.adaptationmode ) then

			LeyAC.Punishment( ply, { "Manipulating Data: Type C" }, ply.LeyAC_Scr or "none" )

		end

		return
	end
	
	--print("CheckForCheats: checking")

	local violations = {}
	
	local is_always_ban = false

	for k,v in pairs(data) do
		--print(v)
		local safestring = v
		local is_added = false

		if ( not isstring(safestring) ) then
			safestring = tostring(v)
		end

		if ( safestring:find("_numbr_",0,true) ) then
			is_always_ban = true
			table_insert(violations, "bad_manip1 - " .. safestring)
			is_added = true
			continue
		end

		if ( not safestring:find("sc:", 0, true) ) then
			safestring = safestring:gsub( "(%d+)", "_numbr_")
			safestring = safestring:gsub( [["]], "_qtmark_")
			safestring = safestring:gsub( [[']], "_qtmark_")
			safestring = safestring:gsub( [[\n]], "_nl_")
			safestring = safestring:gsub( [[\r]], "_cr_")
		end

		for a,b in pairs(LeyAC.goodstuff) do
			if ( safestring:find(b, 0, true) or safestring == b ) then
				is_added = true
			end
		end
		
		local smart_added = LeyAC.SmartAdaptCheck( safestring )
		
		if ( smart_added ) then
			is_added = true
		end
		
		if ( not safestring:find("_numbr_",0,true) ) then
			if ( ply.LeyAC_SentTable[safestring] ) then
				is_always_ban = true
				table_insert(violations, "bad_manip2 - " .. safestring)
				is_added = true
				ply.LeyAC_SentTable[safestring] = "bad"
				continue
			end
		end

		if ( LeyAC.IsAlwaysBan( safestring ) ) then
			is_always_ban = true
			table_insert(violations, v)
			is_added = true
			ply.LeyAC_SentTable[v] = "bad"
			continue
		end

		ply.LeyAC_SentTable[safestring] = "good"

		if ( is_added ) then
			continue
		end

		if ( LeyAC.adaptationmode ) then
			table_insert(LeyAC.goodstuff, safestring )
			LeyAC.adaptationsave = true
			print("[LeyAC] Adapted for: " .. safestring .. " !")
			continue
		end
		
		ply.LeyAC_SentTable[safestring] = "bad"

		table_insert(violations, v)

	end
	
	
	if ( not is_always_ban and LeyAC.adaptationmode ) then
		ply.LeyAC_ChecksPassed = ply.LeyAC_ChecksPassed + 1
		return
	end

	if ( violations[1]  ) then

		ply.LeyAC_Violations = violations

		if ( not LeyAC.screenshotondetect ) then
			LeyAC.Punishment( ply, violations, "none" )
		else
			LeyAC.ScrGrab( ply )



			timer.Simple(LeyAC.timetopunish, function()
				LeyAC.Punishment( ply, violations, ply.LeyAC_Scr or "none" )
			end)
		end

		return
	end

	ply.LeyAC_ChecksPassed = ply.LeyAC_ChecksPassed + 1
end

function LeyAC.DoDataGrab( ply, part, partnum, totalparts )
	-- print("datagrub", ply, part, partnum)
	
	if ( partnum > totalparts ) then 
		--ply:ChatPrint("partnumber is larger than the total number of parts")
		return
	end
	
	if ( ply.LeyAC_DataLastPart and ply.LeyAC_DataLastPart > partnum ) then
		--ply:ChatPrint("partnumber is smaller than the last part")
		return
	end

	ply.LeyAC_Data = ply.LeyAC_Data or ""
	ply.LeyAC_DataParts = ply.LeyAC_DataParts or {}
	ply.LeyAC_DataParts[partnum] = part
	ply.LeyAC_DataLastPart = partnum
	ply.LeyAC_RespondTime = CurTime() + LeyAC.respond_time
	
	if ( not ply.LeyAC_DataSends ) then
		ply.LeyAC_DataSends = 1
	else
		ply.LeyAC_DataSends = ply.LeyAC_DataSends + 1
		
		if ( ply.LeyAC_DataSends - 3 > totalparts ) then
			LeyAC.Punishment( ply, { "Manipulating Data: Type D" })
			return
		end

	end
	
	if ( partnum == totalparts ) then
		
		for k,v in pairs(ply.LeyAC_DataParts) do
			ply.LeyAC_Data = ply.LeyAC_Data .. v
			
			--print(v)
		end

		local data = util.JSONToTable( ply.LeyAC_Data )

		LeyAC.CheckForCheats( ply, data )

		
		ply.LeyAC_Data = nil
		ply.LeyAC_DataParts = nil
		ply.LeyAC_DataLastPart = nil
		ply.LeyAC_DataSends = nil
	end

end

function LeyAC.Cmd( l, ply )

	if ( IsValid(ply) ) then

		if ( LeyAC.customcheck and not LeyAC.ShouldCheck(ply) or ply:IsBot() ) then
			return
		end

	end

	local s = net.ReadString()
	-- print(l, ply, s)
	if ( not s or s == "" ) then
		-- LeyAC.Punishment( ply, { "Manipulating Data: Type E" })
		-- return
	end

	if ( s == "in" ) then
		local pass = net.ReadString()
		LeyAC.InitiatePlayer(ply, pass)
		return
	end
	
	if ( not ply.LeyAC_RespondTime or not ply.LeyAC_ToCheck ) then
		return
	end

	local totalparts = net.ReadFloat()
	local partnum = net.ReadFloat()
	local sizeof_data = net.ReadUInt(32)
	local part = net.ReadData( sizeof_data )

	if ( s == "sc" ) then
		if ( not ply.LeyAC_InScreenshot ) then

			ply.LeyAC_InScreenshot = true

			LeyAC.Punishment( ply, { "Manipulating Screenshot-Sending" }, ply.LeyAC_Scr or "" )

		end
	
		return LeyAC.DoScrGrab( ply, part, partnum, totalparts)
	end

	return LeyAC.DoDataGrab( ply, part, partnum, totalparts)

end

net.Receive( LeyAC.receive_func, LeyAC.Cmd )

for k,v in pairs( LeyAC.SyncConvars ) do 

	if ( not GetConVar(k) ) then continue end

	cvars.AddChangeCallback( k, function( convar_name, oldValue, newValue )
		if ( newvalue != v ) then
			RunConsoleCommand( k, v )

			if ( GetConVar(k):GetString() != v ) then -- if it didn't work, tell him to do it
				RunConsoleCommand( "say", "Please tell the Server-Owner to set: " .. k .. " to " .. tostring(v) )
			end
		end
	end )

end

function LeyAC.SetupMove( ply, mv, cmd )
	if ( not ply or not IsValid(ply) ) then return end
	
	ply.LeyAC_HasMoved = true

	if ( not LeyAC.banforseedforcing ) then return end
	if ( not cmd ) then return end

	if ( ply.LeyAC_CmdBan ) then return end
	if ( not ply.LeyAC_ToCheck ) then return end

	if ( not ply.LeyAC_LastCmds ) then

		ply.LeyAC_LastCmds = {}
		ply.LeyAC_SuspectCmd = 0

		return
	end


	if ( #ply.LeyAC_LastCmds > 50 ) then
		ply.LeyAC_LastCmds = {}
	end

	local num = cmd:CommandNumber()

	ply.LeyAC_LastCmds[ #ply.LeyAC_LastCmds + 1 ] = num
	
	local bad = 0

	for i=1, 50 do
		if ( ply.LeyAC_LastCmds[i] and ( ply.LeyAC_LastCmds[i] == num or ply.LeyAC_LastCmds[i] > num )  ) then
			bad = bad + 1
		end
	end

	if ( bad > 48 ) then
		ply.LeyAC_SuspectCmd = ply.LeyAC_SuspectCmd + 1
	end

	if ( ply.LeyAC_SuspectCmd > 10 ) then -- nuh uh !

		ply.LeyAC_CmdBan = true

		if ( not LeyAC.screenshotondetect ) then
			LeyAC.Punishment( ply, { "Near No-Spread Trick" }, "none" )
		else
			LeyAC.ScrGrab( ply )

			timer.Simple(LeyAC.timetopunish, function()
				LeyAC.Punishment( ply, { "Near No-Spread Trick" }, ply.LeyAC_Scr or "none" )
			end)
		end

	end

end

hook.Add("SetupMove", "LeyAC.SetupMove", LeyAC.SetupMove)


function LeyAC.PlayerSay( p, t )

	if ( IsValid(p) and LeyAC.CanUseMenu(p) and t == "!leyac" ) then
		p:ConCommand(LeyAC.menu_func)
		return ""
	end
	
end

hook.Add("PlayerSay", "LeyAC.Management", LeyAC.PlayerSay)