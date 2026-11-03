# Phantom Dust Rebirth (pdnet): changes from the original 2017 game

Everything pdnet adds or changes compared with the original Phantom Dust (2017, Microsoft Store), as of
Experimental 98 (2026-11-02). Items marked *(not yet tested)* are built but still waiting for a test in a real match.

## Online play without Xbox Live
- **Epic Online Services replaces Xbox Live and Teredo.** No accounts, no port forwarding; Epic's relay is used
  when a direct link fails.
- **More reliable connections:** faster joins, joins with a wrong PC clock, and no freeze on a short drop
  *(freeze fix not yet tested)*.
- **Fixes:** empty lobbies hidden, no crash on joining or leaving a lobby.
- **Runs on Store and unpacked copies** (no game files changed), plus a Linux (Wine) build.

## Player identity and saves
- **Your own player name**, chosen in Setup and changeable in the game. No gamertag needed.
- **Your player survives reinstalls.** Your identity is kept in Windows Credential Manager, so reinstalling the game
  doesn't make you a new player on the scoreboards.
- **Local saves.** Saves are plain files on your PC, which also fixed the "retrieving profile" hang.

## Lobbies
- **Rated / Unrated lobbies.** Pick with the Rating option when creating a game. Any rule can be Rated (not only
  Official Battle rules). Unrated matches don't change your rating.
- **No rating join limit.** Players of any rating can join any lobby.
- **The lobby's SESSION INFO box and the Lobby Browser** show "(Rated)" or "(Unrated)" after the game rule.
- **Arsenal Lab in the lobby.** The lobby's old Invite button reads "Arsenal Lab" and opens the Lab: edit your arsenal,
  view your stock, and buy or sell arsenal cases without leaving the lobby. Works for non-hosts too.
- **Gamertag option works when you're alone** in the lobby.
- **The host's "nametags on bodies" setting applies to everyone** in the lobby.

## Voice chat
- **Voice chat through Epic** (the original Xbox voice chat can't work without Xbox Live).
- **Tag Team voice channels.** In the lobby everyone hears everyone; in a match you hear only your team.
- **Mind Reading works.** While the skill is active you also hear the other team. *(not yet tested)*
- **Mic or Classic voice mode.** Mic: the in-game option turns only your microphone on and off. Classic: the original
  Voice Chat option (Off means you neither talk nor hear).
- **Hear others on/off** (voice_listen, Mic mode).
- **Megaphone icon** shows who is talking, following each player's Mic setting.

## Nametags
- **Nametags always on** in matches; the old nametag button does nothing. Also on in Test Arsenal and ghost battles.
- **Nametag colours:** allies, enemies and defeated players each have their own colour, any hex code.
- **Nametags on defeated players** (optional) in the defeated colour.
- **Play Dead shows** as the defeated colour while the player lies still, until they move or are hit.
- **A player who leaves a match** loses their nametag.

## Scoreboards and ghosts
- **Global scoreboards restored** through Epic: Rating, Battle Royale wins, Tag Team wins, One-on-One wins, with
  player names and Total Wins.
- **Only the 4 Global boards** are shown (Friends / Favorites removed).
- **Removed and hidden players** are kept off the boards.
- **Scoreboard ghost battles.** Pick a player on the Rating board and fight their arsenal, played by the AI. Your own
  arsenal is uploaded after each online match. No wins or rating change. *(not yet tested)*

## Arsenal Lab and practice
- **Buy and sell arsenal cases from the Arsenal Lab**, including the lobby's Lab.
- **Test Arsenal** (Lab, not in the lobby's Lab): choose the opponent's arsenal and your own, then fight an AI opponent.
  No wins or rating change, and the old opponent-feedback screen is gone.
- **Max Credits & Skills in the shop:** up to 5,000,000 credits, 80 of every skill including DLC, and one 2-School
  Arsenal Case.

## Menus
- **"Xbox Live" reads "Online"** in every menu.
- **Multiplayer > Settings** (was Xbox Live Options): name, voice mode, nametag colours, nametags on bodies, start-up
  volume, Discord posts. The Cross Play row is gone.
- **Online Store removed** from the Multiplayer menu.
- **Trade reads "Theater"** (new feature coming later).
- **Community button** on the main menu (was Help & Support) opens the Discord.
- **Options > Send Log** sends your logs to the developers in one press.
- **Options > Updates:** Stable, Experimental or Off.
- **Options > Sound > Aura Particle Beeps** on/off.
- **"Rebirth" title screen** artwork, and the build's version on the main menu.
- **"Official Battle applies toward Scoreboard"** line removed from rule descriptions.

## Controls
- **PlayStation, Nintendo and other controllers** work like an Xbox controller, with rumble (more_controllers).
- **Lock onto partner:** RB on a controller, a key of your choice on the keyboard (default Tab). Press again to go back
  to the game's own target. *(not yet tested)*

## Sound
- **Quieter start-up logos** (splash_volume) until you're past the title screen.
- **Game volume remembered** between runs (Windows forgets it for this game).

## Mods
- **Modpack guard.** Skill modpacks loaded with PD Helper stay loaded until the game closes; if the game puts the
  original skill data back, pdnet restores the modpack. *(not yet tested)*

## Discord
- **Lobby announcements** in the community Discord when you host: opened, players joining and leaving, full, closed.
  One message, edited in place. Each player can turn lobby and player posts off.

## Install and updates
- **One-click Setup.bat**, plus Remove.bat, Restore-XboxLive.bat (undo everything), Collect-Log.bat and
  Edit-Settings.bat.
- **Settings in plain files:** pdnet.ini (kit defaults) and settings.ini (your in-game choices, hand-editable).
- **Auto-updater.** The game updates itself from GitHub at start: Stable or Experimental builds, or Off. Switching back
  to Stable returns to the newest Stable. Old update files are deleted.
- **No pausing when minimized** (Windows normally suspends the game).
- **Start-up crash fix** (a rare timing race when the game starts).
