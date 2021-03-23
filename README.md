Moved from SVN to Mixtape.Moe to GitHub

# legacyLeyAC
[![License](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/licenses/MIT)
[![App Version](https://img.shields.io/badge/version-v5.1-brightgreen)](https://github.com/Leystryku/legacyLeyAC)

A very old Anti Cheat of mine from ~2012~2014 which hooked into several end points of the GLua client state to generate vast amounts of data. Said data was then all networked to the server. To determine whether a user might be malicious or not, there was a AdaptationMode which generated a database of legitamate user information. On initial install AdaptationMode is enabled. However, after the Server owner felt confident they could disable the AdaptationMode, thus finalizing the database. From that point onwards, the database was fixed and used for comparison. Everytime a player joined from that point onwards the data of his client state was compared to the data in the database. Whenever data mismatched, or was missing the system automatically recognized this, flagged this accordingly, took a Screenshot of said user and tried to upload his cheat

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

# Credits
- Leystryku (me)
  * Creating this project
- All the clients
  * Funding this project and the updates
- Anyone  who deserves it who I might have forgotten since this is over 5 years old
  * Message me, and I'll add you here