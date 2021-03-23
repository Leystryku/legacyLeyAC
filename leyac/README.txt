The config is saved in garrysmod/data/leyac_cfg.txt.
If you can't find it, it's because Ley AC needs to have been at least run once to create it.

Setup:
Drag & Drop to your addons folder.
Play for 5-30 Minutes, then set "AdaptationMode" to "no" & change the map  - done ! (  But try to use everything there is - menus, weapons, etc. )
It's recommended though, to test it with a few trusted friends, to make sure that no one get's a hack whitelisted.
Keep in mind, it's not the amount of time to server is in adaptation mode that matters,
it's the amount of stuff used while it's on !

-[[DON'T FORGET TO RE-ADAPT AFTER INSTALLING A NEW ADDON !]]-

other important info:

http://steamcommunity.com/id/Leystryku/

You can view the screenshots with the !leyac command
or use a base64 to image site, since they are saved as base64.
If you're using wire, set LeyAC.punish_RunString and LeyAC.punish_CompileString to false.
If you see cs + something in your goodstuff file, set LeyAC.punish_CompileString in the _ley_imp.lua to false.
If you see cf + something in your goodstuff file, set LeyAC.punish_CompileFile in the _ley_imp.lua to false.
If you see rs + something in your goodstuff file, set LeyAC.punish_RunString in the _ley_imp.lua to false.
Also, DON'T EVER put LeyAC together with another anticheat, chances are, leyac will ban
people for the other AC or pretty much render the other AC useless.

-- THESE ARE ONLY EXAMPLES; DONT EDIT THOSE; ONLY USE THEM FOR INFO; EDIT THE garrysmod/data/leyac_cfg.txt !!!
-- DO NOT EDIT THE sv_leyac.lua !!!

"TableToKeyValues"
{
	"AdaptationMode" "yes" --  adaptationmode on or off?

	"CustomCheck"		"no" -- Custom check, in case you e.g. don't want your admins getting banned for cheating ( edit the LeyAC.ShouldCheck if it doesnt work !!! )

	"KickForCheating"		"no" -- kick for cheating ?

	"BanForCheating"		"yes" -- self explanatory
	"BanForCheating_Time"		"86400" -- 0=perma, time in seconds
	"BanForSeedForcing"	"yes" -- should users be banned for seed forcing?-- Ban for seed forcing? desc: you can disable this if you want. Might help against C++ hackers who use a specific trick against spread

	"HTMLForCheating"		"no" -- if you want a url to open when someone cheats
	"HTMLForCheating_URL"		"http://nyan.cat/" -- in case your open the htmlforcheating option
	"HTMLForCheating_Command"		"say I was a bad bad boy :(" -- the command that executes when the html opens
	
	"SmartAdapt"	"yes" -- For people who don't want to adapt all possible file sources & crc's

	"CheckFileCRC"	"no" -- Should it check the file crc, untested

	"WebLogScript"	"no" -- If you have a custom PHP log script for cheaters

	"KickForNameSteal"		"yes" -- pretty much self explanatory I guess

	"NotifyPlayers"	"yes" -- notify players if someone cheats?
	"ScreenshotOnDetect" "yes" -- take a screenshot on detection? If disabled, punishing is A LOT faster!

	"Init_Time"		"90" -- Time players have to join, needs to be same as in _ley_imp.lua, keep it under 200 but above 40 - recommend: leave at default

	"TimeToPunish"		"160" -- maximum time until punishment kicks in, leave at default if unsure. too low = no screenshots, too high = (sometimes) no ban !
	
	"Respond_Time"		"170" -- the time people have to respond with the pong, needs to be higher than CheckTime ( recommend: 5-20 seconds higher than CheckTime * 2 )
	"LogTimedOut"		"no" -- should it log people that timed out ( cheaters might try to disable the ac, but legit people may time out too )

	"CustomReason"		"Cheats" -- the reason for the kick/ban

	"Receive_Func"		"ijustwannahaveyourightbymyside" -- Change it to something else, and make the LeyAC.receive_func in _ley_imp.lua the same as this one. desc: the func called on the client whenever they receive the ac's commands, please change it to make bypassing this even harder
	"Hi_Func"			"hellohellohelloimcool" -- Change it to something else, and make the LeyAC.hi_func in _ley_imp.lua the same as this one. desc: the command ran to tell the ac "Hi, I'm here !", please change it to make bypassing this even harder
	"Menu_Func"			"kkkkimabestever"	-- Change it to something else, and make the Menu_Func in cl_leyac_menu.lua the same as in this one. desc: the command you use to open the leyac menu, in case you arent using the chat command.
	
	"CheckTime"		"80" -- interval in which players should be searched for cheats, in seconds, needs to be lower than Respond_Time ( recommend: Respond_Time / 2 ), please keep this above 60 but under 600 !

}

There are also few settings in the _ley_imp.lua, but only adjust them if you're an advanced user.
The only setting you might change in there is LeyAC.SendDataQuick, set it to false if people's connections
are lagging out while joining.
And no, this is not supposed to stop every cheat, it's supposed to block public ones like you can find on mpgh.
It's not great yet, but it does it's job ( and bans more than just public ones actually heh ).
It doesn't have anything making it impossible to bypass, or really hard,
because the usual purchaser wouldn't be able to set it up by himself.
It should work with any addon, but if it doesn't work with one tell me and I'll solve the problem.
If you find a way to bypass this, a bug, or a public cheat that this doesn't detect, tell me about it.
If you have false detections, re-enable the adaptation mode until they're adapted and if that doesn't work, contact me about it.

Oh and, if you want to, for more safety, you can change client_file_name in _ley_imp.lua to something else, and rename the _ley_imp.lua to that.


I'd love a honest review, and if you encounter any problems, tell me, and I'll fix them !

Sincerely,
Leystryku :)

credits:

Leystryku - Creating LeyAC, nearly everything from LeyAC - http://steamcommunity.com/profiles/76561198037715959

Oubliette - old split function which was used from 3.0 to 5.01 - http://steamcommunity.com/profiles/76561198028323995/

Willox - new split function, string magic for the old serverside smartsourcecheck ( used in this version ) - http://steamcommunity.com/profiles/76561197998909316

NanoCat - Testing & Suggestions - http://steamcommunity.com/profiles/76561198002272178

MeepDarknessMeep - Testing - http://steamcommunity.com/profiles/76561198050165746

ZeroTheFallen - Motivation - http://steamcommunity.com/profiles/76561198037701301

Papa John - Testing & Suggestions - http://steamcommunity.com/profiles/76561198011305966

sasha - Emotional Support & Testing - http://steamcommunity.com/profiles/76561198067741681

garry - leyac's table.Copy function

"Fucks" go to:

HeX - Claiming I stole his files and based my AC of his, because he "thought I did" ( https://i.imgur.com/KHwGT6U.png )- http://steamcommunity.com/profiles/76561197995883976
