# Prototype Report: Infection Spread

**Date**: 2026-04-25 (built) / 2026-04-26 (playtested)
**Status**: Playtested — recommendation finalized

---

## Hypothesis

The reactive infection spread mechanic — where unmatched tiles convert to "zombies" each turn — produces satisfying clutch moments and shifts the player from score-maximizing to containment thinking.

---

## Approach

Built a self-contained Godot 4.6 GDScript prototype:
- 8×8 grid, 6 tile colors, click-to-swap interaction (desktop, no touch yet)
- Match detection (3+ in row/column), full-board cascade resolution
- Infection spread mechanic with live tuning sliders
- Single-color goal: "Collect 20 RED brains in 20 moves"

**Iterated during playtest** (each fix surfaced a deeper question about the design):

1. **First spread implementation** (BFS from every infected tile, all 4 neighbors per turn) → unwinnable. Infection grew exponentially. Net loss of ~3-9 tiles per turn against a ~3-tiles-cleared rate.
2. **Switched to source-only spread**: only original seed positions emit infection, newly-infected tiles are static (don't themselves spread). Permanent seeds re-emit each turn. Result: with 2 seeds × rate 1, max 2 new infections per turn vs ~3 cleared per match — playable equilibrium.
3. **Added visual distinction**: ☠ for permanent seeds vs 🧟 for spread infection. Before this, players had no mental model for what could and couldn't be eliminated.
4. **Added in-game help panel + event log**: rules and turn-by-turn feedback (match cleared / infection purged / spread). Cleanup mechanic was completely invisible without this.
5. **Added step delays** (300ms after clear, 200ms after gravity, 250ms before spread) so players can perceive each phase. Without delays, all phases happened on one frame and the board appeared to "teleport".

**Build time**: ~4 hours including iteration.

---

## Results

### Session 1 — Original spread rule (BFS from all infected, rate=1, 2 seeds)
**Outcome**: Unwinnable. Infection covered ~50% of board by move 5, ~80% by move 10. Player could not keep up regardless of match strategy.
**Player quote (paraphrased)**: *"infection spread too strong, each time only can clear 3 tiles but infection is exponential"*
**Verdict**: Spread algorithm was wrong, not just mistuned. Branch-spreading infection has no balance point — always either trivial (rate=0) or runaway.

### Session 2 — Source-only spread (rate=1, 2 seeds)
**Outcome**: Playable. Infection visibly persistent but not overwhelming. ~5–10 infected cells in steady state.
**Player observation**: Cleanup mechanic still wasn't obvious — *"how to clear the infection"*. Needed explicit explanation that matching infected tiles purges them.
**Verdict**: Algorithm is correct; surfacing the cleanup loop was the next gap.

### Session 3 — After visual distinction (☠ seed vs 🧟 spread) + help panel
**Outcome**: Player understood the rules but raised a deeper design question: *"if i just need to collect and match brains, what other tiles for"*
**Verdict**: Single-color goal collapses the strategic surface. With only one valuable tile type, the other 5 types feel like obstacles rather than tools, and the containment mechanic feels like a chore. Multi-color goals are likely required to make every match feel meaningful.

---

## Metrics

| Metric | Value |
|---|---|
| Build time | ~4 hours including iteration |
| Spread algorithms tested | 2 (branch-spreading, source-only) |
| Algorithms that produced equilibrium | 1 (source-only) |
| Spread rate that felt fair | 1 cell/seed/turn |
| Spread rate that felt punishing | 2+ cell/seed/turn at 2 seeds (over half the board infected by move 8) |
| Seed count that felt right | 2 |
| Iteration count to make UI legible | 5 (initial → bug fixes → mouse filter → cascade scan → visual distinction) |
| Player-discovered design issues | 3 (algorithm wrong, cleanup invisible, single-color goal hollow) |

---

## Recommendation: PROCEED — with critical constraints

The core hypothesis holds: **source-only infection spread does produce a tension between scoring and containment**, and at the right tuning (2 seeds, rate 1) the equilibrium is playable. However, three constraints surfaced during playtest that **must be encoded in the production GDDs** before any system implementation begins.

### Required design constraints (must be in production GDDs)

1. **Spread algorithm: source-only, NOT branch-spreading.** Only the original seed positions spread infection. Newly-infected tiles are static markers until matched. Branch-spreading has no balance point.
2. **Multi-color goal targets.** Single-color goals make 5/6 tile types feel like obstacles. Goal panel must specify multiple tile types per level (matches the original concept's "25 brains, 15 RIPs, 20 bones" example, line 110 of game-concept.md).
3. **Visual distinction between seeds and spread infection.** Players cannot form a mental model without two distinct visual states. ☠ vs 🧟 worked in prototype; production needs equivalent or better art-direction-compliant icons.
4. **Cascade resolution must be full-board, not swap-local.** Trivial in concept but easy to get wrong; the production GDD for the Match-3 Grid Engine must explicitly specify this.
5. **Step pacing between phases** (clear → cascade → refill → spread) is core to readability. Production should authority-budget at least 200–400ms per phase. Skipping this will collapse player understanding.
6. **In-level legend / first-time tutorial** for what ☠ vs 🧟 means. The concept claims "reactive spread is self-teaching" (line 98) — partially true, but the *cleanup mechanic* (matches purge infection) is NOT self-teaching. It requires either explicit text or a heavily-scripted level 1 that teaches it via play.

### Open design questions for the GDD authoring phase

- Should the player get a **bonus** for matches that include infected tiles? Reward the containment strategy directly rather than relying on intrinsic motivation. Could be score multiplier, partial power-up charge, or extra moves.
- Should seeds be **placeable into the level data** (hand-authored positions) rather than random? The prototype randomized — production likely wants level designer control over seed placement so each level has authored tension.
- Tile count tuning — concept already flagged this; prototype confirms that 6 colors active with ~20 moves on 8×8 is grindy. Early levels likely want 3–4 colors as the concept's risk-mitigation suggests (line 236).

---

## Lessons Learned

1. **The "concept feels self-teaching" claim is partly wrong.** Reactive spread itself is observable, but the *cleanup* mechanic is not — it must be surfaced explicitly. This affects level 1 design.
2. **Source-only spread is a fundamentally different mechanic than branch-spread**, even though they share a name. The production GDD for Infection Spread System must explicitly call out which model is in use; the term "spread rate" is ambiguous between them.
3. **Static typing in Godot 4.5+ is stricter** than the concept's "GDScript" technical preference implies. The prototype hit parse errors that production code must avoid by setting explicit types on all variables initialized from Variant property access.
4. **Mouse filter on Control children defaults to STOP** and silently eats clicks intended for the parent. The Match-3 Grid Engine GDD should call out this Godot footgun explicitly.
5. **Single-color goal undersells the entire game.** This was the most surprising finding — a player after 10 minutes asked "what are the other tiles for?" That question should never be possible if the design is working. Multi-color goals are non-optional.
6. **Initial board state must clear pre-existing matches.** Random tile generation produces 3-matches that will sit untriggered without explicit cleanup. Production should re-roll until clean OR seed deterministically per level (the concept already chose the deterministic queue path).

---

## Production Implementation Notes (for whoever writes the system GDDs next)

- **Match-3 Grid Engine GDD** must specify: full-board cascade scan, deterministic refill queue (per concept), Godot mouse filter handling on tile children, step delay budget per cascade phase.
- **Infection Spread System GDD** must specify: source-only spread, seed positions as authored level data, seed re-emission rule (does matching the seed's tile delay re-infection by N turns? Currently prototype says "no — re-infects next turn" which felt fair), and the visual distinction requirement.
- **Level Definition System GDD** must include seed positions as level fields, alongside the tile queue and goal targets.
- **UI / HUD GDD** must include the legend / first-time-spread tutorial requirement.

---

## CD-PLAYTEST

Lean mode — Creative Director gate skipped. Prototyper recommendation (PROCEED with constraints) is the working verdict.
