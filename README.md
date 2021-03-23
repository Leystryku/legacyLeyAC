Moved from SVN to Mixtape.Moe to GitHub

# legacyLeyAC
[![License](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/licenses/MIT)
[![App Version](https://img.shields.io/badge/version-v5.1-brightgreen)](https://github.com/Leystryku/legacyLeyAC)

Market leader of the old days. A very old Anti Cheat of mine for Garrysmod which I worked on from 2012 to 2014, which hooked into several end points of the GLua client state to generate vast amounts of data. Said data was then all networked to the server. To determine whether a user might be malicious or not, there was a AdaptationMode which generated a database of legitamate user information. On initial install AdaptationMode is enabled. However, after the Server owner felt confident they could disable the AdaptationMode, thus finalizing the database. From that point onwards, the database was fixed and used for comparison. Everytime a player joined from that point onwards the data of his client state was compared to the data in the database. Whenever data mismatched, or was missing the system automatically recognized this, flagged this accordingly, took a Screenshot of said user and tried to upload his cheat

# Showcase
![1 Img](https://raw.githubusercontent.com/Leystryku/legacyLeyAC/master/assets/1.png)
![2 Img](https://raw.githubusercontent.com/Leystryku/legacyLeyAC/master/assets/2.png)
![3 Img](https://raw.githubusercontent.com/Leystryku/legacyLeyAC/master/assets/3.png)
![4 Img](https://raw.githubusercontent.com/Leystryku/legacyLeyAC/master/assets/4.png)

# Support
There is sadly no support. This is legacy software. I can not help you in using this. If you do take inspiration or code from this, please give credit.

# Running
- Drop into your addons/ folder
- Play for a while
- Disable the AdaptationMode in data/leyac_cfg.txt

# Predecessor
The predecessor to this System was QAC. QAC was a AntiCheat which only focused on validation of the filenames of code which was run. This worked too, but it was a very rudimentary form of protection. Renaming Cheats to have legit names was enough to fool said system. Additionally there was no protection against bypasses or modifications. This prompted me to start developing this System.

# The problem with this approach
The whitelist database approach is the goto way for writing a AntiCheat when faced with clientside Code. However, the generation of database is actually a very complicated problem. On the game which this was used for, there is one of the largest modding communities in any games. Those modders create hundreds of new lua programs daily. The owners of servers add new lua programs to their servers quite frequently or modify them, sometimes even resulting in conflicts. Additionally, since this automatically Hashes some built in functions, this also is sensitive to changes such as a new update to the lua runtime or any of the functions bound to the lua runtime this runs in. To some extent it is even sensible to self-modification. Therefore, the generation of this whitelist for every possible update,server,addons combination is a NP-hard problem. Generation of the database on runtime based on the data users send while a adaptation mode is enabled is quite a fair approach for smaller servers, but if a server has 100 or 200 extensions installed, it is very hard for the server administrator to try out every possible combination while this system is running. 

# The next iteration of the approach
To combat this, some time after this products end of life, a AntiCheat called !cake Anti-Cheat (CAC) by another developer succeeded it, eventually becoming the next market leader of customer facing AntiCheats. Instead of the generation of a whitelist through a adaptation mode, !cake Anti-Cheat used a centralized database. However, this centralized database however also had to be updated by someone, namely the developer, thus the entire pain of dealing with this problem just shifts from the customers to the developer. This lead to more customer satisfaction in exchange for more developer burn out. Thus once the developer stopped updating said DB, it died out as well. Additionally, !cake Anti-Cheat instead of putting emphasis on writing the code in a obfucusated looking manner, put much effort towards writing a heavy obfucusator. Due to this, unlike with this product, cheaters were and are still unable to fully decipher the original source. Some may call this security through obsecurity - but precisely because of this, cheaters have not been able to understand its effectiveness, while script kiddies have been unable to copy his AntiCheats secrets.

# A more modern outlook
Eventually after !cake Anti-Cheat faded away, I re-entered the Anti-Cheating scene. However, I decided that instead of focusing on full efficiency against cheaters, detecting the majority of cheaters was more than enough for most servers. It saves me money, it saves customers money, and most of all - it reduces the stress involved greatly. A Anti-Cheat focusing on said approach will soon be open sourced on GitHub. However, before that, that ones successor with a more modern approach has to be fully completed, tested and distributed.
 
# Credits
- Leystryku (me)
  * Creating this project
- All the clients
  * Funding this project and the updates
- cake!
  * Making a really good successor and taking over as the market Anti-Cheat guy after this ones end of life
- Anyone  who deserves it who I might have forgotten since this is over 5 years old
  * Message me, and I'll add you here
