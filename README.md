# Vault 27 Engineering Logs: Easter 2026 Pip-Boy Project

## Overview
A multiplayer Pip-Boy 3000 (Mark IV) replica built for an immersive Easter puzzle experience. The system relies on asymmetric gameplay (similar to *Keep Talking and Nobody Explodes*), forcing two Vault Dwellers (793 and 612) to cooperate, swap roles, and manage "Radiation Sickness" aka HP loss to decode a final meta-puzzle.

## Hardware Architecture
* **Main Display:** 5" ESP32-S3 Capacitive Touch Display (prototyped on ESP32-2432S024 "Cheap Yellow Displays").
* **Co-processor:** ESP32-C3 Super Mini connected via serial. Dedicated to efficient BLE MAC address scanning for radiation hotspots, and driving a haptic motor and piezo speaker for Geiger counter feedback.
* **RFID/NFC:** PN532 module for localized object scanning.
* **I/O Expansion:** PCF8575 or MCP23017 I/O expander for managing peripherals like rotary encoders and LEDs.
* **Radiation Sources (x4):** Xiao-ESP32-C3 microcontrollers running `esp32_ble_server`.

## Software & Infrastructure
* **Framework:** ESPHome integrated with Home Assistant.
* **Codebase Structure:** A highly modular design utilizing YAML anchors and substitutions within a single document. This allows seamless switching of parameters between Dweller 793 and 612 without relying on multiple `!include` files.
* **State Management:** Home Assistant acts as the Overseer, handling cross-device state syncing via `input_number.dweller_${id}_xxx`, game tweaks, and manual triggers (like the Reactor Meltdown).

## Gameplay Mechanics
* **Radiation Management:** Players scan for specific BLE MAC addresses at 4 hotspots. Staying in a hotspot increases Rads and starts to cause dammage (loss of HP(. If Rads exceed 25, the HUD and docs glitch out, forcing players to swap roles (Scanner vs. Manual Reader).
* **Anti-Cheese Systems:** Scans have strict 10-second timeouts. Furthermore, the scanner must actively take radiation damage (Rads > 25) to solve the puzzle, preventing players from simply disabling the radiation source.
* **Progression:** Solving the 4 hotspot puzzles yields encrypted data fragments stored in the INV Tab. The S.P.E.C.I.A.L. stats (STAT Tab) act as the decryption cipher, providing the variables needed for the final logic grid puzzle (DATA Tab).

## Current Development Roadmap
* **Game Logic:** Developing the core logic for the INV, MAP, and RADIO tabs.

