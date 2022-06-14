#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include FindText.ahk

global Text:="|<>*125$101.zzzzzzzzzzzzzzzzzs00szzzszzszzzzzzk01lzzzlzzlzzzzzzU03XzzzXzzXzzzzzz7zzzzzz7zzzzzzzzyDzzzzzyDzzzzzzzzwTzzzzzwTzzzzzzzzs0zsz00ss7ss07z03k1zly01lkDlk0Dy07U3zXw03XUTXU0Tw0D7zz77zz0z777z77zSDzyCDzy1yCCDyCDywTzwQTzw3wQQTwQTxszzsz07szssszsszvlzzly0DlzlllzllzrXzzXw0TXzXXXzXXzj7zz7zz77z777z7s0SDzyDzyCDyCCDyDk0wTzwTzwQTwQQTwTU1szzss07szssszszzvlzzlk0DlzlllzlzzrXzzXU0TXzXXXzXzzjzzzzzzzzzzzzzz00zzzzzzzzzzzzzzy01zzzzzzzzzzzzzzw03"
global TIME_OUT = 25000 ; 25 sec
global CONT_LOOP := false

f1::
CONT_LOOP := true
farmLoop()
return

f2::
CONT_LOOP := false
return

f3::
if (ok:=FindText(X, Y, 1567-150000, 959-150000, 1567+150000, 959+150000, 0, 0, Text)) {
    ToolTip, % "True"
}
else {
    ToolTip, % "False"
}
return

f4::
ExitApp
return

farmLoop() {
    iteration := 0
    timeoutCount := 0

    ; Ensure rod is selected
    Send, 1
    Sleep, 1000

    while (CONT_LOOP) {
        startTime := A_TickCount
        found := false

        if (timeoutCount > 25) {
            ; Shutdown PC if an error state is reached indefinitely
            Shutdown, 1
            ExitApp
        }
        
        if (iteration >= 20) {
            ; Reset rod state
            Send, 2
            Sleep, 1000
            Send, 1
            Sleep, 1000
            iteration := 0
        }

        ; Cast fishing rod
        MouseClick, right
        Sleep, 3000

        while (found == false) {
            ; Check if past time limit
            endTime := A_TickCount
            if (endTime - startTime > TIME_OUT) {
                found == true
                ++timeoutCount
                continue
            }

            ; Check if need to exit func
            if (CONT_LOOP == false) {
                return
            }

            ; Check for caught fish message
            if (ok:=FindText(X, Y, 1567-150000, 959-150000, 1567+150000, 959+150000, 0, 0, Text)) {
                found := true
                timeoutCount := 0
            }

            Sleep, 50
        }

        ; Reel fishing rod
        MouseClick, right
        Sleep, 500

        ++iteration
    }
}