# Game Concept: Graveyard Shift

*Created: 2026-04-25*
*Status: Draft*

---

## Elevator Pitch

> A moves-limited match-3 puzzle where the board itself fights back — every turn, infection spreads from the tiles you didn't match. Cleanse the graveyard with cascading combos before the undead overwhelm the board.

---

## Core Identity

| Aspect | Detail |
| ---- | ---- |
| **Genre** | Tension-driven match-3 puzzle (single-player, level-based) |
| **Platform** | Mobile-first (iOS / Android); portable to PC and Web |
| **Target Audience** | Mid-core mobile players who play Candy Crush *and* mechanically deep games (Balatro, Slay the Spire). See Player Profile section. |
| **Player Count** | Single-player |
| **Session Length** | 3-10 minutes (snackable; 1-3 levels per session) |
| **Monetization** | Premium / undecided for jam (post-jam: optional cosmetic-only mobile model) |
| **Estimated Scope** | Small-Medium (3-6 weeks MVP, 3-6 months full vision, solo) |
| **Comparable Titles** | Candy Crush Saga (level structure), Two Dots (atmosphere + tension), 10000000 (mid-core match-3 with mechanical teeth) |

---

## Core Fantasy

You are the last-ditch survivor who outsmarts a rising tide. The graveyard is overrun, the infection is spreading, and you have a finite number of moves before it consumes everything. But you have something the dead don't — pattern recognition, combo timing, and the cool head to cascade your way out of impossible spots.

The fantasy is mechanical victory under pressure, dressed in cute-horror flavor. It's not "survive a horror movie" — it's "outsmart a horror movie *every turn*." Every cascade is a small triumph; every level barely-won is a story you'll replay in your head.

---

## Unique Hook

**Like Candy Crush, AND ALSO every turn the board fights back — the tiles you don't match become the next turn's problem.**

Reactive infection spread turns the act of matching into a containment puzzle. In Candy Crush, ignoring half the board is fine; in Graveyard Shift, the half you ignore *spreads*. This single rule layered on top of familiar match-3 mechanics produces an entirely different mental model: every move is offense *and* defense, simultaneously.

The hook affects gameplay (it's not just aesthetic), is explainable in one sentence, is genuinely novel (no major match-3 leader uses reactive spread), and is connected to the core fantasy (the rising tide, the survivor's pressure).

---

## Player Experience Analysis (MDA Framework)

### Target Aesthetics (What the player FEELS)

| Aesthetic | Priority | How We Deliver It |
| ---- | ---- | ---- |
| **Sensation** (sensory pleasure) | 2 | Cascade pop SFX, screen shake on combos, zombie-purge particle bursts, satisfying tile squish |
| **Fantasy** (make-believe, role-playing) | 4 | Graveyard atmosphere, "cute horror" tone, "Zombies Are Friends!" voice |
| **Narrative** (drama, story arc) | N/A | Anti-pillar A4 — no narrative chapter; flavor only |
| **Challenge** (obstacle course, mastery) | 1 | Reactive infection spread, hand-authored clutch levels, 7-tile difficulty floor, no RNG salvation |
| **Fellowship** (social connection) | N/A | Single-player, no leaderboards (anti-pillar A2) |
| **Discovery** (exploration, secrets) | 5 | System mastery — discovering optimal containment patterns, power-up timing |
| **Expression** (self-expression, creativity) | N/A | Level-based, not run-based; no build/loadout variety |
| **Submission** (relaxation, comfort zone) | 3 | Cascade juice on the surface keeps base loop comfort-food familiar even as depth runs deep |

### Key Dynamics (Emergent player behaviors)

- Players will subconsciously evaluate **"what won't I match"** before each move — the unmatched tiles become as cognitively loaded as the matched ones.
- Players will deploy **power-ups during clutch moments**, not as routine. The 3-charge limit reinforces save-for-emergencies behavior.
- Players will replay levels they barely won, looking for **cleaner three-star solutions**.
- Players will identify "spread sources" on each board (where infection clusters) and prioritize matches that interrupt spread chains over matches that score most.

### Core Mechanics (Systems we build)

1. **8×8 reactive match-3 grid** with 6 base tile types: brain, eyeball, bone, slime, gravestone, bandages. **Zombie is a tile STATE (infection overlay), not a tile type.** Any base tile can become infected — it retains its original type for matching purposes but gains a zombie appearance and infection behavior. Matching 3+ infected tiles of the same base type clears the overlay and the tiles simultaneously, collecting toward goals normally. Infection spreads the overlay; the underlying tile type is never replaced.
2. **Reactive infection spread** — tiles you didn't match this turn convert nearby tiles to zombies on the next turn
3. **Goal-collection win condition** with star ratings (1-3 stars based on moves remaining at win)
4. **Hand-authored level templates** — initial board state, infection seeds, goal targets, move budget
5. **Three power-ups** (poison bomb, healing potion, shovel) with limited charges per level

---

## Player Motivation Profile

### Primary Psychological Needs Served

| Need | How This Game Satisfies It | Strength |
| ---- | ---- | ---- |
| **Autonomy** | Every turn presents 5-15 meaningful match options; power-up timing is fully player-driven; no forced moves or auto-play | Supporting |
| **Competence** | Reactive spread teaches optimal play through pain (no tutorial wall); star ratings reward mastery; hand-authored levels scale skill expression precisely | Core |
| **Relatedness** | Minimal — flavor-level relatedness via the "Zombies Are Friends" tone, the recurring zombie mascot in goal panel | Minimal |

### Player Type Appeal (Bartle Taxonomy)

- [x] **Achievers** — How: Star ratings per level, chapter completion progress, "all 3-star" mastery goal
- [x] **Explorers** — How: Discovering optimal containment patterns, finding non-obvious power-up uses, mastering the spread system
- [ ] **Socializers** — Not served; anti-pillar A2 excludes social features
- [ ] **Killers/Competitors** — Not served; no leaderboards or PvP

### Flow State Design

- **Onboarding curve**: First 3 levels teach the basic match-3 verb. Level 4 introduces reactive spread (no popup — the player simply observes a zombie appearing where they didn't match). Levels 5-10 stack complications. Reactive spread is self-teaching by design.
- **Difficulty scaling**: Each level is hand-authored to produce a clutch moment for the target skill curve. Spread severity, board size, goal counts, and power-up availability tune challenge.
- **Feedback clarity**: Cascade animation shows scoring; infection spread animation shows board state mutation; star count and goal counters communicate progress every turn.
- **Recovery from failure**: Levels are short (3-5 min). Lose = immediate retry, no penalty, no economy gating, no ad watch. Failure is educational (player sees what spread, where they were inefficient).

---

## Core Loop

### Moment-to-Moment (30 seconds)
Player scans the 8×8 board, identifies a match (3+ same-type tiles in a row/column), drags to swap. Match resolves with cascading pop juice — pieces clear, new ones fall, secondary cascades trigger, score ticks up. Then: tiles the player **didn't** match contribute to the next turn's infection spread. **Board refill policy**: new tiles that fall in after a clear follow a fixed, hand-authored queue defined per level — every run of a given level produces the same tile sequence. This keeps the board fully deterministic and supports precise clutch-moment design without RNG variance. Combo banner appears on chains of 4+; screen shakes on ×3 cascade or higher. Audio + visual feedback confirms every action.

### Short-Term (5-15 minutes)
**A single level.** Player opens to a starting board with 1-3 infection seeds, a goal panel (e.g., "25 brains, 15 RIPs, 20 bones"), and a move budget (typically 15-25 moves). Plays 10-25 turns. Mid-level pivot is universal — the first ~8 turns the infection appears to be winning, then the player finds a power-up moment or chain that shifts momentum. Last 3-5 turns are the clutch zone: set up the winning chain or lose. Resolves with star rating (1-3 based on moves remaining) and a small reward animation.

### Session-Level (30-60 minutes)
A linear chapter map (Graveyard biome for MVP). 5-8 levels per chapter. "One more level" hook driven by every level introducing a new tile arrangement, new infection seed pattern, or new power-up tactic. Natural stopping point at chapter end. Off-screen retention: mental replay of "I almost had it on level 12 — what if I'd used the shovel on turn 5?"

### Long-Term Progression
Linear progression through hand-authored levels. No meta-economy, no persistent currency, no leveling. Power-ups are unlocked by progression (level X unlocks power-up Y), not bought. "Game complete" = beat the final level of the Graveyard biome. Optional 3-star replay loop for completionists. Post-MVP scope tiers add additional biomes (Crypt, Catacombs, Cathedral) with their own infection variants.

### Retention Hooks

- **Curiosity**: What does the next chapter's biome look like? What's a "Crypt" infection variant? What's the final level?
- **Investment**: Star count progress; chapter completion percentage; the levels you almost-but-not-quite three-starred
- **Social**: None (anti-pillar A2)
- **Mastery**: 3-star runs require optimal play; spread-tactics improvement is visible across sessions

---

## Game Pillars

### Pillar 1: Every Match Matters
Every move on the board has consequence — what you don't match comes back to bite you.

*Design test*: When debating between "give the player slack/recovery" vs "let the consequence land directly," we choose **direct consequence**.

### Pillar 2: Juice Without Compromise
Cascade pops, zombie purges, screen shake — fun-feel is a feature, not polish.

*Design test*: When debating between adding a feature vs polishing an existing one to feel better, we choose **polish**.

### Pillar 3: The Clutch Is The Point
Levels are tuned so almost-losing-then-winning is the modal experience. We design for last-move escapes.

*Design test*: When debating "easier" vs "harder" tuning on a level, we choose **the version that produces the clutch moment** — even if it's harder.

### Pillar 4: Friendly Menace
Horror is theming, not threat. Zombies are antagonists you outsmart, not nightmares you flee from.

*Design test*: When debating "this asset feels scarier" vs "this asset feels playful/cute," we choose **playful**.

### Pillar 5: One Hand, Three Minutes
Snackable, touch-first. A level fits a waiting room or a coffee break.

*Design test*: When debating "deeper systems require more screen / longer levels" vs "stays snackable," we choose **snackable**.

### Anti-Pillars (What This Game Is NOT)

- **NOT grimdark.** No realistic horror, jump scares, or psychological dread. Compromises P4 Friendly Menace.
- **NOT a persistent meta game.** No daily challenges, leaderboards, battle passes, or character leveling. Compromises P5 One Hand, Three Minutes and balloons scope past weeks.
- **NOT RNG-salvageable.** No "watch ad for extra moves," random shuffles when stuck, or pity-timer power-up grants. Compromises P1 Every Match Matters.
- **NOT tutorial-walled.** No tutorial chapter that gates content. Reactive spread teaches the rule through play; a tutorial wall would compromise P5 and disrespect the player.

---

## Inspiration and References

| Reference | What We Take From It | What We Do Differently | Why It Matters |
| ---- | ---- | ---- | ---- |
| **Candy Crush Saga** | Cascade juice, level-based progression, goal-collection win conditions, snackable session length | Reactive board (board fights back); no RNG salvation; no F2P pity timers | Validates the level-based mobile match-3 audience exists in massive numbers |
| **Balatro** | Combinatorial depth in a familiar genre wrapper; clutch run moments; "easy to play, hard to master" curve | Match-3 frame instead of poker; level-based instead of run-based; tension via spread instead of joker stacking | Validates that mid-core players want mechanical teeth in casual genres |
| **Dead Cells** | Tight game-feel; pixel art that looks expensive but is actually disciplined; failure-friendly retry loop | 2D match-3 puzzle vs metroidvania action; static levels vs procgen | Validates the pixel-horror aesthetic for indie commercial success |
| **Two Dots** | Atmospheric tension layered onto a casual genre; minimalist UI carrying mood | Pixel-horror tone vs minimalist beauty; reactive board vs static puzzles | Closest direct comparable for "atmospheric tension match-3" — proves the niche exists but is underexplored |

**Non-game inspirations**: Tim Burton-style cute-gothic iconography (Nightmare Before Christmas, Corpse Bride), Halloween cartoon traditions (It's the Great Pumpkin, Charlie Brown), Don't Starve's hand-drawn cute-creepy aesthetic, classic graveyard horror tropes seen through a bubblegum filter.

---

## Visual Identity Anchor

**Direction name:** Saturated Pixel-Horror That Smiles

**One-line visual rule:** *Every visual must read as "cute horror" — chunky retro pixels, juicy saturation, real menace dressed in Halloween costume.*

### Supporting Principles

1. **Pixel-first, no compromises.** All sprites, UI, VFX use limited-palette pixel art at a consistent resolution.
   *Design test*: If a particle effect or shader could read as "modern smooth FX," we redo it in pixel chunks.

2. **Saturated, not desaturated.** Purples, greens, blood-reds at high saturation. The night sky is dramatic purple, not flat black; slime is electric green, not muddy.
   *Design test*: If an asset feels grimy or washed out, we push the saturation slider until it reads candy-shop-haunted-house.

3. **Cartoon menace, not real menace.** Zombies have googly eyes, gravestones are clip-art chunky, hands burst out of the ground in a "boo!" way — never realistic gore or body horror.
   *Design test*: If an asset would scare a 9-year-old, we cute it up.

### Color Philosophy

Deep purple skies + neon-green slime + bone-white highlights + blood-red accents reserved for key feedback (combo hits, infection spread). Background atmospheric, foreground readable. The board is the readable focal plane; the world behind it is mood-setting saturation.

This anchor is the seed of the art bible. Every asset spec must trace back to this rule.

---

## Target Player Profile

| Attribute | Detail |
| ---- | ---- |
| **Age range** | 22-45 |
| **Gaming experience** | Mid-core — plays mobile match-3 *and* at least one mechanically deep game |
| **Time availability** | 3-10 minute commute or waiting-room sessions on weekdays; longer evening / weekend sessions |
| **Platform preference** | Mobile primary; some PC/Web spillover |
| **Current games they play** | Candy Crush Saga + Balatro / Slay the Spire / Vampire Survivors / Brotato |
| **What they're looking for** | A match-3 with mechanical teeth — actually challenging, not pity-timer-cushioned. Pixel-art aesthetic that feels intentional, not hobbyist. Snackable but mentally engaging. |
| **What would turn them away** | Pay-to-win economy, ads-for-extra-moves, lazy procgen levels, washed-out generic horror tone, mandatory social/leaderboard gating |

---

## Technical Considerations

| Consideration | Assessment |
| ---- | ---- |
| **Recommended Engine** | Godot 4.6 — already pinned to project. Excellent 2D pipeline, pixel art is sweet spot, mobile exports clean (Compatibility renderer for broadest device support). |
| **Key Technical Challenges** | (1) Tuning reactive spread to feel fair across difficulty curve. (2) Mobile touch UX — drag-to-swap gesture under thumb. (3) Maintaining 60 FPS during heavy cascade chains on low-end Android. |
| **Art Style** | Pixel art (saturated, cute-horror). Limited palette, consistent pixel resolution (likely 16×16 or 32×32 per tile). |
| **Art Pipeline Complexity** | Medium — custom pixel art, but disciplined tile/animation count keeps it tractable for solo. |
| **Audio Needs** | Moderate — 2-3 ambient chiptune loops, ~15 SFX (pop, purge, infection-spread, win, lose, button taps, power-up activations). Adaptive mix optional. |
| **Networking** | None |
| **Content Volume** | MVP: 15-20 hand-authored levels, 1 biome, 7 tile types, 3 power-ups |
| **Procedural Systems** | None for MVP — every level is hand-authored. Procgen out of scope. |

---

## Risks and Open Questions

### Design Risks

- **Reactive spread balance is the existential design risk.** If spread feels unfair or punishing on early levels, players quit before learning the system. Mitigation: explicit prototype validation in Phase 1, conservative spread rates on first 5 levels.
- **6-tile difficulty floor may be too steep.** 6 base tile types means matches are rarer than 4-5-type boards. Could create early-level frustration. Mitigation: start levels at 4 active types, introduce types progressively across early levels (level 1 = 4 types, level 5 = 5 types, level 8+ = all 6). Note: zombie infection state is an overlay and does not count as a tile type for match frequency calculations.
- **Clutch tuning per-level requires authorial discipline.** Hand-authoring 15+ levels that *all* produce the clutch moment is non-trivial. Mitigation: define a level-design checklist that names the clutch moment explicitly per level.

### Technical Risks

- **Mobile touch input precision on smaller devices.** Drag-swap gestures need a comfortable hit zone; small phones may struggle. Mitigation: tile size > 60dp minimum, swipe forgiveness for adjacent-cell intent.
- **Cascade chain performance on low-end Android.** Heavy cascades trigger many simultaneous tweens; old devices may stutter. Mitigation: object pooling for tile sprites, simplified VFX on perf-budget mode.

### Market Risks

- **Casual match-3 market is saturated.** Differentiation depends entirely on the hook landing. If "board fights back" doesn't read clearly in screenshots/GIFs, marketing dies. Mitigation: visual marketing assets must show the spread happening on first frame.
- **Mid-core audience overlap with casual is unproven.** Players who like Balatro AND Candy Crush exist, but reaching them as a single audience requires careful store-page positioning. Mitigation: dual store positioning — "casual hook, hardcore depth."

### Scope Risks

- **Level authoring time.** 15-20 hand-crafted puzzles at ~30 min author + 30 min playtest each = ~15-20 hours of pure level design. Realistic, but this is where overruns happen. Mitigation: lock the move-budget formula early, limit level authoring to weeks 2-3 only.
- **Pixel art animation creep.** Static art is cheap; animated art balloons. Mitigation: hard-cap animation to one cycle per tile type + 3 ambient zombie animations + explosion frames.

### Open Questions

- **What is the optimal swap gesture on mobile — drag-to-swap or tap-source-then-tap-target?** Resolution: prototype both, A/B test in week 2.
- **What infection spread rate per level produces the clutch moment 70% of the time?** Resolution: parametric tuning during level authoring; document target spread rate in level template.
- **How many tile types should be active per level?** Resolution: introduce types progressively (level 1 = 4 types, level 5 = 6 types, level 8+ = 7 types).

---

## MVP Definition

**Core hypothesis**: *"The reactive spread mechanic creates clutch last-move moments that players find satisfying within 3-minute mobile sessions."*

**Playtest validation criteria (PASS requires both gates):**
- **Feel gate**: ≥50% of playtesters spontaneously describe a level as "close," "tense," or "almost lost it" without being prompted — measured via brief debrief after each session.
- **Time gate**: Median session length across all playtested levels is 3–7 minutes — measured by timer from level-start to level-end (win or lose).
- **Sample**: Minimum 5 independent playtest sessions across at least 3 different levels before verdict.

If both gates pass, the hypothesis is confirmed and the rest of the game is a content problem (more levels, more biomes). If either gate fails, the hook is wrong and we redesign before expanding.

**Required for MVP**:
1. **8×8 reactive match-3 grid** with 7 tile types — directly tests core mechanic
2. **Reactive infection spread system** with tunable spread rate per level — the hook itself
3. **3 power-ups** (poison bomb, healing potion, shovel) with charge limits — supports clutch moment design
4. **15 hand-authored levels** in 1 biome (Graveyard) — sufficient sample size to validate hypothesis
5. **Win/lose flow** with star rating (1-3 stars based on moves remaining)
6. **Level select map** for the 15 levels
7. **Audio polish** — cascade pop, purge, infection spread SFX + 1 ambient loop

**Explicitly NOT in MVP** (defer to later):
- Save/resume across app launches
- Settings menu beyond audio toggle
- Additional biomes (Crypt, Catacombs, Cathedral)
- Achievements / 3-star meta-completion screen
- Daily challenges
- Monetization integration
- Cosmetics
- Animated zombie character beyond goal panel
- Tutorial popups (reactive spread is self-teaching)

### Scope Tiers (if budget/time shrinks)

| Tier | Content | Features | Timeline |
| ---- | ---- | ---- | ---- |
| **MVP** | 1 biome, 7 tiles, 1 spread mechanic, 3 power-ups, 15 levels, basic juice | Core loop, level select, win/lose flow | 3-4 weeks |
| **Vertical Slice** | Same as MVP, fully polished | + save/resume, settings, intro splash, audio polish | 5-6 weeks |
| **Alpha** | + Crypt biome, infection variant | + achievements, 3-star meta, polish pass | 8-10 weeks |
| **Full Vision** | 4 biomes, 5+ infection variants, 60+ levels | + daily challenge, optional cosmetics, full mobile monetization | 3-6 months |

---

## Next Steps

- [ ] Run `/setup-engine` to lock Godot 4.6 + populate technical-preferences and engine reference
- [ ] Run `/art-bible` to formalize the Visual Identity Anchor into a full asset production specification
- [ ] Run `/design-review design/gdd/game-concept.md` to validate concept completeness
- [ ] Run `/map-systems` to decompose this concept into per-system GDDs (match engine, infection system, level system, power-up system, UI/HUD, audio)
- [ ] Author per-system GDDs with `/design-system [system-name]` in dependency order
- [ ] Run `/create-architecture` to produce the master architecture blueprint and Required ADR list
- [ ] Record key architectural decisions with `/architecture-decision` (×N per Required ADR list)
- [ ] Run `/gate-check pre-production` to validate readiness for the production phase
- [ ] Prototype the riskiest mechanic with `/prototype reactive-infection-spread`
- [ ] Validate the prototype with `/playtest-report`
- [ ] If validated, plan the first sprint with `/sprint-plan new`
