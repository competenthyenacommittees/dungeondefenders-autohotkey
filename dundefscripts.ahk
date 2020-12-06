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

; Edit staff_charge_duration to maximize DPS
; The longer you can charge without raising the staff the better your DPS from
;   that staff will be. Dial this up or down until your staff doesn't raise
;   when autofiring and you'll be pretty close to max DPS for your staff. This
;   value will probably be different for different staffs.
staff_charge_duration := 205

; The number of miliseconds to try to hold the alt fire button.
;   This is long to allow for upgrading/healling/repair inbetween redoing the
;   alt fire. If you can't manage to upgrade a tower to 3 stars while auto alt
;   fire is on, then increasing this should help. This will cause some aborted
;   upgrades just because of bad timing but it shouldn't be a PITA to upgrade a
;   tower.
alt_fire_every := 3000  

; The interval inbetween shots.
fire_every := 50

Return


; Pause the hotkeys
^Esc:: Suspend


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


; Autofire app weapons
; Using Alt to start because Ctl+LButton is used to upgrade stats in chunks.
;   Activating this macro when trying to bulk upgrade will result in dumping 
;   all remaining upgrades into a stat (at least until it hits cap).
!LButton::
    SetTimer, StaffFireOnce, %fire_every%
    SoundPlay *-1
Return

^LButton::
    SetTimer, StaffFireOnce, Off
    SoundPlay *16
Return

StaffFireOnce:
    Send {LButton Down} 
    Sleep staff_charge_duration
    Send {LButton Up}
Return


; Autofire monk weapons
; Using R to prevent cancelling actions while holding down the alt fire button
!RButton::
    SetTimer, AltFire, %alt_fire_every%
    SoundPlay *-1
Return

^RButton::
    SetTimer, AltFire, Off
    Send {R Up}
    SoundPlay *16
Return

AltFire:
    Send {R Up}
    Send {R Down}
Return


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
