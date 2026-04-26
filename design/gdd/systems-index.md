# Systems Index: Graveyard Shift

> **Status**: Approved
> **Created**: 2026-04-25
> **Last Updated**: 2026-04-25
> **Source Concept**: design/gdd/game-concept.md

---

## Overview

Graveyard Shift is a moves-limited match-3 puzzle game where infection spreads from unmatched tiles each turn. The mechanical scope is deliberately tight: a single-screen 8×8 board, one spread mechanic, three power-ups, and 15 hand-authored levels. All 12 systems serve the core hypothesis — that reactive infection spread creates satisfying clutch moments within 3-minute mobile sessions. There is no meta-economy, no procedural content, and no networking. The two highest-risk systems are the Match-3 Grid Engine (the most complex interface in the project, with 4 dependents) and the Infection Spread System (the game's existential design risk). Both should be prototyped early regardless of design order.

---

## Systems Enumeration

| # | System Name | Category | Priority | Status | Design Doc | Depends On |
|---|---|---|---|---|---|---|
| 1 | Tile State Model | Core | MVP | Not Started | — | — |
| 2 | Level Definition System | Core | MVP | Not Started | — | — |
| 3 | Match-3 Grid Engine | Core | MVP | Not Started | — | Tile State Model, Level Definition |
| 4 | Infection Spread System | Gameplay | MVP | Not Started | — | Tile State Model, Level Definition, Match-3 Grid Engine |
| 5 | Input Handler / Gesture System *(inferred)* | Core | MVP | Not Started | — | Tile State Model |
| 6 | Goal Tracker *(inferred)* | Gameplay | MVP | Not Started | — | Tile State Model, Level Definition, Match-3 Grid Engine |
| 7 | Power-Up System | Gameplay | MVP | Not Started | — | Tile State Model, Level Definition, Match-3 Grid Engine |
| 8 | Win / Lose Flow | Gameplay | MVP | Not Started | — | Goal Tracker, Level Definition |
| 9 | Level Select System | Progression | MVP | Not Started | — | Win / Lose Flow |
| 10 | Visual Feedback / Juice System *(inferred)* | UI | MVP | Not Started | — | Match-3 Grid Engine, Infection Spread System |
| 11 | UI / HUD *(inferred)* | UI | MVP | Not Started | — | Goal Tracker, Power-Up System, Win / Lose Flow, Match-3 Grid Engine |
| 12 | Audio System | Audio | MVP | Not Started | — | Match-3 Grid Engine, Infection Spread System, Win / Lose Flow |
| 13 | Save / Resume | Persistence | Vertical Slice | Not Started | — | Win / Lose Flow, Level Select |
| 14 | Settings | Meta | Vertical Slice | Not Started | — | Audio System |
| 15 | Intro Splash | UI | Vertical Slice | Not Started | — | — |

---

## Categories

| Category | Description |
|---|---|
| **Core** | Foundation systems everything depends on — data models, input, grid management |
| **Gameplay** | Systems that make the game work — spread mechanic, goal tracking, power-ups, win/lose |
| **Progression** | How the player advances — level unlock, completion state |
| **Persistence** | Save state and continuity — save/load, settings |
| **UI** | Player-facing information and feedback — HUD, visual juice, menus |
| **Audio** | Sound and music systems |
| **Meta** | Systems outside the core game loop — settings, analytics |

---

## Priority Tiers

| Tier | Definition | Systems |
|---|---|---|
| **MVP** | Required to validate the core hypothesis: reactive spread creates clutch moments in 3-min sessions | 12 systems (#1–#12) |
| **Vertical Slice** | Required for a polished, releasable-quality experience beyond the hypothesis test | 3 systems (#13–#15) |
| **Alpha** | Not applicable — scope is fully covered by MVP + Vertical Slice for this game | — |
| **Full Vision** | Additional biomes, infection variants, daily challenges, cosmetics — content, not systems | — |

---

## Dependency Map

### Foundation Layer (no dependencies — design first)

1. **Tile State Model** — shared data definition for all 6 base tile types and the infection overlay state; every other system references this; wrong here = revision cascade everywhere
2. **Level Definition System** — authored data schema for tile queue, infection seeds, goal targets, and move budget; must be stable before any level-reading system is written

### Core Layer (depends on Foundation)

1. **Match-3 Grid Engine** — depends on: Tile State Model, Level Definition System
2. **Input Handler / Gesture System** — depends on: Tile State Model (grid coordinates, board dimensions)
3. **Infection Spread System** — depends on: Tile State Model, Level Definition System, Match-3 Grid Engine
4. **Goal Tracker** — depends on: Tile State Model, Level Definition System, Match-3 Grid Engine
5. **Power-Up System** — depends on: Tile State Model, Level Definition System, Match-3 Grid Engine

### Feature Layer (depends on Core)

1. **Win / Lose Flow** — depends on: Goal Tracker, Level Definition System
2. **Level Select System** — depends on: Win / Lose Flow

### Presentation Layer (depends on Feature/Core)

1. **Visual Feedback / Juice System** — depends on: Match-3 Grid Engine, Infection Spread System
2. **UI / HUD** — depends on: Goal Tracker, Power-Up System, Win / Lose Flow, Match-3 Grid Engine
3. **Audio System** — depends on: Match-3 Grid Engine, Infection Spread System, Win / Lose Flow

### Post-MVP Layer

1. **Save / Resume** — depends on: Win / Lose Flow, Level Select System
2. **Settings** — depends on: Audio System
3. **Intro Splash** — no gameplay dependencies

---

## Recommended Design Order

| Order | System | Priority | Layer | Effort |
|---|---|---|---|---|
| 1 | Tile State Model | MVP | Foundation | S |
| 2 | Level Definition System | MVP | Foundation | M |
| 3 | Match-3 Grid Engine | MVP | Core | L |
| 4 | Infection Spread System | MVP | Core | M |
| 5 | Input Handler / Gesture System | MVP | Core | M |
| 6 | Goal Tracker | MVP | Core | S |
| 7 | Power-Up System | MVP | Core | M |
| 8 | Win / Lose Flow | MVP | Feature | S |
| 9 | Level Select System | MVP | Feature | S |
| 10 | Visual Feedback / Juice System | MVP | Presentation | M |
| 11 | UI / HUD | MVP | Presentation | M |
| 12 | Audio System | MVP | Presentation | S |

*Effort: S = 1 design session, M = 2–3 sessions, L = 4+ sessions*

*Systems at the same layer with no shared dependencies can be designed in parallel.*

---

## Circular Dependencies

None found. The dependency graph is a directed acyclic graph — all systems flow from Foundation → Core → Feature → Presentation.

---

## High-Risk Systems

| System | Risk Type | Risk Description | Mitigation |
|---|---|---|---|
| Infection Spread System | Design | Spread rate tuning is the existential design risk — too fast feels unfair, too slow removes tension. The core hypothesis lives or dies here. | Prototype before full GDD authoring; validate with `/playtest-report` before writing level GDDs |
| Match-3 Grid Engine | Technical | Cascade resolution contract — 4 systems depend on the event/callback interface this system exposes. Wrong boundary here = expensive rework across 4 GDDs. | Design the public API (event types, data payloads) explicitly in the GDD before implementation |
| Input Handler | Technical | Mobile touch on low-end devices — drag-to-swap gesture needs ≥60dp hit zones and adjacent-cell forgiveness; small phones may still struggle | Prototype on smallest target device (low-end Android) before committing to drag-to-swap UX |
| Level Definition System | Scope | 15–20 fully authored tile queues is significant authoring overhead — each queue specifies every tile that falls in per turn | Evaluate queue authoring time on first 3 levels; consider a seeded-random fallback if authoring overhead is too high |

---

## Progress Tracker

| Metric | Count |
|---|---|
| Total systems identified | 15 |
| MVP systems | 12 |
| Vertical Slice systems | 3 |
| Design docs started | 0 |
| Design docs reviewed | 0 |
| Design docs approved | 0 |
| MVP systems designed | 0 / 12 |

---

## Next Steps

- [x] Enumerate and approve systems (2026-04-25)
- [ ] Run `/design-system tile-state-model` — first in design order
- [ ] Prototype Infection Spread System before its GDD is finalised (`/prototype infection-spread`)
- [ ] Run `/design-review` on each completed GDD
- [ ] Run `/gate-check pre-production` when all 12 MVP systems are designed and approved
