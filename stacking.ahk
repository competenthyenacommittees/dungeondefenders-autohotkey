#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Persistent
#IfWinActive Dungeon Defenders

Return


; Pause the hotkeys
^S:: Suspend


; Tower/minion stacking
; From https://forums.dungeondefenders.com/forums/topic/147132-tower-stacking-autohotkey-script/
^6::
    SendInput {6} 
    SendInput {Space}
return

^7::
    SendInput {7} 
    SendInput {Space}
return

^8::
    SendInput {8} 
    SendInput {Space}
return

^9::
    SendInput {9}
    SendInput {Space}
return

^0::
    SendInput {0} 
    SendInput {Space}
return
