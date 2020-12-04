#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Persistent
#IfWinActive Dungeon Defenders


gup_toggle := 0  ; Off
gup_every := 0.1*60*1000

heal_toggle := 0  ; Off
heal_every := 0.6*60*1000

staff_charge_duration:=205  ;edit to maximize dps
fire_every:=50
alt_fire_every:=3000  ;long to allow for upgrading/healling/repair


SetTimer, GUp,  %gup_every%
SetTimer, Heal, %heal_every%

Return


; Auto-forced-G-up (^G)
!g::
    gup_toggle := !gup_toggle
    if gup_toggle {
        SoundPlay *-1
        Send ^g
    } else {
        heal_toggle := 0
        SoundPlay *16
    }
Return

GUp:
    if gup_toggle
            Send ^g
Return


; Auto-flash-heal
!0::
    heal_toggle := !heal_toggle
    if heal_toggle {
        SoundPlay *-1
        Send 0
    } else {
        gup_toggle := 0
        SoundPlay *16
    }
Return

Heal:
    if heal_toggle
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
