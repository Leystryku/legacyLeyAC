
if ( LeyAC or not CLIENT ) then return end

local gc = garbage
garbage = nil

if ( not gc ) then
	gc = 0
end

--No, this is not supposed to stop every cheat, it's mainly supposed to block public ones like you can find on mpgh.
--It's pretty solid and does it's job.
--It doesn't have much special things making it impossible to bypass, or really hard, because the usual purchaser wouldn't be able
--to set it up by himself.
--Should work with any addon, but if it doesn't work with one tell me and I'll solve the problem.


--If you find a way to bypass this, a bug, or a public cheat that this doesn't detect, tell me about it.


local LeyAC = {}
LeyAC.receive_func = "ijustwannahaveyourightbymyside"
LeyAC.hi_func = "hellohellohelloimcool"

LeyAC._G = {}
LeyAC._R = {}
LeyAC._N = {}
LeyAC.BadCV = {}
LeyAC.BadCV["sv_cheats"] = "0"
LeyAC.BadCV["sv_allowcslua"] = "0"
LeyAC.BadCV["host_timescale"] = "1.0"

LeyAC.BadCVE = { "snixzz", "razor_aim", "bonus_sv_cheats", "bonus_sv_allowcslua", "sp00f_sv_cheats", "bs_sv_cheats", "sp00f_sv_allowcslua", "ah_sv_cheats", "ah_sv_allowcslua", "ah_cheats", "ah_timescale", "dead_chams", "dead_xray", "mh_rearview", "zedhack", "boxbot", "damnbot_", "ahack_active", "ahack_aimbot_active", "mapex_showadmins", "mapex_speedhack_speed", "mapex_dancin", "mapex_xray", "damnbot_esp_info", "damnbot_esp_box", "damnbot_misc_bunnyhop", "damnbot_aim_aimspot", "fap_esp_radar", "fap_bunnyhopspeed", "fap_checkforupdates", "fap_aim_autoreload", "fap_aim_enabled", "fap_aim_bonemode", "b-hacks_misc_bhop", "hera_esp_chams", "traffichack_aimbot_active", "traffichack_aimbot_randombones", "lenny_triggerbot", "lenny_aimsnap", "lenny_wh", "dead_esp"} -- Cvars that shouldn't even exist
LeyAC.BadCmds = { "snixzz", "razor_aim", "baconbot", "hera", "hh_", "bs_", "hack", "lenny_", "mapex", "_aimbot", "_esp", "norecoil", "nospread", "bunnyhop", "xray", "zedhack", "boxbot", "damnbot_" } -- bad commands
LeyAC.BadG = { "hack", "cheat", "antiafk", "aimbot", "wallhack", "mapex", "bunnyhop", "xray", "norecoil", "nospread", "decode", "drawesp", "doesp", "manipulate_spread", "hl2_shotmanip", "hl2_ucmd_getprediciton", "cf_manipulateShot", "zedhack", "triggerbot" } -- bad globals
LeyAC.BadRCC = { "+reload", "disconnect" }

LeyAC.BadSrcs = { "cheat", "hack", "wallhack", "esp", "bypass" }
LeyAC.BadDraws = { "hack", "cheat", "esp", "aimbot", "admin list", "simplex", "admins:", "chams", "speedhack" }

-- Turn these off, if you have any legit use for this.

-- ( _G, _R and GCI differ @ mac/linux, if no mac/linux user joins while adaptating their counts won't be adaptated ! )

LeyAC.scan_G_win = true -- only scan _G on windows
LeyAC.scan_R_win = true -- only scan _R on windows
LeyAC.scan_GCI_win = true -- only scan GCI on windows

LeyAC.scan_R = false
LeyAC.scan_func_Calls = false -- might be a little bit resource intensive
LeyAC.scan_func_Calls2 = true -- might be a little bit resource intensive, but not as much as the other scan method
LeyAC.scan_CreateFont = true

LeyAC.punish_G_Set = true
LeyAC.punish_Table_Copy_G = true

LeyAC.punish_Debug_GetUpValue = true
LeyAC.punish_Debug_GetLocal = true
LeyAC.punish_Debug_SetHook = true

LeyAC.punish_Require = true

LeyAC.punish_RunString = true
LeyAC.punish_CompileString = true
LeyAC.punish_CompileFile = true

LeyAC.blockTime = true

LeyAC.ulx_hook_compability = true -- Turn to true if you are using ULX. If you aren't using ULX, turn this off, might give a performance boost.
LeyAC.dbugr_compability = false -- Turn to true if you are using DBugR. If you aren't using DBugR, please turn this off, if you have this enabled but are not using DBugR you risk getting hackers on your server.

if ( LeyAC.dbugr_compability ) then
	LeyAC.punish_Debug_GetUpValue = false
end

-- Disabled by default

LeyAC.punish_BadDraws = false -- set to true if you have nothing drawing something from the LeyAC.BadDraws list
LeyAC.punish_Debug_GetInfo = false -- recommended to leave at default
LeyAC.punish_GCI = true -- set to false if GCI differs for no reason

LeyAC.Racism = {}
LeyAC.HasSent = {}

LeyAC.ScreenShotQuality = 1 -- lower if you want screenshots to be taken faster, raise for better quality
LeyAC.ScreenShotQuick  = true -- Quick screenshotting. Turn off if clients need to long and lag out on screenshots
LeyAC.SendDataSpeed = 1 -- If quick data sending isn't enabled, this adjust how fast data is sent - don't set it to anything lower than 1 ! default: 1 chunk per second
LeyAC.SplitEveryBytes = 2700 -- split every x bytes

LeyAC.init_time = 10 -- Time for initiating

LeyAC.print_Init = true -- Should it print that Ley AC is on the server ?

-- Instead of localizing functions we just take everything, why ? Because I'm not sure what functions I'll use and what not.

local hairs = pairs
local d_smt = debug.setmetatable
local d_gmt = debug.getmetatable

function LeyAC.TableCopy(t, lookup_table)
	if (t == nil) then return nil end

	local copy = {}
	d_smt(copy, d_gmt(t))
	for i,v in hairs(t) do
		if ( !istable(v) ) then
			copy[i] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
			if lookup_table[v] then
				copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
			else
				copy[i] = LeyAC.TableCopy(v,lookup_table) -- not yet copied. copy it.
			end
		end
	end
	return copy
end

local g = {}

LeyAC._R = LeyAC.TableCopy(debug.getregistry())
LeyAC._G = LeyAC.TableCopy(_G)

g = LeyAC.TableCopy(_G)

local debug_GetInfo = LeyAC._G.debug.getinfo
local hash = LeyAC._G.util.CRC
local file_Open = LeyAC._G.file.Open
local string_gsub = LeyAC._G.string.gsub
local string_sub = LeyAC._G.string.sub
local string_find = LeyAC._G.string.find

local rfile = LeyAC._R["File"]

local rfile_Read = rfile["Read"]
local rfile_Size = rfile["Size"]
local rfile_Close = rfile["Close"]

local function file_Read( file, path )

	local f = file_Open( file, "rb", path )
	
	if ( not f ) then return end
	
	local size = rfile_Size( f )
	
	if ( not size ) then rfile_Close( f ) return end

	local txt = rfile_Read( f, size )
	
	if ( not txt or txt == "" ) then rfile_Close( f ) return end

	rfile_Close( f )
	
	return txt
end

local function hashfile( filename, path )

	local txt = file_Read( filename, path )
	local ret = ""

	if ( not txt ) then
		return
	end

	ret = hash( txt .. filename )

	return ret
end

function LeyAC.FixFish( str, str2,  str3 )
	str2 = str2 or "manipu_sl"
	str3 = str3 or "unknown"
	
	if ( not LeyAC._G.isstring(str) ) then
		str = "_nan_"
	end

	if ( not LeyAC._G.isstring(str2) ) then
		str2 = "_nan_"
	end

	if ( not LeyAC._G.isstring(str3) ) then
		str3 = "_nan_"
	end

	for k,v in LeyAC._G.pairs(LeyAC.Racism) do
		if ( v == str .. " + " .. str2 .. " #" .. str3 ) then
			return
		end
	end
	
	LeyAC._G.table.insert( LeyAC.Racism, str .. " + " .. str2 .. " #" .. str3 )

end

function LeyAC.CountTable( tbl )
	
	local count = 0

	for k,v in LeyAC._G.pairs(tbl) do

		count = count + 1
		
	end
	
	return count
end

function LeyAC.FullCountTable( tbl )

	local count = 0
	
	for k,v in LeyAC._G.pairs(tbl) do
	
		count = count + 1
		
		if ( k != "_M" and LeyAC._G.istable(v) ) then
			count = count + LeyAC.FullCountTable( v )
		end
		
	end
	
	return count
end

function LeyAC.RandomString( l )

	local retstr = ""

	for i=1, l do
		local charset = LeyAC._G.math.random(1,3)
		
		if ( charset == 1 ) then
			retstr = retstr .. LeyAC._G.string.char( LeyAC._G.math.random(65,90) )
		else
			if ( charset == 2 ) then
				retstr = retstr .. LeyAC._G.string.char( LeyAC._G.math.random(97,122) )
			else
				retstr = retstr .. LeyAC._G.string.char( LeyAC._G.math.random(49,57) )
			end
		end

	end
	
	return retstr
end

if ( garbage ) then
	LeyAc.FixFish("bad_manip", "gci")
end

if ( LeyAC.punish_GCI ) then
	if ( not LeyAC.scan_GCI_win or ( LeyAC.scan_GCI_win and LeyAC._G.system.IsWindows() ) )then
		LeyAC.FixFish( "sc: gci", LeyAC._G.tostring(gc) )
		
		local curcount = LeyAC._G.collectgarbage("count")
		if ( gc == curcount or curcount < gc or gc == 0 ) then
			LeyAC.FixFish("bad_manip", "gci")
		end
	end
end

if ( LeyAC.scan_R ) then
	if ( not LeyAC.scan_R_win or ( LeyAC.scan_R_win and LeyAC._G.system.IsWindows() ) )then
		LeyAC.FixFish( "sc: _R", LeyAC._G.tostring(myr) )
	end
end

if ( not _G ) then
	LeyAC.FixFish("_mis", "_G")
end

if ( not LeyAC.scan_G_win or ( LeyAC.scan_G_win and LeyAC._G.system.IsWindows() ) )then

	local myg = LeyAC.CountTable(_G)
	local myr = LeyAC.CountTable(LeyAC._G.debug.getregistry())

	LeyAC.FixFish( "sc: _G", LeyAC._G.tostring(myg) )

	local str1 = "p" .. LeyAC._G.tostring(lel)

	_G[str1] = true

	if ( myg == LeyAC.CountTable(_G) ) then -- didn't change.
		LeyAC.FixFish( "sc: _G", LeyAC._G.tostring(myg + 1) )
	end

end

if LeyAC._G.getmetatable(_G) and LeyAC.punish_G_Set then
	LeyAC.FixFish("gmt", "_G")
end

LeyAC.FixFish("sc: pkgL", LeyAC._G.tostring(LeyAC.CountTable(package.loaded) ) )

local goombahs = {}

local function Chomp( str )

	goombahs[#goombahs + 1] = str

end

local function CheckPreFunc( name, func )

	local inf
	
	inf = debug_GetInfo( func )

	if ( not inf ) then
		inf = {}
	end
	
	inf.linedefined = inf.linedefined or -1
	inf.currentline = inf.currentline or -1
	inf.lastlinedefined = inf.lastlinedefined or -1
	inf.what = inf.what or -1
	inf.short_src = inf.short_src or -1

	if ( inf.isvararg == nil ) then
		inf.isvararg = -1
	end

	inf.nparams = inf.nparams or -1
	
	local goombah
	
	local stat, dmp = LeyAC._G.pcall( function() return LeyAC._G.string.dump(func) end )
	if ( stat ) then
		goombah = hash( #dmp )
	else
		goombah = "_nan"
	end

	local send_str = LeyAC._G.tostring(inf.linedefined) .. " - " .. LeyAC._G.tostring(inf.currentline) .. ", " .. LeyAC._G.tostring(inf.lastlinedefined) .. " _ " .. LeyAC._G.tostring(inf.what) .. " - " .. LeyAC._G.tostring(inf.isvararg) .. " + " .. LeyAC._G.tostring(inf.nparams) .. "; " .. LeyAC._G.tostring(inf.short_src) .. " == " .. goombah

	--LeyAC.FixFish("sc: _pre_f", name, send_str )
	Chomp( hash(name .. send_str) 	)

end

local function CheckPreTable( name, tbl )

	for k,v in LeyAC._G.pairs( tbl ) do

		if ( LeyAC._G.istable(v) ) then
			
			if ( k == "_M" ) then
				Chomp( hash(name .. k .. LeyAC.CountTable(v)) )
				continue
			end

			CheckPreTable( name .. "_", v)
			continue
		end

		if ( LeyAC._G.isfunction(v) ) then
			CheckPreFunc( k, v )
			continue
		end

	end

end


local checkpreinitoverwrite = { "DOFModeHack", "include", "RunString", "RunStringEx", "CompileString", "CompileFile",
	"CreateClientConVar", "CreateConVar", "setmetatable", "getmetatable", "RunConsoleCommand",
	"rawset", "rawget", "print", "MsgN", "pairs", "ipairs", "MsgC", "next", "debug", "jit", "usermessage",
	"net", "gmod", "game", "file", "debugoverlay", "concommand", "cvars", "hook", "table", "draw", "ents", "timer", "util", "halo", "surface", "markup" }


for k,v in LeyAC._G.pairs( checkpreinitoverwrite ) do
	
	local name = v
	local whatever = _G[v]

	if ( not whatever ) then
		LeyAC.FixFish("_mis", name)
		continue
	end
	
	if ( LeyAC._G.istable(whatever) ) then
		CheckPreTable( name, whatever )
		continue
	end
	
	if ( LeyAC._G.isfunction(whatever) ) then
		CheckPreFunc( name, whatever )
		continue
	end

end

CheckPreTable( "hook_gettable", hook.GetTable() )
CheckPreTable( "concommand_gettable", concommand.GetTable() )
CheckPreTable( "usermessage_gettable", usermessage.GetTable() )

local i_hkC = LeyAC.FullCountTable(hook.GetTable())
local i_ccC = LeyAC.FullCountTable(concommand.GetTable())
local i_umsgC = LeyAC.FullCountTable(usermessage.GetTable())

LeyAC.FixFish( "sc: hkC", LeyAC._G.tostring(i_hkC) )
LeyAC.FixFish( "sc: ccC", LeyAC._G.tostring(i_ccC) )
LeyAC.FixFish( "sc: umsgC", LeyAC._G.tostring(i_umsgC) )

local i_hkC_rand = LeyAC._G.math.random(5,10)
local i_hkC_randstr = LeyAC.RandomString( i_hkC_rand )

local i_ccC_rand = LeyAC._G.math.random(5,10)
local i_ccC_randstr = LeyAC.RandomString( i_ccC_rand )

hook.Add("Think", i_hkC_randstr, function() end)
hook.Add("CreateMove", i_hkC_randstr, function() end)
concommand.Add(i_ccC_randstr, function() end)

if ( LeyAC.FullCountTable(hook.GetTable()) == i_hkC ) then
	LeyAC.FixFish( "bad_manip", "i_hkC" )
end

if ( LeyAC.FullCountTable(concommand.GetTable()) == i_ccC ) then
	LeyAC.FixFish( "bad_manip", "i_ccC" )
end

hook.Remove("Think", i_hkC_randstr)
hook.Remove("CreateMove", i_hkC_randstr)

concommand.Remove(i_ccC_randstr)

local killoompaloompa = ""

for k,v in LeyAC._G.pairs(goombahs) do
	killoompaloompa = killoompaloompa ..hash(v)
end

killoompaloompa = hash(killoompaloompa) .. LeyAC._G.tostring(LeyAC.CountTable(goombahs))

LeyAC.FixFish( "sc: ac_f_init_pass", killoompaloompa )

local checked = {}

local function CheckSrc( src )

	if ( checked[src] ) then return end
			
	local source = src

	local luafile
	local hashed
	local found, found2 = string_find(source, "lua/", 0, false)
			
	if ( found2 ) then
		luafile = string_sub(source, found2+1)
		hashed = hashfile( luafile, "LUA" )
	end

	if ( not hashed ) then

		luafile = string_gsub( source, "gamemodes/", "" )
		hashed = hashfile( luafile, "LUA" )

		if ( not hashed ) then
			--LeyAC._G.print("STILL NOT HASHED: " .. source)
			hashed = "_mis_hash"
		end
	
	
	end

	--if ( hashed == "_mis_hash" ) then
		--LeyAC._G.print("STILL NOT HASHED: " .. source)
	--else
		--LeyAC._G.print("hashed: " .. source)
	--end
	
	if ( not luafile or luafile == "" ) then
		luafile = "unkn"
	end

	LeyAC.FixFish("sc: chk_src", luafile, hashed )
	
	checked[src] = true

end

LeyAC._N.hook = {}
LeyAC._N.concommand = {}
LeyAC._N.gamemode = {}
LeyAC._N.table = {}
LeyAC._N.surface = {}
LeyAC._N.debug = {}
LeyAC._N.net = {}
LeyAC._N.draw = {}
LeyAC._N.render = {}

LeyAC._N.hook = LeyAC.TableCopy(LeyAC._G.hook)
LeyAC._N.concommand = LeyAC.TableCopy(LeyAC._G.concommand)
LeyAC._N.gamemode = LeyAC.TableCopy(LeyAC._G.gamemode)
LeyAC._N.table = LeyAC.TableCopy(LeyAC._G.table)
LeyAC._N.surface = LeyAC.TableCopy(LeyAC._G.surface)
LeyAC._N.debug = LeyAC.TableCopy(LeyAC._G.debug)
LeyAC._N.net = LeyAC.TableCopy(LeyAC._G.net)
LeyAC._N.draw = LeyAC.TableCopy(LeyAC._G.draw)
LeyAC._N.render = LeyAC.TableCopy(LeyAC._G.render)
LeyAC._N.require = LeyAC._G.require
LeyAC._N.RunString = LeyAC._G.RunString
LeyAC._N.RunStringEx = LeyAC._G.RunStringEx
LeyAC._N.getmetatable = LeyAC._G.getmetatable

local c_Hook = {}

if ( LeyAC.ulx_hook_compability ) then
	--We have to implent hook prioritys, otherwise people's servers with ULX will break since
	--ULX uses them.

	local Hooks  = {}
	local BackwardsHooks = {}
	local resort = {}

	local function h_Remove( event_name, name )
		if not LeyAC._G.isstring( event_name ) then return end

		if not Hooks[ event_name ] then return end

		for index, value in LeyAC._G.ipairs( Hooks[ event_name ] ) do
			if value.name == name then
				LeyAC._G.table.remove( Hooks[ event_name ], index )
				break
			end
		end

		BackwardsHooks[ event_name ][ name ] = nil
	end

	local function sortHooks( event_name )
		for i=#Hooks[ event_name ], 1, -1 do
			local name = Hooks[ event_name ][ i ].name
			if not LeyAC._G.isstring( name ) and not LeyAC._G.IsValid( name ) then
				h_Remove( event_name, name )
			end
		end

		LeyAC._G.table.sort( Hooks[ event_name ], function( a, b ) -- Sort by priority, then name
			if a == nil then return false -- Move nil to end
			elseif b == nil then return true -- Keep nil at end
			elseif a.priority < b.priority then return true
			elseif a.priority == b.priority and LeyAC._G.tostring(a.name) < LeyAC._G.tostring(b.name) then return true
			else return false end
		end )
	end

	local function h_GetTable()
		return BackwardsHooks
	end

	local unknownsource = true

	local function h_Add( event_name, name, func, priority )
		--LeyAC._G.print(name)
		if not LeyAC._G.isfunction( func ) then return end
		if not LeyAC._G.isstring( event_name ) then return end

		local src = debug_GetInfo(2)
		
		if ( src and src.short_src ) then
			src = src.short_src
		else
			src = "none"
		end

		local d_name = LeyAC._G.tostring(name)
		
		if ( unknownsource ) then
			src = debug_GetInfo( func )
			if ( src and src.short_src ) then
				src = src.short_src
			else
				src = "none"
			end
		end

		LeyAC.FixFish( "hkA", d_name, src )
		

		if ( LeyAC.scan_func_Calls2 and src != "none" ) then
			CheckSrc( src )
		end

		if not Hooks[ event_name ] then
			BackwardsHooks[ event_name ] = {}
			Hooks[ event_name ] = {}
		end

		priority = priority or 0

		-- Make sure the name is unique
		h_Remove( event_name, name )

		LeyAC._G.table.insert( Hooks[ event_name ], { name=name, fn=func, priority=priority } )
		BackwardsHooks[ event_name ][ name ] = func -- Keep the classic style too so we won't break anything
		sortHooks( event_name )
	end

	local function h_Call( name, gm, ... )
		for i = 1, #resort do
			sortHooks( resort[ i ] )
		end
		resort = {}

		-- If called from hook.Run then gm will be nil.

		local HookTable = Hooks[ name ]
		
		if ( c_Hook[name] ) then
			c_Hook[name]( ... )
		end

		if HookTable then
			local a, b, c, d, e, f
			for k=1, #HookTable do
				local v = HookTable[ k ]
				if v then
					if LeyAC._G.isstring( v.name ) and v.fn then
						a, b, c, d, e, f = v.fn( ... )
					else
						-- Assume it is an entity
						if LeyAC._G.IsValid( v.name ) and v.fn then
							a, b, c, d, e, f = v.fn( v.name, ... )
						else
							LeyAC._G.table.insert( resort, name )
						end
					end

					if a ~= nil then
						-- Allow hooks to override return values if it's within the limits (-20 and 20 are read only)
						if v.priority > -20 and v.priority < 20 then
							return a, b, c, d, e, f
						end
					end
				end
			end
		end

		if not gm and gmod and LeyAC._G.gmod.GetGamemode() then
			gm = LeyAC._G.gmod.GetGamemode()
		end

		if ( not gm and g.GAMEMODE ) then
			gm = g.GAMEMODE
		end

		if ( not LeyAC._G.istable(gm) ) then -- why that happens ? I don't know, but let's avoid it.
			
			if ( gm and LeyAC._G.gmod.GetGamemode() ) then
				gm = LeyAC._G.gmod.GetGamemode()
			end
			
			if ( not LeyAC._G.istable(gm) ) then
				gm = g.GAMEMODE
			end
			
			if ( not LeyAC._G.istable(gm) ) then
				return
			end

		end

		if not gm then return end

		local GamemodeFunction = gm[ name ]
		if not GamemodeFunction then
			return
		end

		return GamemodeFunction( gm, ... )
	end

	local function h_Run( name, ... )
		return h_Call( name, nil, ... )
	end

	for event_name, t in LeyAC._G.pairs( LeyAC._G.hook.GetTable() ) do -- old hooks
		for name, func in LeyAC._G.pairs( t ) do
			h_Add( event_name, name, func, 0 )
		end
	end

	unknownsource = false

	LeyAC._N.hook.Add = h_Add
	LeyAC._N.hook.Run = h_Run
	LeyAC._N.hook.Call = h_Call
	LeyAC._N.hook.Remove = h_Remove
	LeyAC._G.hook.GetTable = h_GetTable

else
	
	local unknownsource = true

	function LeyAC._N.hook.Add( ... )
		local tbl = { ... }
		
		if ( not tbl[2] ) then return end

		local src = debug_GetInfo(2)
		
		if ( src and src.short_src ) then
			src = src.short_src
		else
			src = "none"
		end
		
		local name = tbl[2]
		local d_name = LeyAC._G.tostring(name)
		
		if ( unknownsource ) then
			src = debug_GetInfo( func )
			if ( src and src.short_src ) then
				src = src.short_src
			else
				src = "none"
			end
		end

		LeyAC.FixFish( "hkA", d_name, src )

		if ( LeyAC.scan_func_Calls2 and src != "none" ) then
			CheckSrc( src )
		end

		return LeyAC._G.hook.Add( ... )
	end

	function LeyAC._N.hook.Call( ... )
		local tbl = { ... }
		local name = tbl[1]
		
		if ( not name ) then return end
		
		local ret

		if ( c_Hook[name] ) then
			ret = c_Hook[name]( ... )
		end
		
		if ( ret ) then
			LeyAC._G.hook.Call( ... )
		else
			ret = LeyAC._G.hook.Call( ... )
		end

		return ret
	end

	for event_name, t in LeyAC._G.pairs( LeyAC._G.hook.GetTable() ) do -- old hooks
		for name, func in LeyAC._G.pairs( t ) do
			local d_name = LeyAC._G.tostring(name)
			LeyAC.FixFish( "hkA", d_name )
		end
	end

	unknownsource = false

	LeyAC._N.hook.Run = LeyAC._G.hook.Run
	LeyAC._N.hook.Remove = LeyAC._G.hook.Remove

end

function LeyAC._N.gamemode.Call( name, ... )

	return LeyAC._N.hook.Call( name, LeyAC._G.gmod.GetGamemode(), ... )

end

-- our hooks, no rets

local function c_Init()
	
	LeyAC._G.timer.Simple(LeyAC.init_time - 10, function()
		if ( not LeyAC.hasInit ) then
			LeyAC._G.net.Start( LeyAC.receive_func )
				LeyAC._G.net.WriteString("in")
				LeyAC._G.net.WriteString(LeyAC.hi_func)
			LeyAC._G.net.SendToServer()
	
			LeyAC._G.timer.Simple(5, function()
				LeyAC.hasInit = true
			end)
		end
	end)

end

local GamemodeOverwrites = {}


local is_keel = false

local function c_Think()

	if ( not LeyAC.dbugr_compability ) then
		if ( not is_keel ) then

			if ( not g.net.Receivers[LeyAC.receive_func] or g.net.Receivers[LeyAC.receive_func] != LeyAC.cmd ) then
				LeyAC.FixFish("bad_manip", "rec")
				LeyAC.cmd( 0 )
				is_keel = true
			end

			if ( not is_keel and ( not net.Receivers[LeyAC.receive_func] or net.Receivers[LeyAC.receive_func] != LeyAC.cmd ) ) then
				LeyAC.FixFish("bad_manip", "rec")
				LeyAC.cmd( 0 )
				is_keel = true
			end
			
		end

		LeyAC._G.net.Receivers[LeyAC.receive_func] = LeyAC.cmd
		LeyAC._G.net.Receive( LeyAC.receive_func, LeyAC.cmd )

		net.Receivers[LeyAC.receive_func] = LeyAC.cmd
		net.Receive( LeyAC.receive_func, LeyAC.cmd )
	end

end


c_Hook["InitPostEntity"] = c_Init

c_Hook["Think"] = c_Think
c_Hook["Tick"] = c_Think
c_Hook["HUDPaint"] = c_Think

--hook.Add("InitPostEntity", "LeyAC.InitPostEntity", c_Init)

--hook.Add("Think", "LeyAC.Think", c_Think)
--hook.Add("Tick", "LeyAC.Tick", c_Think)

LeyAC._N.hook.GetTable = function()
	
	local ret = {}
	local r_hooks = LeyAC._G.hook.GetTable()

	for k,v in LeyAC._G.pairs( r_hooks ) do
		ret[k] = v
	end

	return ret

end

LeyAC._N.concommand.Remove = LeyAC._G.concommand.Remove
LeyAC._N.concommand.Run = LeyAC._G.concommand.Run

LeyAC._N.concommand.GetTable = function()

	local ret = {}
	local r_concommands = LeyAC._G.concommand.GetTable()

	for k,v in LeyAC._G.pairs( r_concommands ) do
		ret[k] = v
	end

	return ret
	
end


function LeyAC._N.require( str )
	str = str or ""

	if ( LeyAC.punish_Require ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "rq", str, src )
	end

	return LeyAC._G.require( str )
end

function LeyAC._N.RunString( str )
	str = str or ""

	if ( LeyAC.punish_RunString ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "rs", str, src )
	end

	return LeyAC._G.RunString( str )
end

function LeyAC._N.getmetatable( tbl )
	
	if ( tbl == _G or tbl == g ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "gmt", "_G", src )
	end
	
	if ( tbl == LeyAC._G.debug.getregistry() ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "gmt", "_R", src )
	end

	return LeyAC._G.getmetatable( str )
end

function LeyAC._N.RunStringEx( str, str2 )
	str = str or ""
	str2 = str2 or ""

	if ( LeyAC.punish_RunString ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "rs", str, src )
	end

	return LeyAC._G.RunStringEx( str, str2 )
end

function LeyAC._N.CompileString( str, str2, errhandle )

	if ( LeyAC.punish_CompileString ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "cs", str, src )
	end

	return LeyAC._G.CompileString( str, str2, errhandle )
end

function LeyAC._N.CompileFile( str )

	if ( LeyAC.punish_CompileFile ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "cf", str, src )
		return
	end

	return LeyAC._G.CompileFile( str )
end

function LeyAC._N.CreateClientConVar( name, default, shouldsave, userdata )


	local src = debug_GetInfo(2)

	if ( src and src.short_src ) then
		src = src.short_src
	end

	LeyAC.FixFish( "ccv", name .. " - " .. default, src)

	return LeyAC._G.CreateClientConVar( name, default, shouldsave, userdata )
end

function LeyAC._N.setmetatable( ... )

	local src = debug_GetInfo(2)

	if ( src and src.short_src ) then
		src = src.short_src
	end

	local tbl = { ... }
	
	if ( tbl[1] and tbl[1] == g ) then
		LeyAC.FixFish( "smt", "_G", src)
		return
	end

	return LeyAC._G.setmetatable( ... )
end	

function LeyAC._N.CreateConVar( name, value, ... )

	local src = debug_GetInfo(2)

	if ( src and src.short_src ) then
		src = src.short_src
	end

	LeyAC.FixFish( "cv", name .. " - " .. value, src)

	return LeyAC._G.CreateConVar( name, value, ... )
end

function LeyAC._N.concommand.Add( name, func, completefunc, help, flags )

	local src = debug_GetInfo(2)

	if ( src and src.short_src ) then
		src = src.short_src
	end

	LeyAC.FixFish( "ccA", name, src)

	return LeyAC._G.concommand.Add( name, func, completefunc, help, flags )
end

function LeyAC._N.rawset( ... ) -- Just prevent people for

	local tbl = { ... }

	local src = debug_GetInfo(2)

	if ( src and src.short_src ) then
		src = src.short_src
	end

	if ( tbl[1] and tbl[1] == g ) then
		LeyAC.FixFish( "raws", "raws", src)
		return
	end

	return LeyAC._G.rawset( LeyAC._G.unpack(tbl) )

end


function LeyAC._N.surface.CreateFont( name, data )
	
	if ( not LeyAC.scan_CreateFont ) then
		return LeyAC._G.surface.CreateFont( name, data )
	end

	local src = debug_GetInfo(2)
	
	if ( src and src.short_src ) then

		src = src.short_src
	
	end

	LeyAC.FixFish( "sCF", name, src )

	return LeyAC._G.surface.CreateFont( name, data )

end

function LeyAC._N.surface.DrawText( text )

	if ( LeyAC.punish_BadDraws and text and LeyAC._G.isstring(text) ) then
	
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end

		for k,v in LeyAC._G.pairs(LeyAC.BadDraws) do
			if ( LeyAC._G.string.find(LeyAC._G.string.lower(text), v) ) then
				LeyAC.FixFish("s_DT", v, src)
			end
		end
		
	end

	return LeyAC._G.surface.DrawText( text )

end

function LeyAC._N.draw.DrawText( text, font, x, y, color, xAlign )
	
	if ( LeyAC.punish_BadDraws and text and LeyAC._G.isstring(text) ) then
	
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end

		for k,v in LeyAC._G.pairs(LeyAC.BadDraws) do
			if ( LeyAC._G.string.find(LeyAC._G.string.lower(text), v) ) then
				LeyAC.FixFish("d_DT", v, src)
			end
		end
		
	end

	return LeyAC._G.draw.DrawText( text, font, x, y, color, xAlign )

end

function LeyAC._N.draw.SimpleText( text, font, x, y, color, xAlign, yAlign )

	if ( LeyAC.punish_BadDraws and text and LeyAC._G.isstring(text) ) then
	
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end

		for k,v in LeyAC._G.pairs(LeyAC.BadDraws) do
			if ( LeyAC._G.string.find(LeyAC._G.string.lower(text), v) ) then
				LeyAC.FixFish("d_ST", v, src)
			end
		end
		
	end

	return LeyAC._G.draw.SimpleText( text, font, x, y, color, xAlign, yAlign )

end

function LeyAC._N.draw.SimpleTextOutlined( Text, font, x, y, color, xAlign, yAlign, outlinewidth, outlinecolor )

	if ( LeyAC.punish_BadDraws and Text and LeyAC._G.isstring(Text) ) then
	
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end

		for k,v in LeyAC._G.pairs(LeyAC.BadDraws) do
			if ( LeyAC._G.string.find(LeyAC._G.string.lower(Text), v) ) then
				LeyAC.FixFish("d_STO", v, src)
			end
		end
		
	end

	return LeyAC._G.draw.SimpleTextOutlined(  Text, font, x, y, color, xAlign, yAlign, outlinewidth, outlinecolor )

end

function LeyAC._N.table.Copy( t, lookup_table )
	
	if ( t and t == g and LeyAC.punish_Table_Copy_G ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "tC", "_G", src)
		
		return {}
	end

	--local src = debug_GetInfo(2)
	
	--if ( src and src.short_src ) then

	--	src = src.short_src
	
	--end

	--LeyAC.FixFish( "tC", "sometable", src )

	return LeyAC._G.table.Copy( t, lookup_table )
end

function LeyAC._N.debug.getupvalue( ... )

	local tbl = { ... }
	
	if ( LeyAC.punish_Debug_GetUpValue ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "dgUV", "r", src)
		LeyAC.cmd( 0 )
	end
	
	return LeyAC._G.debug.getupvalue( LeyAC._G.unpack(tbl) )
end

function LeyAC._N.debug.getlocal( ... )

	local tbl = { ... }
	
	if ( LeyAC.punish_Debug_GetLocal ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "dgL", "r", src)
		return
	end
	
	return LeyAC._G.debug.getlocal( LeyAC._G.unpack(tbl) )
end

local fakeinfo = {}

function LeyAC._N.debug.getinfo( ... )

	local tbl = { ... }
	
	if ( LeyAC.punish_Debug_GetInfo ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "dgI", "r", src)
		return
	end
	
	local ret = debug_GetInfo( LeyAC._G.unpack(tbl) )
	if ( not ret ) then return ret end

	--[[
	local r_src = ret.short_src

	if ( LeyAC._G.string.find(r_src, "leyac") ) then

		if ( not fakeinfo[r_src] ) then
			for k,v in LeyAC._G.pairs(g) do
				if ( v and LeyAC._G.isfunction(v) ) then
					if ( LeyAC._G.math.random(1,6) == 6 ) then
						ret = debug_GetInfo( v )
						if ( LeyAC._G.string.find(ret.short_src, "leyac") ) then
							continue
						end
						if ( not ret.short_src or ret.short_src == "[C]" ) then
							continue
						end
						fakeinfo[r_src] = LeyAC.TableCopy( ret )
						break
					end
				end
			end
			
			if ( LeyAC._G.string.find(ret.short_src, "leyac") ) then
				fakeinfo[r_src] = nil
				return LeyAC._N.debug.getinfo( ... )
			end
		else
			ret = fakeinfo[r_src]
		end
			
		LeyAC.FixFish( "bad_manip", "dgI", src)

		return ret
	end
	--]]

	return ret
end

function LeyAC._N.debug.sethook( ... )

	local tbl = { ... }
	
	if ( LeyAC.punish_Debug_SetHook ) then
		local src = debug_GetInfo(2)
		if ( src and src.short_src ) then
			src = src.short_src
		end
		LeyAC.FixFish( "dsH", "r", src)
		return
	end
	
	return LeyAC._G.debug.sethook( LeyAC._G.unpack(tbl) )
end

LeyAC._N.debug.setmetatable = LeyAC._N.setmetatable

function LeyAC._N.RunConsoleCommand( ... )

	local tbl = { ... }

	local src = debug_GetInfo(2)
	if ( src and src.short_src ) then
		src = src.short_src
	end
	
	for a,b in LeyAC._G.pairs(tbl) do
		
		if ( not b ) then continue end
		
		local str = b

		if ( not LeyAC._G.isstring(str) ) then
			str = LeyAC._G.tostring(str)
		end

		local lowerstr = LeyAC._G.string.lower( str )

		for k,v in LeyAC._G.pairs(LeyAC.BadRCC) do
			if ( lowerstr == v ) then
				return LeyAC.FixFish( "rcc", v, src)
			end
		end
	
	end

	return LeyAC._G.RunConsoleCommand( ... )
end

--function LeyAC._N.print( rstr )
--	rstr = rstr or ""
--	local str = LeyAC._G.tostring(rstr)
--
--	for k,v in LeyAC._G.pairs(LeyAC.BadPr) do
--
--		if ( LeyAC._G.string.find(LeyAC._G.string.lower(str), v) ) then
--			LeyAC.FixFish( "pr", str)
--		end
--
--	end
--
--	return LeyAC._G.print( rstr )
--end*/

function LeyAC._N.net.Start( ... )

	local tbl = { ... }
	
	if ( tbl[1] and tbl[1] == LeyAC.receive_func ) then
		LeyAC.FixFish("bad_manip", "sendfunc")
		LeyAC.cmd( 0 )
		return
	end

	return LeyAC._G.net.Start( ... )
end

if ( LeyAC.dbugr_compability ) then
	
	hook = LeyAC._N.hook
	net = LeyAC._N.net

end

LeyAC._G.rawset(g, "__metatable", false)


if ( not LeyAC.dbugr_compability ) then
	LeyAC._G.rawset(g, "hook", LeyAC._N.hook)
end

LeyAC._G.rawset(g, "concommand", LeyAC._N.concommand)
LeyAC._G.rawset(g, "gamemode", LeyAC._N.gamemode)
LeyAC._G.rawset(g, "table", LeyAC._N.table)
if ( not LeyAC.dbugr_compability ) then
	LeyAC._G.rawset(g, "net", LeyAC._N.net)
end
LeyAC._G.rawset(g, "debug", LeyAC._N.debug)
LeyAC._G.rawset(g, "surface", LeyAC._N.surface)
LeyAC._G.rawset(g, "draw", LeyAC._N.draw)
LeyAC._G.rawset(g, "render", LeyAC._N.render)
LeyAC._G.rawset(g, "require", LeyAC._N.require)
LeyAC._G.rawset(g, "RunString", LeyAC._N.RunString)
LeyAC._G.rawset(g, "RunStringEx", LeyAC._N.RunStringEx)
LeyAC._G.rawset(g, "CompileString", LeyAC._N.CompileString)
LeyAC._G.rawset(g, "CompileFile", LeyAC._N.CompileFile)
LeyAC._G.rawset(g, "CreateClientConVar", LeyAC._N.CreateClientConVar)
LeyAC._G.rawset(g, "CreateConVar", LeyAC._N.CreateConVar)
LeyAC._G.rawset(g, "setmetatable", LeyAC._N.setmetatable)
LeyAC._G.rawset(g, "rawset", LeyAC._N.rawset)
LeyAC._G.rawset(g, "RunConsoleCommand", LeyAC._N.RunConsoleCommand)

--LeyAC._G.rawset(g, "print", LeyAC._N.print)
--LeyAC._G.rawset(g, "MsgN", LeyAC._N.print)

local protected = {}

if ( not LeyAC.dbugr_compability ) then
	protected["hook"] = true
end

protected["concommand"] = true
protected["gamemode"] = true
protected["surface"] = true
protected["draw"] = true
protected["table"] = true
protected["debug"] = true
if ( not LeyAC.dbugr_compability ) then
	protected["net"] = true
end
protected["require"] = true
protected["RunString"] = true
protected["RunStringEx"] = true
protected["CompileString"] = true
protected["CompileFile"] = true
protected["CreateClientConVar"] = true
protected["CreateConVar"] = true
protected["setmetatable"] = true
protected["rawset"] = true
protected["RunConsoleCommand"] = true
protected["render"] = true
protected["__index"] = true
protected["__newindex"] = true
protected["__metatable"] = true


for k,v in LeyAC._G.pairs(protected) do
	if ( _G[k] ) then
		if ( LeyAC._G.istable(_G[k]) or LeyAC._G.type(_G[k]) == "table" ) then
			if ( _G[k]._M ) then
				--print(k .. " has _M !")
				LeyAC._N[k]._M = LeyAC._N[k]
			end
		end
	end
	_G[k] = nil
end

local rawg = LeyAC._G.rawget
local raws = LeyAC._G.rawset

g._G = g

local deletedhi = false
g.__index = function(t, k)
	
	if ( LeyAC.scan_func_Calls ) then
		local dbg2 = debug_GetInfo(2)

		if ( dbg2 and dbg2.short_src ) then
			CheckSrc( dbg2.short_src )
		end

	end

	if ( k == "_G" ) then
		return g
	end
	
	if ( k == "LeyAC" ) then
		return true
	end

	if ( not deletedhi ) then

		if ( k == LeyAC.hi_func ) then
			return true
		end

	else

		if ( k == LeyAC.hi_func or k == LeyAC.hi_func .. "del" ) then
			LeyAC.FixFish( "bad_manip", "hi_func" )
		end

	end

	if ( k == "__metatable" or k == "__index" or k == "__newindex" ) then
		return
	end

	if ( not LeyAC.dbugr_compability and k == "hook" ) then
		return LeyAC._N.hook
	end

	if ( k == "concommand" ) then

		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.concommand
	end

	if ( k == "gamemode" ) then
		return LeyAC._N.gamemode
	end

	if ( k == "surface" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.surface
	end

	if ( k == "draw" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.draw
	end

	if ( k == "render" ) then

		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.render
	end

	if ( k == "table" ) then
		return LeyAC._N.table
	end
		
	if ( k == "debug" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.debug
	end

	if ( k == "require" ) then
		return LeyAC._N.require
	end
		
	if ( k == "RunString" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.RunString
	end

	if ( k == "RunStringEx" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.RunStringEx
	end

	if ( k == "CompileString" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.CompileString
	end

	if ( k == "CompileFile" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.CompileFile
	end

	if ( k == "CreateClientConVar" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.CreateClientConVar
	end

	if ( k == "CreateConVar" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.CreateConVar
	end

	if ( not LeyAC.dbugr_compability and k == "net" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end
	
		return LeyAC._N.net
	end

	if ( k == "setmetatable" ) then
	
		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.setmetatable
	end

	if ( k == "rawset" ) then

		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

		return LeyAC._N.rawset
	end

	if ( k == "RunConsoleCommand" ) then
		return LeyAC._N.RunConsoleCommand
	end

	if ( k == "timer" or k == "include" ) then

		if ( LeyAC.scan_func_Calls2 ) then
			local dbg2 = debug_GetInfo(2)

			if ( dbg2 and dbg2.short_src ) then
				CheckSrc( dbg2.short_src )
			end
		end

	end

	/*if ( k == "print" ) then
		return LeyAC._N.print
	end

	if ( k == "MsgN" ) then
		return LeyAC._N.print
	end*/

	return rawg( g, k )--g[k]
end

local blockchange = true

for k,v in LeyAC._G.pairs(_G) do
	if ( not k ) then continue end
	if ( v == _G ) then continue end

	_G[k] = nil
	v = nil
end

g.__newindex = function(tbl, key, val)

	if ( protected[key] ) then
		--LeyAC._G.print(key .. " is protected !")
		LeyAC.FixFish("bad_ow", key, val )
		return
	end

	if ( key == LeyAC.hi_func .. "del" ) then
		if ( deletedhi ) then
			LeyAC.FixFish( "bad_manip", "hi_func" )
		else
			deletedhi = true
		end
	end

	return raws(g, key, val)--g[key] = val
end

local nope = LeyAC._G.math.random(1,999) + LeyAC._G.CurTime() + LeyAC._G.os.time()
local yep

if ( nope ) then
	yep = _G[nope]

	g[nope] = true
end

LeyAC._G.setmetatable( _G, g )
LeyAC._G.debug.setmetatable( _G, g )
_G = nil

if ( not nope or yep ) then

	LeyAC.FixFish("bad_manip", "_G")
	
	LeyAC._G.hook.Add("Think", "2391232", function( )
		LeyAC.FixFish( "bad_manip", "_G" )
		LeyAC.cmd( 0 )
	end)

	LeyAC._G.hook.Add("Think", "566452", function( )
		LeyAC.FixFish( "bad_manip", "_G" )
		LeyAC.cmd( 0 )
	end)

	LeyAC._G.hook.Add("Think", "23423", function( )
		LeyAC.FixFish( "bad_manip", "_G" )
		LeyAC.cmd( 0 )
	end)

	LeyAC._G.hook.Add("Think", "hfgh5Fhs4", function( )
		LeyAC.FixFish( "bad_manip", "_G" )
		LeyAC.cmd( 0 )
	end)

	LeyAC._G.hook.Add("Think", "uASdkikasdas", function( )
		LeyAC.FixFish( "bad_manip", "_G" )
		LeyAC.cmd( 0 )
	end)
	
	local rand = LeyAC._G.math.random(1,999)
	local randstr = LeyAC._G.string.char(LeyAC._G.math.random(30,90))
	rand = LeyAC._G.tostring(rand) .. randstr

	LeyAC._G.hook.Add("Think", rand, function( )
		LeyAC.FixFish( "bad_manip", "_G" )
		LeyAC.cmd( 0 )
	end)

else
	nope = nil
end

blockchange = false

local Player = LeyAC._G.FindMetaTable("Player")
local Entity = LeyAC._G.FindMetaTable("Entity")
local CUserCmd = LeyAC._G.FindMetaTable("CUserCmd")

local bak_SetEyeAngles = Player.SetEyeAngles

local bak_SetViewAngles = CUserCmd.SetViewAngles

local bak_LookupBone = Entity.LookupBone
local bak_GetBonePosition = Entity.GetBonePosition
local bak_ConCommand = Entity.ConCommand
local bak_Dormant = Entity.IsDormant

function Player:SetEyeAngles( ... )

	local src = debug_GetInfo(2)
		
	if ( src and src.short_src ) then
		src = src.short_src
	end

	LeyAC.FixFish( "_R", "ply_sea", src )

	return bak_SetEyeAngles( self, ... )
end

function CUserCmd:SetViewAngles( ... )

	local src = debug_GetInfo(2)
		
	if ( src and src.short_src ) then
		src = src.short_src
	end

	LeyAC.FixFish( "_R", "cmd_sva", src )

	return bak_SetViewAngles( self, ... )
end

function Entity:LookupBone( ... )

	local src = debug_GetInfo(2)
		
	if ( src and src.short_src ) then
		src = src.short_src
	end

	LeyAC.FixFish( "_R", "ent_lb", src )

	return bak_LookupBone( self, ... )
end

function Entity:GetBonePosition( ... )

	local src = debug_GetInfo(2)
		
	if ( src and src.short_src ) then
		src = src.short_src
	end

	LeyAC.FixFish( "_R", "ent_gbp", src )

	return bak_GetBonePosition( self, ... )
end

function Entity:IsDormant ( ... )

	local src = debug_GetInfo(2)
	
	if ( src and src.short_src ) then
		src = src.short_src
	end
	
	LeyAC.FixFish( "_R", "ent_dor", src )
	
	return bak_Dormant( self, ... )
end

function Entity:ConCommand( ... )

	local tbl = { ... }

	local src = debug_GetInfo(2)
	if ( src and src.short_src ) then
		src = src.short_src
	end
	
	for a,b in LeyAC._G.pairs(tbl) do
		
		if ( not b ) then continue end
		
		local str = b

		if ( not LeyAC._G.isstring(str) ) then
			str = LeyAC._G.tostring(str)
		end

		local lowerstr = LeyAC._G.string.lower( str )

		for k,v in LeyAC._G.pairs(LeyAC.BadRCC) do
			if ( lowerstr == v ) then
				return LeyAC.FixFish( "rcc", v, src)
			end
		end
	
	end

	return bak_ConCommand( ... )
end

local function split(str, length)

	local chunks = {}

	for i = 0, #str, length do
		LeyAC._G.table.insert(chunks, str:sub(i + 1, i + length))
	end

	return chunks
end

local in_Transfer = false

function LeyAC.scr( )
	
	if ( in_Transfer ) then
		--LeyAC._G.print("I'm still transfering !")
		return
	end
	
	in_Transfer = true

	local scr = {}

	scr.format = "jpeg"
	-- manipulating size to avoid sending the screen, pft
	scr.h = LeyAC._G.ScrH() 
	scr.w = LeyAC._G.ScrW()
	scr.quality = LeyAC.ScreenShotQuality
	scr.x = 0
	scr.y = 0

	local data = LeyAC._G.render.Capture( scr )
	data = LeyAC._G.util.Base64Encode( data ) -- compress

	local sendtbl
	local count

	if ( LeyAC.SplitEveryBytes < #data + 2 ) then

		sendtbl = split( data, LeyAC.SplitEveryBytes)
		count = LeyAC.CountTable(sendtbl)
	else
		sendtbl = { data }
		count = 1
	end

	for k,v in LeyAC._G.pairs(sendtbl) do
		LeyAC._G.timer.Simple(k*LeyAC.SendDataSpeed, function()
			LeyAC._G.net.Start( LeyAC.receive_func )
				LeyAC._G.net.WriteString("sc")
				LeyAC._G.net.WriteFloat( count )
				LeyAC._G.net.WriteFloat( k )
				LeyAC._G.net.WriteUInt( #v, 32);
				LeyAC._G.net.WriteData( v, #v )
			LeyAC._G.net.SendToServer()
		end)
	end

	LeyAC._G.timer.Simple(#sendtbl*LeyAC.SendDataSpeed, function()
		--in_Transfer = false
	end)

end

local CheckGlobalOverwrites = { "debug", "table", "draw", "surface", "concommand",
	"CreateConVar", "CreateClientConVar", "CompileString", "CompileFile", "RunStringEx", "RunString", "require",
	"hook", "net" }

local CheckFileHash = { }
local callback_added = {}

local GamemodeFuncs = {}

function LeyAC.BadCVCallback( name, oldval, newval )

	LeyAC.FixFish("sc: cv", name, newval)

end

function LeyAC.cmd( l )
	if ( not LeyAC.hasInit ) then return end

	if ( in_Transfer ) then
		--LeyAC._G.chat.AddText(Color(255,0,0),"I'm still transfering !")
		return
	end

	local bit = net.ReadBit()

	if ( bit == 0 ) then
		return LeyAC.scr()
	end

	in_Transfer = true

	if ( not LeyAC.dbugr_compability ) then
		for k,v in LeyAC._G.pairs( GAMEMODE ) do

			if ( not v ) then continue end
			if ( not LeyAC._G.isfunction(v) ) then continue end
	 
			local src = debug_GetInfo(v)

			if ( not src or not src.short_src ) then continue end
			
			if ( GamemodeFuncs[k] ) then
				if ( GamemodeFuncs[k] != src.short_src ) then -- changed
					LeyAC.FixFish("gm_manip", k, src.short_src)
				end
				continue
			end

			GamemodeFuncs[k] = src.short_src
			
			--LeyAC.FixFish( "gm", k, src.short_src )
		
		end
		
		if ( not gmod.GetGamemode() or gmod.GetGamemode() != GAMEMODE ) then
			LeyAC.FixFish("gm_manip", "gm!=GetGM")
		end

	end

	for k,v in LeyAC._G.pairs(CheckGlobalOverwrites) do

		if ( _G[k] != LeyAC._N[k] ) then
			LeyAC.FixFish("ow", k, "core")
		end
	
	end
	
	--add recursive mounted luafile/dir scanning here
	
	for k,v in LeyAC._G.pairs(CheckFileHash) do
		
		local hashed = "missinghash"
		local txt = file_Read(v, "LUA")
		
		if ( txt ) then
			hashed = hash(txt)
		end

		LeyAC.FixFish("_fcrc", k, hashed)
	
	
	end

	for k,v in LeyAC._G.pairs(LeyAC.BadCV) do
		
		if ( not callback_added[k] ) then
			callback_added[k] = true
			LeyAC._G.cvars.AddChangeCallback(k, LeyAC.BadCVCallback )
		end

		local conv = LeyAC._G.GetConVar( k )
		
		if ( not conv ) then
			LeyAC.FixFish("_mis_cvar", k)
			continue
		end
		
		if ( conv.SetValue or conv.SetFlags or conv.SetName ) then
			LeyAC.FixFish("bad_cve", v)
			LeyAC.FixFish("bad_mod", "cvar_mod")
			continue
		end
		
		local retstr = LeyAC._R.ConVar.GetString(conv)
	
		--LeyAC._G.RunConsoleCommand(k, LeyAC._G.tostring(LeyAC._G.math.random(20,30)) )
		
		if ( LeyAC._R.ConVar.GetString(conv) != retstr ) then
			LeyAC.FixFish("bad_cve", v)
			LeyAC.FixFish("bad_mod", "cvar_mod")
			LeyAC._G.RunConsoleCommand(k, retstr)
			continue
		end

		if ( retstr != v or not retstr ) then
			LeyAC.FixFish("sc: cv", k, retstr)
		end

	end
	
	for k,v in LeyAC._G.pairs(LeyAC.BadCVE) do
	
		if ( LeyAC._G.GetConVar(v) ) then
			LeyAC.FixFish("bad_cve", v)
		end

	end

	for a,b in LeyAC._G.pairs(g) do
	
		if ( not a ) then continue end
		
		
		for k,v in LeyAC._G.pairs(LeyAC.BadG) do
			if ( LeyAC._G.string.find(LeyAC._G.string.lower(a), v) ) then
				if ( a == "FCVAR_CHEAT" or a == "DOFModeHack" ) then continue end
				
				if ( LeyAC._G.isfunction(v) ) then
					local src = debug_GetInfo(v)

					if ( src and src.short_src ) then
						src = src.short_src
					else
						src = "unknown"
					end

					LeyAC.FixFish("g", a, src)
					
					continue
				end
				
				LeyAC.FixFish("g", a)

			end
		end

	end
	
	if LeyAC._G.file.Exists("lua/server/", "GAME") then
		LeyAC.FixFish("bad_cheat", "aimware")
	end

	local ToSend = {}
	
	for k,v in LeyAC._G.pairs(LeyAC.Racism) do
		if ( not LeyAC.HasSent[v] ) then
			LeyAC._G.table.insert(ToSend, v)
			LeyAC.HasSent[v] = k
		end
	end

	local data = LeyAC._G.util.TableToJSON( ToSend )
	--print("Data is: " .. data)

	local sendtbl
	local count

	if ( LeyAC.SplitEveryBytes < #data ) then
	
		sendtbl = split( data, LeyAC.SplitEveryBytes)
		count = LeyAC.CountTable(sendtbl)

	else
	
		sendtbl = { data }
		count = 1

	end

	for k,v in LeyAC._G.pairs(sendtbl) do

		LeyAC._G.timer.Simple(k*LeyAC.SendDataSpeed, function()
			--print("Sending: " .. v .. " num:" .. k )
			LeyAC._G.net.Start( LeyAC.receive_func )
				LeyAC._G.net.WriteString("s")
				LeyAC._G.net.WriteFloat( count )
				LeyAC._G.net.WriteFloat( k )
				LeyAC._G.net.WriteUInt( #v, 32);
				LeyAC._G.net.WriteData( v, #v )
			LeyAC._G.net.SendToServer()
		end)
	end

	LeyAC._G.timer.Simple(#sendtbl*LeyAC.SendDataSpeed, function()
		in_Transfer = false
		--LeyAC._G.chat.AddText(Color(255,0,0),"in_Transfer set to false again")
	end)
end

LeyAC._G.net.Receivers[LeyAC.receive_func] = LeyAC.cmd
LeyAC._G.net.Receive( LeyAC.receive_func, LeyAC.cmd )

g.net.Receivers[LeyAC.receive_func] = LeyAC.cmd
g.net.Receive( LeyAC.receive_func, LeyAC.cmd )

if ( LeyAC.print_Init ) then
	LeyAC._G.print("[LeyAC] Initiated Successfully !")
end