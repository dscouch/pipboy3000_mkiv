- Platform: ESPHome + LVGL (ESP32-S3)
- Project: Pip-Boy prop with radiation-based gameplay
- Core mechanic: radiation exposure state machine (3-up / 3-down)
- Single source of truth: `id(is_exposed)`
- Docs glitch on exposure, restore on exit
- Puzzles require continuous exposure
- HP drains during exposure, recovers otherwise
- Strict searchable comment standard: >>> [SYS-XXXX]


612 (odd indices):

0x01 0x6B 0x69
0x03 0x68 0x65
0x05 0x61 0x62
0x07 0x65 0x74

793 (even indices):

0x02 0x74 0x63
0x04 0x6E 0x63
0x06 0x69 0x6E
0x08 0x75 0x70

Button A: SLOT = 2
Button B: SLOT = 0
Button C: SLOT = 3
Button D: SLOT = 1
