#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Persistent
#IfWinActive Dungeon Defenders


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
^F:: Suspend


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
