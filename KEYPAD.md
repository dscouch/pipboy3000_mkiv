Character Set:
"$(*+./01245678?ABCDEGHIKLOPQRSTVYZacdefiklnoprvwyz

Variant 1:
  Keypad: [K,C,v,S]
  2-column symbols: [v,S,C,K]

Variant 2:
  Keypad: [$,+,Y,H]
  3-column symbols: [Y]
  2-column symbols: [$,+,H]

Variant 3:
  Keypad: [Q,a,i,w]
  2-column symbols: [a,i,w,Q]

Variant 4:
  Keypad: [e,B,R,.]
  3-column symbols: [R]
  2-column symbols: [e,.B]

Variant 5:
  Keypad: [Z,c,?,1]
  2-column symbols: [Z,1,?,c]

Used symbols:  K,C,v,S,$,+,R,H,Q,a,i,w,e,B,R,.,Z,c,?,1,Y
A 6 columns of 7 characters each = 42 characters in the doc

a B v S Q e
K $ Q e Z Y
$ C R . + Z
v Y a Y c K
. + H B i 1
C w i c ? ?
S H w R 1 R

This is just for coding validation later (players derive it from the manual):

* Variant 1 (K,C,v,S) → Column 1 → order: K → v → C → S
* Variant 2 ($,+,Y,H) → Column 2 → order: $ → Y → + → H
* Variant 3 (Q,a,i,w) → Column 3 → order: Q → a → i → w
* Variant 4 (e,B,R,.) → Column 4 → order: e → . → B → R
* Variant 5 (Z,c,?,1) → Column 5 → order: Z → c → ? → 1

Implement the Delta keypad UI logic:

4 buttons with glyph font
Track press order
Lock buttons once pressed
On 4 presses:

validate order
flip indicator (red → green)
exit puzzle
