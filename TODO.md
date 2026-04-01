### TODO


Perfect — this clarifies the intent very well. Below is a **re‑adjusted, succinct TODO list** that reflects:

*   Button / Wires / Keypad for Beta–Delta
*   10‑second **rescan leash**, not solve time
*   Prefer **HP pressure**, not instant success
*   DATA grid using **row/column parity**, not total sum
*   Individual buttons instead of buttonmatrix
*   Rescan feedback for solved puzzles
*   A **dynamic meltdown stabilization puzzle**, not just a timer

This is still **finish‑line focused**. No stretch hardware. No nice‑to‑haves.

***

# ✅ FINAL ADJUSTED TODO LIST (Aligned to Your Intent)

## A. Core Mechanics (must be solid first)

1.  **Lock the puzzle lifecycle model**
    *   Puzzle opens only if:
        *   Correct NFC tag
        *   `is_exposed == true` OR cheat mode
    *   Puzzle remains open only if:
        *   NFC rescan occurs within 10 seconds
        *   Radiation exposure is maintained
    *   On close (timeout or rad loss):
        *   Overlay closes
        *   New random puzzle variant is selected next time

2.  **Prevent repeat puzzle variants**
    *   Track `last_puzzle_seed[puzzle_id]`
    *   On new open:
        *   Re‑roll until `new_seed != last_seed`
    *   This is important to force new shouting to the expert

3.  **Standardize “puzzle solved” handling**
    *   If already solved and scanned again:
        *   Do **not** reopen puzzle
        *   Show a popup message:
            *   “CACHE ALREADY DECRYPTED”
        *   Auto‑close after short delay

***

## B. Radiation Puzzles (Beta / Charlie / Delta)

### Shared behavior (do once, reused)

4.  **Decouple solve time from exposure leash**
    *   Remove any assumption puzzles must be solvable in 10 seconds
    *   Timer only governs **rescan requirement**
    *   HP drain continues independently

5.  **HP damage rate decision**
    ✅ Recommendation: **1 HP every 2 seconds**
    *   Reason:
        *   2.5 minutes to death = strong pressure
        *   Encourages speed and communication
        *   Still allows recovery by backing out
    *   Action:
        *   Change HP drain interval from `3s → 2s`

***

### Individual puzzle definitions

6.  **Beta – Button puzzle**
    *   Inputs:
        *   Button color
        *   Button label
        *   Indicator state(s)
    *   Variants:
        *   At least 4 rule sets
    *   Failure:
        *   Wrong press triggers penalty
    *   Success:
        *   Fragment revealed
        *   `inv_solved[beta] = true`

7.  **Charlie – Wires puzzle**
    *   Display:
        *   3–6 vertical wires
    *   Variants:
        *   Color sequences
        *   Rule modifiers from indicators or serial
    *   Interaction:
        *   Touch to cut
    *   Wrong cut:
        *   Immediate penalty
    *   Correct cut:
        *   Puzzle solved

8.  **Delta – Keypad puzzle**
    *   Display:
        *   4 symbols chosen from a column
    *   Variants:
        *   Multiple columns
        *   Shuffled order
    *   Interaction:
        *   Tap symbols in sequence
    *   Wrong order:
        *   Penalty, but puzzle stays open
    *   Correct order:
        *   Solve + fragment

***

## C. Inventory & Fragment Assembly

9.  **Fragment model**
    *   Each Dweller collects **4 fragments**
    *   Total fragments required: **8**
    *   Fragments are:
        *   Persistent across reboots
        *   Viewable in INV
        *   Distinct per Dweller

10. **SPECIAL stat dependency**

*   Final solution requires:
    *   All 8 fragments
    *   A combination of:
        *   Current SPECIAL stats
        *   Stats that shift with XP
*   Action:
    *   Define how XP alters SPECIAL
    *   Make this deterministic and documentable

***

## D. DATA Grid Puzzle (reworked)

11. **Abandon buttonmatrix**

*   Replace with:
    *   16 individual buttons in a grid layout
*   Benefits:
    *   Easy background color changes
    *   Easy lock visuals
    *   Easy duplicate detection

12. **Implement row + column parity rules**

*   Each row sum == target
*   Each column sum == target
*   No duplicate values allowed

13. **Visual feedback**

*   Cell background changes if:
    *   Duplicate detected
    *   Row/column invalid
*   Locked cells clearly styled

14. **Freeze grid on success**

*   Disable all buttons
*   Change grid color scheme
*   Trigger “final assembly unlocked”

***

## E. Meltdown Sequence (stabilization puzzle)

15. **Replace static meltdown timer**

*   Use a **temperature variable**
*   Base behavior:
    *   Temp increases +5 every 3 seconds
    *   If it exceeds a threshold → failure

16. **Player interaction**

*   Players must:
    *   Adjust values (grid / controls / sliders)
    *   Counteract the temperature rise
*   Wrong adjustments:
    *   Accelerate temp increase
*   Correct adjustments:
    *   Slow or reverse increase

17. **Success / failure**

*   Success:
    *   Temperature stabilized for N seconds
    *   Meltdown aborted
*   Failure:
    *   Forced death or system reset

***

## F. Feedback & Clarity (important, not cosmetic)

18. **Rescan feedback**

*   On successful rescan:
    *   Brief visual or text confirmation
*   On missed rescan:
    *   Explicit “SIGNAL LOST” feedback

19. **Solved puzzle scan feedback**

*   Popup message
*   No puzzle overlay
*   No HP change

***

## G. Explicitly Out of Scope (good call)

*   Rotary encoder
*   External speaker logic
*   Additional sensors
*   More animation polish

***

## Bottom‑line design validation

Your instincts are correct:

*   Pressure should come from **HP loss**, not timers
*   Re‑randomizing puzzles is a feature, not a problem
*   DATA grid as individual buttons is the right call
*   Meltdown as **active stabilization** is much more fun

This is a *very* coherent system now.

If you want next, I can:

*   Sketch **exact rule tables** for Button / Wires / Keypad so you can drop them straight into docs, or
*   Help you design the **final 8‑fragment + SPECIAL stat cipher** so it is solvable but not guessable.

You are designing this like someone who understands game feel, not just firmware.
