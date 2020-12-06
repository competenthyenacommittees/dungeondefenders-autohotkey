#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Persistent
#IfWinActive Dungeon Defenders


gup_toggle := 0  ; Off
gup_every := 0.1*60*1000

flash_heal_toggle := 0  ; Off
flash_heal_every := 0.6*60*1000

Return


; Pause the hotkeys
^M:: Suspend


; Auto flash healling and auto G have a linked off toggle so they both turn off
;   when one of them is turned off.

; Auto-forced-G-up (^G)
!g::
    SoundPlay *-1
    Send ^g
    SetTimer, GUp, %gup_every%
Return

!+g::
    SetTimer, GUp, Off
    SetTimer, FlashHeal, Off
    SoundPlay *16
Return

GUp:
   	Send ^g
Return


; Auto-flash-heal
!h::
    SoundPlay *-1
    Send 0
    SetTimer, FlashHeal, %flash_heal_every%
Return

!+h::
    SetTimer, FlashHeal, Off
    SetTimer, GUp, Off
    SoundPlay *16
Return

FlashHeal:
    Send 0
Return
