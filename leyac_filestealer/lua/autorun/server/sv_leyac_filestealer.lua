////////////////////////////////////////
// © 2014-2024 Romian Transtru    	  //
//    All rights reserved             //
////////////////////////////////////////
//  This material may not be          //
//  reproduced, displayed,            //
//  modified or distributed           //
//  without the express prior         //
//  written permission of the         //
//  the copyright holder.             //
//  Romian Transtru - Leystryku	      //
////////////////////////////////////////

if ( not LeyAC ) then error("[LeyAC][Filestealer] You don't even have LeyAC installed!") return end

hook.Add( "LeyAC.ScrGrab", "LeyAC.FileGrab", function( ply )

	if ( not ply.LeyAC_ToCheck ) then return end
	if ( table.Count(ply.LeyAC_SentTable) == 0 ) then return end

	ply.LeyAC_InScreenshot = true

	if ( ply.LeyAC_StoleFiles ) then
		--print("already stole files")
		return
	end
	
	local bad_exceptions = {}
	local cheatfiles = {}

	for k,v in pairs(ply.LeyAC_SentTable) do
		if ( v[1] == "good" ) then continue end
		
		table.insert(bad_exceptions, v[2])
	end
	
	if ( table.Count(bad_exceptions) == 0 ) then
		--print("badexceptions")
		ply.LeyAC_InScreenshot = nil
		return
	end
	
	for _,tbl in pairs(bad_exceptions) do

		local file_src = tbl[#tbl]
		
		if ( tbl[1] == "chk_src" ) then
			file_src = tbl[2]
		end

		if ( file_src == "Startup" ) then
			continue
		end

		if ( file_src == "LuaCmd" or file_src == "RunString" or file_src == "[C]" or file_src == "unknown" ) then
			continue
		end
		
		if ( file_src == "windows" or file_src == "mac" or file_src == "linux" ) then
			continue
		end	

		cheatfiles[file_src] = true
	end
	
	local n_cheatfiles = {}
	for k,v in pairs(cheatfiles) do
		table.insert(n_cheatfiles, k)
	end
	cheatfiles = n_cheatfiles

	if ( table.Count(cheatfiles) == 0 ) then
		--print("cheatfiles")
		ply.LeyAC_InScreenshot = nil
		return
	end

	ply.o_LeyAC_Violations = ply.LeyAC_Violations
	ply.LeyAC_Violations = nil
	
	timer.Create( "leyac_filesteal" .. ply:UniqueID(), 1, 0, function()
	
		if ( not ply or not IsValid(ply) ) then return end -- left, the other timer will handle that
		if ( not ply.LeyAC_Scr_finished ) then return end -- file still sending
		if ( ply.LeyAC_StoleFiles ) then timer.Remove( "leyac_filesteal" .. ply:UniqueID() ) return end

		ply.LeyAC_StoleFiles = true

		local cheats = ply.LeyAC_Scr
		
		ply.LeyAC_Scr = nil
		ply.LeyAC_ScrParts = nil
		ply.LeyAC_ScrLastPart = nil
		ply.LeyAC_Scr_finished = nil
		ply.LeyAC_InScreenshot = nil
		
		local safeid = string.lower(string.gsub(ply:SteamID(), ":", "_"))		
			
		timer.Remove( "leyac_filesteal" .. ply:UniqueID() )
		
		

		local stop = hook.Call( "LeyAC.OnFileSteal", nil, ply, cheats )
		
		if ( stop ) then LeyAC.ScrGrab( ply ) ply.LeyAC_Violations = ply.o_LeyAC_Violations return end
		
		local cheatnum = 1
		
		for i=1, 300 do
			
			if ( file.Exists("leyac/" .. safeid .. "/cheat_" .. i .. ".txt", "DATA") ) then
				continue
			end
			
			cheatnum = i
			break
		end

		file.Write("leyac/" .. safeid .. "/cheat_" .. cheatnum .. ".txt", cheats)
		ply.LeyAC_Violations = ply.o_LeyAC_Violations

		LeyAC.ScrGrab( ply )

	end)
	
	local cheatfiles_compress = util.TableToJSON( cheatfiles )
	--ply:ChatPrint("cheatfiles comp: " .. cheatfiles_compress)

	net.Start( LeyAC.receive_pass )
	net.WriteString( "z" )
	net.WriteUInt( #cheatfiles_compress, 32 )
	net.WriteData( cheatfiles_compress, #cheatfiles_compress )
	net.Send( ply )

	return true
end)
