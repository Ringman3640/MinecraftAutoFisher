# Minecraft Auto-Fisher for 1.16+
Automatically fish for Minecraft versions 1.16+. 

## Required Settings
Some settings within Minecraft must be set for the farm to operate.

**Subtitles** - This script works by constantly checking the subtitle text to determine when a fish has been caught. Subtitles must be turned on.

**GUI Scale 4** - The subtitle text must be at a specific size to be read by the script accurately. Auto may also work depending on the monitor resolution.

**Windowed Fullscreen** - Fullscreen mode prevents the script from properly reading the screen. Use windowed fullscreen mode (or potentially a borderless fullscreen mode with mods or plugins).

## Usage
Before starting the auto-fisher, ensure that the fishing rod is in the first slot of the toolbar. The script automatically selects the first toolbar slot upon starting the farmer.

Controls:

F1 - Start the auto-fisher

F2 - Pause the auto-fisher

F3 - Toggle shutdown option

F4 - Exit the program/script

## Shutdown Option 
When leaving the script to farm unattended, there is the risk of entering a bad or error state, such as if the game crashes or experiences an error. To prevent wasted system usage, the program will either close the script or attempt to shutdown the computer after 25 failed fishing casts. The option to choose to close the script or shutdown the computer can be toggled with F3. By default, the script will only close the script. 

## Dependencies
The AHK script for the auto-fisher requires the FindText script by FeiYue, which can be found here:

https://autohotkey.com/boards/viewtopic.php?f=6&t=17834

Ensure that the the FindText script file is in the same directory before starting the script.

The standalone executable does not have any dependencies.
