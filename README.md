# Vault 27 Engineering Logs: Easter 2026 Pip-Boy Project

## Overview
A multiplayer Pip-Boy 3000 (Mark IV) replica built for an immersive Easter puzzle experience. The system relies on asymmetric gameplay (similar to *Keep Talking and Nobody Explodes*), forcing two Vault Dwellers (793 and 612) to cooperate, swap roles, and manage "Radiation Sickness" to decode a final meta-puzzle.

## Hardware Architecture
* **Main Display:** 5" ESP32-S3 Capacitive Touch Display - VIEWE Model：UEDX80480050E-WB-A https://viewedisplay.com/product/esp32-5-inch-800x480-rgb-ips-tft-display-touch-screen-arduino-lvgl/
* **Co-processor:** ESP32-C3 Super Mini connected via serial. Dedicated to efficient BLE MAC address scanning for radiation hotspots, and driving a haptic motor and piezo speaker for Geiger counter feedback.
* **RFID/NFC:** PN532 module for localized object scanning. (in I2C mode)
* **Power:** USB plug to a  TP4056 lipo charger feeding into an MT3608 Boost Converter to make a 5v supply
* **I/O Expansion:** PCF8575 or MCP23017 I/O expander for managing peripherals like rotary encoders and LEDs.(have not acquired...  on hold)
* **Radiation Sources (x4):** Xiao-ESP32-C3 microcontrollers running `esp32_ble_server`.
* **Note:** the wiring from the rotary encoder is red/black for the push button switch and blue/green/yellow for the encoder portion. (find ports for this ...  and a use!)
* **Also Note:** There is a speaker buried in the front panel that I still haven't decided what to do with. 

## UEDX80480050E Board GPIO Selection
* **UART for Co-processor** Used marked Tx/Rx next to GND on left header set.  Also used by USB/UART but available when not updating
* **PN532** GND=GND, SDA=GPIO19, SCL=GPIO20 on the left and VCC connects to the top of that header
* **5v Power** Tapped the left side of diode D3 that is on VBUS2 of the USB port which enables ability to input 5v from a battery source for regulation into 3V3 VDD

## ID's to track ##
* **Alpha UID:** 04-63-EB-5B-C2-2A-81
* **Beta UID:** 04-21-75-94-D2-2A-81
* **Charlie UID:** 04-FA-F4-94-D2-2A-81
* **Delta UID:** 04-A9-75-5B-C2-2A-81
* **1:**  UID: 04-E5-7B-5B-C2-2A-81
* **2:**  UID: 04-54-55-5B-C2-2A-81
## DWELLER PIP BOY SERIAL NUMS ##
* **Dweller 793:** E793X4
* **Dweller 612:** D612Z5

## UI Design Note ##
Due to the physical design and shape of the pip-boy the screen is more "squarish" with a portion of the 5" esp32 display actually insde the case and not visible.
This means that functionally we only have a 600x480 screen starting at x=200, y=0.  All visible UI components and LVGL widgets should be contained in that area of the screen.

## Software & Infrastructure
* **Framework:** ESPHome integrated with Home Assistant.
* **Codebase Structure:** A highly modular design utilizing YAML anchors and substitutions within a single document. This allows seamless switching of parameters between Dweller 793 and 612 without relying on multiple `!include` files.
* **State Management:** Home Assistant acts as the Overseer, handling cross-device state syncing via `input_number.dweller_${id}_xxx`, game tweaks, and manual triggers (like the Reactor Meltdown) and the mystery cell in the Memory Core Repair menu

## Gameplay Mechanics
* **Radiation Management:** Players scan for specific BLE MAC addresses at 4 hotspots. Staying in a hotspot increases Rads. If Rads exceed 25, the HUD and docs glitch out, forcing players to swap roles (Scanner vs. Manual Reader).
* **Anti-Cheese Systems:** Scans have strict 10-second timeouts. Furthermore, the scanner must actively take radiation damage (Rads > 25) to solve the puzzle, preventing players from simply disabling the radiation source.
* **Progression:** Solving the 4 hotspot puzzles yields encrypted data fragments stored in the INV Tab. The S.P.E.C.I.A.L. stats (STAT Tab) act as the decryption cipher, providing the variables needed for the final logic grid puzzle (DATA Tab).

## Menus
* **STAT** Shows RADs and basic information (can expand this) - STATUS, SPECIAL, and PERKS - SPECIAL contains stats that will change when enough HP is gained and will show the pad to unlock the final encyrpted message.
* **INV** Will be the collection point for the puzzle data and the scanner for the 4 radiation clues (KTANE style)
* **DATA** magic grid where the cells have to add to 30 in every row and colunn and cells values can't be duplicated. Some of the cells are locked and one special cell in the upper left side is actually controlled by the other pip boy.  There is a mystery cell outside the grid that is what controls the upper left cell on the other pip boy.
* **MAP** contains a map (just a static image) of the house with pulsating dots (4) indicating where the radiation source puzzles are located.  In a submenu it also contains the docs for solving the puzzles.  The docs can't be opened (or glitch) when rads>25 to prevent both dwellers from being at the source at the same time.

## Current Development Roadmap

* **Game Logic:** Developing the core logic for the INV, MAP, and RADIO tabs.
* **DATA MENU** finish configuring the puzzle and connect the mystery cell through HomeAssistant
* **MAP MENU** Load screen with mini map of house. figure out how to overlay the beacon locations (figure out locations)(done) - Create menu and doc system where the docs are stored in HA and loaded on the fly as needed (or we can just store it in code if we have enough space)
* **INV MENU** Still thinking about this one. I kind of want to have 4 items displayed and when you NFC scan a beacon it opens one of the puzzles. Maybe the puzzles are on a completely different page and we just use the INV to record which ones they got and provide the encrypted messages?  Anyway, the puzzles need to be of a specific KTANE type but have 4 defined puzzles (images or text) that can be rotated through.  there's an active countdown timer and the beacon has to be rescanned every 10 seconds to reset the countdown and continue or the puzzle blanks out and if you rescan after the countdown runs out you get the next puzzle.
* **DEATH**  In the potential event that one of them "DIES" it will flip to a screen that says something like "Vault Dweller sustained too much damage to continue.  INITIATING CLONING SEQUENCE (with a timeout timer of 99 seconds) at which point the pip-boy reboots.  Attempting to reboot the pip-boy before cloning is complete will just drop them in the same page with a fresh 99 second timer - completion managed by HomeAssistant.  All stats and accomplishments should be saved in HomeAssistant and won't be lost due to death or pip-boy reboots or failures.  (overseer has game reset control for testing and situational restarts)
* **Vaultboy Animation** figure out how to animate him (done)
* **Boot Screen:** Implementing a realistic Mark IV console-style scrolling text sequence featuring RobCo copyright, the `${pip_version}`, and biometrics initialization. (done)
* * **RAD meter** reconnect to co-processor for display (done)

## LLM Instructions 
* Use most current esphome and lvgl commands and language.  Using .obj explicitly in lambda functions will cause compiler errors now.  (you can literally just drop the extension)
