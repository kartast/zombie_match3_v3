# Art Bible: Graveyard Shift

*Created: 2026-04-25*
*Status: Sections 1-8 complete (Section 8 partial — technical-artist budget pass deferred). Section 9 deferred to /asset-spec.*

> **AD-ART-BIBLE skipped — Lean mode.** No creative-director sign-off gate at art-bible level; gates run at phase transitions (next: pre-production phase gate).

> The art bible is a constraint document. It restricts future visual decisions in exchange for visual coherence across the whole project. Every section narrows the solution space productively. When this bible and a request conflict, the bible wins.

---

## 1. Visual Identity Statement

### One-Line Visual Rule

> **"Every pixel must read as cute horror — chunky retro, candy-saturated, Halloween-costume menace."**

This is the master rule. Every other visual decision in this project resolves through it.

### Supporting Visual Principles

#### P1. Pixel-First, No Exceptions

All sprites, UI elements, and VFX are built in chunky, limited-palette pixel art at a consistent tile resolution. There is no mixing of pixel art with smooth gradients, anti-aliased geometry, or modern particle systems.

*Design test*: When a VFX request could be solved with a smooth shader or a pixelated burst — choose the pixelated burst. If it could pass for a Unity mobile game made in 2023, it's wrong.

*Pillar anchor*: **Juice Without Compromise** — juice that breaks the pixel contract breaks the aesthetic, which breaks the tone.

#### P2. Saturated to the Point of Candy

The palette runs hot: deep purple skies, electric-green slime, blood-red infection, bone-white highlights. No asset is allowed to read as grimy, washed-out, or muddy.

*Design test*: When an asset looks "appropriately dark and spooky," push saturation until it reads as a Halloween-store window display. Dark is fine; desaturated is not.

*Pillar anchor*: **Friendly Menace** — high saturation is the primary signal that this horror is costumed, not real.

#### P3. Googly Eyes, Not Gore

Zombies shuffle with oversized heads and cartoon expressions. Gravestones are clip-art chunky with "RIP" in bubbly lettering. Infection spread is glowing green slime, not rot. Nothing depicts realistic body horror, blood that reads as fluid, or expressions of genuine pain.

*Design test*: Show the asset to a 9-year-old. If their reaction is discomfort rather than delight, it fails. The target reaction is "ew, gross, I love it."

*Pillar anchor*: **Friendly Menace** — the zombie is the antagonist you outsmart with a smirk, not the horror you recoil from.

### Rationale

The core fantasy is "mechanical victory under pressure, dressed in cute-horror flavor." The visual identity exists to deliver that dressing without undermining the pressure. Saturated pixels keep the board readable and juice visible under mobile screen conditions. The Halloween-costume tone ensures infection spread reads as a fun challenge, not dread — players retry rather than quit. Every visual choice that makes the game look more threatening or more modern works against both goals simultaneously.

---

## 2. Mood & Atmosphere

Each major game state targets a distinct emotional read. All six live within the saturated cute-horror language — distinction comes from palette, animation density, and mood-carrier elements, never from breaking the pixel-first principle.

### Title Screen / Splash

- **Primary emotion**: Anticipation — "something delightfully wrong is about to start"
- **Lighting character**: Cool violet ambient with a single warm-amber key light from below (classic horror uplighting, pixel-stepped, no gradients). High contrast. Static.
- **Atmospheric descriptors**: Theatrical, velvety, carnival-after-dark, beckoning, slightly-off
- **Energy level**: Contemplative with a pulse — idle animations breathe slowly, one beat per ~2 seconds
- **Mood carrier**: A single animated graveyard lantern in the background cycles warm amber → sickly green on a 3-second loop, casting a hard pixel shadow that flickers one frame per cycle

### Level Select Map

- **Primary emotion**: Curiosity — "I want to see what's behind that tombstone"
- **Lighting character**: Bright overcast — flat, candy-saturated, no dominant key light. Mid-contrast. Reads like a haunted theme park at dusk: cheery but slightly wrong.
- **Atmospheric descriptors**: Playful, cartographic, sugar-coated, slightly overgrown, collectible
- **Energy level**: Measured — map elements idle with gentle 2-frame wobbles; completed nodes pulse with a tiny star particle
- **Mood carrier**: Infection vines creep outward from locked future levels (1-2 frames per second). Decorative here, not threatening, but plants the visual vocabulary early.

### In-Level: Low Pressure

- **Primary emotion**: Confident — "I see the board, I have options"
- **Lighting character**: Warm sunset palette, amber-to-mauve. Soft, even illumination. Low contrast between background and tile grid. Board reads open.
- **Atmospheric descriptors**: Breezy, warm, inviting, slightly mischievous, spacious
- **Energy level**: Measured — background grave sprites do slow idle bobs; infection cells are still, minimal particle count
- **Mood carrier**: Background moon sits high and calm, full and cream-colored; a single slow bat crosses the screen every 8-10 seconds

### In-Level: High Pressure / Clutch Zone

- **Primary emotion**: Dread-excitement — "I might actually pull this off"
- **Lighting character**: Palette cools and shifts — amber purged, replaced by acid green and electric purple. Background darkens by approximately 30% in pixel-stepped luminance bands (no gradient; swap to a darker palette row). Contrast between infection cells and board tiles spikes hard.
- **Atmospheric descriptors**: Electric, urgent, claustrophobic, crackling, inevitable
- **Energy level**: Breath-held — animations speed up one frame-rate tier; background bats multiply to 3-4 crossing simultaneously; infection cell edges gain a 1-pixel animated pulse outline
- **Mood carrier**: Background moon shifts from cream to sickly green (palette swap, single frame); thin lightning-bolt particle sprites arc between infection clusters every 2-3 seconds (pixel-stepped, 3-frame animation)

#### Low-to-High Pressure Transition (Critical)

- **Trigger**: Last 4 moves remaining OR infection occupies more than 40% of the board, whichever comes first
- **Execution**: Abrupt 1-frame palette swap on the background layer. No smooth fade. The shift feels like a switch flipping, not an interpolation.
- **Reinforcement**: Moon palette swap (cream → sickly green) on the same frame, bat count rises from 1 to 3-4, lightning particles begin arcing between infection clusters
- **Pixel-first compliance**: All mood change communicated via palette swaps, animation rates, and particle sprite counts. Zero gradients. Zero post-processing. Zero blur.

This transition is the most important visual moment in the game — it is how "the board fights back" reads as a feeling, not just a mechanic.

### Win State

- **Primary emotion**: Triumph — small, warm, well-earned
- **Lighting character**: Palette explodes to maximum candy saturation — every hue bumped one notch. Background floods with warm gold light (palette-swapped background tiles). High key, low shadow.
- **Atmospheric descriptors**: Fizzy, golden, celebratory, ridiculous, briefly chaotic
- **Energy level**: Frenetic for 1.5 seconds (particle burst), then settles to measured for star reveal
- **Mood carrier**: Zombies on the board do a single 4-frame "surprised splat" death animation before dissolving into candy-colored star particles. Googly eyes pop off as separate sprites and bounce away.

### Lose State

- **Primary emotion**: Rueful amusement — "the zombies got me this time, those little jerks"
- **Lighting character**: Palette shifts to deep purple with green accent — Halloween-night rather than Halloween-danger. Lower contrast than clutch zone; less urgent, more theatrical. One dramatic downward spotlight (pixel-stepped) on the "out of moves" banner.
- **Atmospheric descriptors**: Theatrical, mock-solemn, campy, forgiving, comedic
- **Energy level**: Measured — zombies do a slow victorious shuffle animation; no frantic energy
- **Mood carrier**: Infection tiles animate into tiny celebrating zombie sprites doing a 4-frame shuffle dance — they won, and they're delighted about it. Retry button is warm amber (never red) and pulses gently at a heartbeat rhythm to signal "come back in, the door's open."

---

## 3. Shape Language

### 3.1 Tile Silhouette Philosophy

**One rule**: Each tile must be readable by outline alone at 80×80px on a 5-inch screen. Color reinforces; shape decides. An artist should be able to fill every tile solid black and still name them instantly.

The 7 tiles divide into three silhouette families:

**Blob-organic family** — Brain, Eyeball, Slime. All three are round-ish, so their differentiators are aggressive:
- **Brain** — Horizontally-wide oval with a pronounced central crease bisecting it top-to-bottom. Two lobes. Never fully circular. *The crease is the tell.*
- **Eyeball** — Taller-than-wide oval (portrait, not landscape) with a single large circular iris occupying 55–60% of the face. *The shape-within-shape is the tell.*
- **Slime** — Asymmetric amoeba with exactly one drip extending downward, off-center. *The drip is the tell.* No hard edges anywhere on the perimeter.

**Angular-geometric family** — Bone, Gravestone. Visual rest stops; their hard edges make the board scannable.
- **Bone** — Two knobbed circular ends on a narrow rectangular shaft. Reads as a dumbbell. Knobs must be ≥1.4× shaft width.
- **Gravestone "RIP"** — Rectangle with a rounded arch top (tombstone arch, not semicircle). Flat base. *Arch-on-rectangle is unique in the set.*

**Blocky-organic family** — Zombie Head, Bandages. Chunky but not geometric.
- **Zombie Head** — Near-square head (1:1.1 aspect) with a noticeably wide jaw and a single offset ear stub. Reads as blockhead, not skull. *Ears are the tell.*
- **Bandages** — Rounded square with a visible diagonal wrap band across the face. *The diagonal stripe is the tell.*

*Pillar anchor*: **Every Match Matters**. If tiles blur together, matches stop feeling intentional. Silhouette distinctness is functional, not decorative.

### 3.2 Character & Creature Shape Language

All characters share three family traits:
- **Oversized heads** (60–65% of total height)
- **Undersized limbs** (stubby, max 2–3 pixel-segment limbs at tile scale)
- **One "too big" feature** — googly eyes, mouth wider than jaw, or one wildly offset ear

This creates family resemblance across zombies, hands-from-the-ground, and the goal-panel mascot. The mascot zombie gets one signature: a permanent 5–10° tilt so it reads as cheerfully falling apart, not threatening.

*Pillar anchor*: **Friendly Menace**. The "too big" feature is the menace; stubby proportions keep it cute.

### 3.3 Environment Geometry

The graveyard background uses **angular-leaning mixed language**:
- Gravestones and fence posts: boxy and imprecise (slightly crooked, slightly chipped)
- Dead trees: spindly with blunt branch ends — never fine pointed tips
- Distant church/crypt: stack of simple geometric masses (rectangle base, triangle roof, rectangular tower)

No organic blob shapes in the environment. The background must read as **hard world, soft tiles**. This contrast is what makes board tiles pop as the "living" layer.

*Pillar anchor*: **Juice Without Compromise**. The environment must recede so tile animations and cascades feel like they happen in front of a stage flat, not competing with it.

### 3.4 UI Shape Grammar

UI chrome echoes the world — deliberately rough, grave-marker-style:
- Score and goal panels use tombstone-arch frames (matching the Gravestone tile's arch)
- Corners are chipped and imprecise by 1–2 pixels
- Buttons are chunky rectangles with arch tops
- The only straight line permitted in UI frames is the flat base of a tombstone arch

UI does **NOT** use clean rounded rectangles or drop shadows. The UI is part of the Halloween costume, not a break from it.

*Pillar anchor*: **One Hand, Three Minutes**. The grave-marker frame reads the game's world at a glance — no mental gear-shift between "playing" and "reading score."

### 3.5 Hero Shapes vs Supporting Shapes

**Hero layer (board tiles, active VFX)**:
- Maximum silhouette contrast, maximum color saturation, widest value range (lightest highlights, darkest outlines in the game)
- 2px outline at all times
- Combo banners and cascade particles must never share a color with tiles they overlap

**Supporting layer (board grid, background)**:
- Flat mid-values only. No outlines.
- Grid lines are 1px, one step darker than background fill
- Dead trees and fencing use a desaturated value of the base palette's dark tone — silhouette only

*Pillar anchor*: **The Clutch Is The Point**. When a clutch combo fires, the VFX must be the single brightest, highest-contrast object on screen. Supporting shapes must be dim enough that a cascade reads as an event, not pattern noise.

### 3.6 Forbidden Shapes

These silhouette types break the world:

1. **Smooth perfect circles** — Any circle must show ≥1–2 pixels of flat or irregular edge. Perfect circles read as UI buttons, not game objects.
2. **Fine pointed spikes or thorns** — All branch ends, crowns, and jagged silhouettes must resolve to blunt 2–3 pixel stubs.
3. **Realistic human anatomy** — All anatomy must be exaggerated into the chunky-blockhead proportion system. No correct head-to-face ratios, no individually distinct fingers.
4. **Sharp angular tech shapes** — No hexagons, circuit-trace diagonals, or star polygons with >4 points. These read sci-fi, not graveyard.
5. **Gradient-implied silhouettes** — Every silhouette must close in flat pixel color. No shape may rely on a gradient to complete its read.

### 3.7 Validation TODOs

Pixel-sketch validation tasks for `/asset-spec` phase:

- [ ] **Slime drip orientation** — confirm tiles never rotate during cascade animations. If they can tumble, the off-center drip silhouette becomes ambiguous and needs reworking.
- [ ] **Bandages diagonal stripe** — most fragile silhouette feature at 80px. Test with pixel sketch before locking.
- [ ] **Tombstone-arch UI vs. Gravestone tile** — same shape vocabulary in two places. Test side-by-side in a board mockup to confirm they read distinctly (size + color + animation should disambiguate, but verify).

---

## 4. Color System

### 4.1 Primary Palette

| Name | Hex | Semantic Role | What It Means in Graveyard Shift |
|---|---|---|---|
| **Graveyard Night** | `#1A0F2E` | Outline / shadow anchor | The dark that makes every other color pop. Not pure black — reads as "moonlit shadow," the canvas the whole world sits on. |
| **Witch Purple** | `#3D1A5C` | Background atmosphere | The sky at night in a friendly haunted world. Signals "you are inside the horror" without threatening the player. Primary UI frame color. |
| **Candy Amber** | `#C87820` | Baseline sky warmth / calm state | Low-pressure mood color. Warm, harvest-fair, almost tasty. When this is visible you are safe. Its disappearance is the first warning. |
| **Combo Gold** | `#FFD53D` | Score / reward / celebration | Pure player joy. Every point, every match, every combo fires through this color. Sacred constant — never muddied, never shifted. |
| **Infection Acid** | `#39FF14` | Danger / infection spread | Neon near-black-light green. Visually aggressive even at 1-tile spread. Distinguishable from both tile greens by extreme value (near-white luminance). |
| **Candy Coral** | `#FF4D6D` | Energy / critical alerts / hearts | The warm-side danger register. Lives, timers in the red zone, brain-tile highlights. Pairs with Combo Gold for "urgent celebration." |
| **Cream Moon** | `#FFF5D6` | Calm-state moon / bone base | The benign white of early game. Appears in the moon, bone tiles, and bandage base before pressure rises. When it shifts, the player feels it. |

### 4.2 Tile Color Assignments

| Tile | Canonical | Highlight | Shadow | Resolution Notes |
|---|---|---|---|---|
| **Brain** | `#E8456A` | `#FF8FA3` | `#8C1A30` | Saturated pink-red. The only true red-family tile. |
| **Eyeball** | `#F2F2F2` sphere, `#2E9CCA` iris | `#FFFFFF` | `#B0B0B0` | White with blue-teal iris. Cool iris hue reads opposite to warm tiles. |
| **Bone** | `#F5DFA0` | `#FFF5D6` | `#C4A456` | Warm yellow-cream. Baked, sun-dried, brittle. |
| **Slime** | `#4DC94D` | `#80FF80` | `#1A7A1A` | Mid-value, medium-saturation green. Friendly, bubbly, "goofy blob." |
| **Gravestone** | `#7A7A8C` | `#A0A0B4` | `#40404E` | Cool desaturated blue-gray. Stone. Lowest saturation hierarchy on the board. |
| **Zombie Head** | `#7DCC5A` | `#AAFF7A` | `#3A6625` | **Yellow-green lean, high value.** Critically different from Slime — lighter, warmer, reads "sickly skin." Mandatory deuteranopia simulator pass before ship; fallback `#A0E860` if needed. |
| **Bandages** | `#E8D8B8` | `#FFF5E0` | `#A89060` | **Cool-neutral cream, lower chroma.** Bone is warm-yellow cream; Bandages are gray-white cream. Temperature opposition is the differentiator. |

**Slime vs Zombie greens** — Hue Δ ~8°, Value Δ ~30 pts. Distinguishable in healthy vision; colorblind audit in 4.7 covers risk.

**Bone vs Bandages creams** — Bone leans warm-yellow; Bandages lean cool-gray. Chroma Δ ~25 pts. Shape silhouette is primary backup cue.

### 4.3 Semantic Color Vocabulary

| Color Register | Player Reads It As |
|---|---|
| **Red / Pink** (Coral family) | Organic life — brains, hearts, body warmth. Also alert channel: lives low, timer critical. *"Alive and urgent."* |
| **Slime Green** (`#4DC94D`) | Goofy, bouncy, safe danger. A tile color, not a warning. |
| **Zombie Green** (`#7DCC5A`) | Sickly undead. Tile color reading as "transformed, corrupted biology." Warmer/brighter than Slime. |
| **Infection Acid** (`#39FF14`) | System threat. The board is being consumed. Impossible to ignore. *"Act now."* |
| **Witch Purple** (`#3D1A5C`) | The world itself. Atmosphere, safety within horror, UI chrome. |
| **Combo Gold** (`#FFD53D`) | Points. Combos. Rewards. Pure joy with no ambiguity. |
| **Cream Moon** (`#FFF5D6`) | Calm. The game is manageable. When this leaves the palette, pressure has arrived. |
| **Graveyard Night** (`#1A0F2E`) | Structure. Every hero-layer tile is bounded by this. Never a state signal — it is the container, not the content. |
| **Tool Blue** (eyeball iris / shovel) | Special actions and focus. Spatial-precision power-ups draw from this register. |

### 4.4 Per-State Palette Shifts

All transitions are 1-frame palette swap on the background layer. No gradient interpolation.

| Element | Calm State | High Pressure | Critical |
|---|---|---|---|
| Background sky | `#3D1A5C` Witch Purple | `#1A2E1A` Acid-cast deep green | `#1A0A2E` near-black purple-black |
| Moon | `#FFF5D6` Cream Moon | `#C8FF3C` Sickly chartreuse | `#39FF14` Infection Acid |
| Board vignette | None | Thin `#39FF14` inner glow | Pulsing `#39FF14` border (4-frame cycle) |
| Tile outline | `#1A0F2E` (sacred — never changes) | `#1A0F2E` | `#1A0F2E` |
| Background grave silhouettes | `#2A1545` | `#0D2010` | `#0A0A0A` |

The moon shift is the single most legible state indicator. Cream = friendly harvest moon. Acid green = something is very wrong. The player learns this within one session without a tutorial.

### 4.5 UI Palette Divergence

**World-tied (uses palette directly):**
- Panel frames / backgrounds: `#3D1A5C` Witch Purple with `#1A0F2E` 1px border
- Tombstone-arch decorative frames: `#7A7A8C` Gravestone gray
- Score area background: `#2A1545` (darkened Witch Purple)

**Diverged for readability:**
- Primary HUD text (score, timer): `#FFD53D` Combo Gold on `#1A0F2E` shadow
- Lives display: `#FF4D6D` Candy Coral hearts; `#F2F2F2` empty hearts
- Button resting: `#3D1A5C` frame, `#6B3FA0` fill (lighter purple, +1 value step)
- Button hover/press: `#9B5FD0` fill, `#FFD53D` label
- Button disabled: `#2A1A3E` fill, `#4A3A5A` text — desaturated, clearly inert
- Warning banners: `#FF4D6D` background, `#FFF5D6` text

**Rule**: UI text is never a tile color. This reserves tile colors as object identifiers only and prevents a bone-colored tooltip from being mistaken for a game element.

### 4.6 Power-Up Signature Colors

| Power-Up | Signature | Hex | Reasoning |
|---|---|---|---|
| **Poison Bomb** | Infection Acid Green | `#39FF14` | Intentional semantic merge with infection — the player weaponizes the threat color. The shared register is a feature. |
| **Purple Potion** | Royal Potion Purple | `#9B3DE8` | Sits above UI atmosphere purple in value — pops as object, not background. Carries "magical transformation" association. |
| **Blue Shovel** | Tool Blue | `#3A8FD1` | Only cool-blue object besides eyeball iris. Uniqueness guarantees visibility. Encodes "precision tool — pick a specific tile." |

All three are sacred constants (see 4.8).

### 4.7 Colorblind Safety Audit

**Deuteranopia / Protanopia (red-green deficiency — most common):**

| At-Risk Pair | Risk | Backup Cues |
|---|---|---|
| Brain vs Slime | HIGH — both shift toward brown/tan | Shape (folded vs blob) + highlight luminance delta |
| **Slime vs Zombie Head** | **CRITICAL** | Value delta load-bearing (Zombie ~30pts brighter); silhouette family difference (head vs blob); deuteranopia simulator pass mandatory pre-ship; fallback Zombie hex `#A0E860` if value delta fails |
| Infection Acid vs Slime | MEDIUM | Infection has 4-frame pulsing glow + jagged spike overlay icon |
| Bone vs Bandages | LOW | Temperature shrinks under deuteranopia but shape (rounded vs wrapped-rect) dominates; audio cue: bone "clack," bandages "thud" |

**Tritanopia (blue-yellow deficiency — less common):**

| At-Risk Pair | Risk | Backup Cue |
|---|---|---|
| Combo Gold vs Cream Moon | LOW | Combo Gold only as VFX text, never as a tile — no identification burden |
| Tool Blue Shovel vs Eyeball iris | LOW | Shovel is a power-up icon (distinct badge); cannot be confused with eyeball in play |

**Global fallback policy**: Every tile type has a unique silhouette family (Section 3). Color is the first-pass identifier. Shape is the guaranteed fallback. Animation loops are the tertiary cue. **No tile relies on color alone for identity.**

### 4.8 Sacred Constants

These NEVER change across game states, biomes, themes, or palette swaps. Any future asset that violates these is flagged as a blocking error.

| Constant | Hex | Reason |
|---|---|---|
| **Tile outline** | `#1A0F2E` | Structural grid of the game. If outlines shift, tile boundaries blur against background swaps. |
| **Combo Gold** | `#FFD53D` | Player reward must be unambiguous in every state. |
| **Infection Acid** | `#39FF14` | The alarm color must be the same alarm color always. Player muscle memory depends on it. |
| **UI text on dark** | `#FFF5D6` body / `#FFD53D` scores | Legibility is non-negotiable. Highest-contrast text colors against purple-black UI chrome. |
| **Power-up badge border** | `#1A0F2E` | All three power-ups share the same dark border so they read as a category before reading the individual icon. |

---

## 5. Character Design Direction

### 5.1 Visual Archetype Hierarchy (Cast Family Rules)

All five character types share a single silhouette grammar: **round head, tiny body, stubby limbs**. Head-to-body ratio: 55/45 minimum, 65/35 maximum, at any scale. Every character has at least one feature comically too large for its body — a jaw, an eye, a hand, a wingspan. **This "one wrong proportion" rule is the cast's visual fingerprint.**

Outlines are uniform: `#1A0F2E` at 1px weight across all characters at all scales. No character uses a lighter or colored outline as its primary edge — that would read as a different game. Skin tones stay within Zombie Green family (`#7DCC5A` ± 15% hue) for all undead; bats are the only non-zombie character type, using deep purple-grey (`#3D2459`) as base.

Result: even at 30px, a bat reads as "bat" and a zombie reads as "zombie," but both clearly live in the same graveyard.

### 5.2 Distinguishing Signature Features

| Character | Canonical Scale | Signature Feature | Disambiguation Read |
|---|---|---|---|
| Goal Panel Mascot Zombie | 120-200px tall | Permanent 5-10° head tilt + visible stitching on forehead | "The one leaning" |
| Board Zombie Tile | ~80px | Symmetrical face, no tilt, centered in tile frame | "The flat one in a box" |
| Infection Zombie | 30-40px | Wide shuffle stance, arms raised, 2-frame walk cycle | "The dancing blobs" |
| Hand from the Ground | 40-60px wide | No face — pure silhouette, fingertips only above dirt | "The faceless reach" |
| Bat | 20-40px wingspan | Asymmetric wing flap, no face visible at distance | "The flying smear" |

**Validation**: Tested against a 50% opacity grey overlay — if silhouettes are still distinguishable at that reduction, the read passes.

### 5.3 Expression and Pose Style

**Reference density target**: Stardew Valley NPC faces (high clarity, 3-4 pixel eyes, readable at 64px). Not Don't Starve Together (too much linework, too dark) or early Crypt of the NecroDancer (too abstract).

**Face construction rules — Mascot Zombie (primary expression carrier):**
- Eyes: 2px wide pupils on 4px white sclera. Googly offset of 1px left or right depending on expression state.
- Mouth: 3px wide at neutral, 5px in surprise/panic, flat 2px line in smug.

| Expression | Eyes | Mouth | Brow | Trigger |
|---|---|---|---|---|
| Idle/Happy | Pupils centered, slight droop | 3px wide, 1px upward curve | None | Default |
| Surprised | Pupils up-right 1px | 4px open O | 2px raised arch | Combo lands |
| Panicked | Pupils shaking (alternate L/R) | 5px wide, 1px downward curve | Furrowed 2px inward | Clutch mode active |
| Smug | Pupils down-left 1px | 3px with 1px corner uptick | One brow raised 1px | Player stalls |
| Dead | X marks replacing pupils (2×2 each) | Flat 2px line | None | Lose-state precursor |
| Dancing | Pupils alternating up/down per frame | 5px wide open | None | Infection wins |

**Board Zombie Tile** carries only Idle, Panicked, and a single-frame Surprised. Its face is 20% smaller than the mascot's at equivalent head size — board tiles cannot compete with the mascot for expression bandwidth.

**Infection Zombies** have no individual expressions. Read comes entirely from pose (arms up, wide stance, shuffle). Two frames only.

### 5.4 Animation Philosophy

**Frame budget constraint**: Every character's full animation set must fit in a 512×512 spritesheet. Non-negotiable for mobile memory.

**Idle loops:**

| Character | Frames | Rate | Loop Type |
|---|---|---|---|
| Mascot Zombie | 4 | 8 fps | Smooth bounce — 1px vertical offset on frames 2 and 4 |
| Board Zombie Tile | 2 | 4 fps | Micro eye-blink only — 1 pixel change per frame, no body movement |
| Hand from the Ground | 3 | 6 fps | Finger curl — middle finger drops 1px on frame 2, returns frame 3 |
| Bat | 3 | 12 fps | Asymmetric wing flap — wings never fully closed, never fully open |
| Infection Zombie | 2 | 8 fps | Full body shuffle — left-lean frame 1, right-lean frame 2 |

**Reaction animations (mascot-only):**

| Reaction | Frames | Rate | Trigger |
|---|---|---|---|
| Combo Cheer | 6, hold final | 10 fps | 4+ match combo lands |
| Clutch Panic | 4, loops | 6 fps | Board reaches ~20% remaining moves |
| Surprise Splat | 5, non-looping | 14 fps | First-time level load or unexpected cascade |
| Victory Bounce | 6 | 10 fps | Level complete |
| Lose Slump | 4, non-looping | 8 fps | Fail confirmed |

**Movement within pixel-first constraint:** Mascot's 5-10° tilt is a baked spritesheet pose, NOT a transform rotation in-engine. All expressive movement is frame-drawn, not tweened. Bat flight uses engine sine-wave arc (position offset), but the bat sprite itself only has 3 wing-flap frames — drawn flap × engine arc creates the read.

### 5.5 LOD Philosophy

| Scale | Treatment |
|---|---|
| **120-200px (Mascot)** | Full detail. 1px dashed stitching. 1px fingernails. Expression fully legible. |
| **~80px (Board Zombie)** | Stitching removed. Fingernails removed. Mouth reduced 1px. Outline weight stays 1px (do not thin to 0.5px — breaks family read). |
| **30-60px (Hand, Bats)** | Silhouette-first. Hand has 1px nail on index finger only (the single detail confirming "hand, not log"). Bats: 2 wing shapes + 2px body dot. No face. |
| **30-40px (Infection Zombies)** | Face = 2px eye dots only, no nose, mouth = single 2px line. Read is pose, not face. |

**Universal rule:** Drop interior detail before dropping outline. The `#1A0F2E` silhouette edge is identity; interior is decoration.

### 5.6 Forbidden Character Tropes

- **No realistic skeleton anatomy.** Ribs, joints, anatomically correct bones read as horror, not cute-horror.
- **No edgelord skull characters.** Skulls with cracks, bullet holes, or aggressive snarls belong in a different game.
- **No dripping gore or exposed viscera.** Replaced with slime. Wounds are stitched X marks, never open gashes.
- **No non-zombie cute mascots.** A kitten, bunny, or generic cute animal breaks the undead family. Every character belongs to the graveyard.
- **No hyper-detailed face rigs** that exceed the mascot zombie's expression resolution. Secondaries cannot outperform the primary.
- **No floating, ungrounded design.** Every character must have clear gravity — drooping, weighing down, anchored. Nothing perky and weightless.

### 5.7 Future Cast Hooks (Reserved Visual Real Estate)

**Ghost / translucent characters** (Crypt biome candidate): No MVP character uses partial transparency or "no outline on one edge." Reserved for ghost-types. Ghosts maintain oversized-head family rule but swap Zombie Green for pale cyan-white base.

**Bone-structure characters** (Catacombs biome candidate): No MVP character is primarily skeletal. Reserved for skeleton-types — round-bone, cartoonish-femur language. They read as "the dry ones" vs current cast's "the wet ones" — material contrast within the same silhouette grammar.

---

## 6. Environment Design Language

### 6.1 Architectural Style: Victorian Halloween Carnival

The Graveyard reads as **British-Victorian seen through a Halloween costume filter** — not historically accurate, not American Southern Gothic, not generic cartoon cemetery. The reference: a child's drawing of a haunted graveyard, built by someone who studied Victorian iron foundry catalogs and church architecture but decided to make everything slightly wrong on purpose.

**Commit rules:**
- Rooflines: steep pointed gables. Never flat or Romanesque arches.
- Windows: tall lancet shapes (Gothic pointed top), but squat in proportion — too short for the arch, giving a compressed, toylike read
- Stonework: implies ashlar block, but blocks are uneven sizes, some visibly tilted — intentional imprecision, not sloppy draftsmanship
- Iron elements (fence, gate hinges): spindly with decorative finials shaped like fleur-de-lis or small skulls — ornate but flat-rendered
- Forbidden: half-timbering, Colonial, Art Nouveau organic curves — those belong to future biomes

**Tone anchor:** Everything here was built to be slightly wrong. The church in the distance looks like it was designed by someone who had only heard churches described. That wrongness is the cute-horror voice.

### 6.2 Texture Philosophy: Flat-Fill with Cluster-Detail Accents

Base language is **flat-fill** with **cluster-detail** applied only at points of visual interest.

- **Flat fills** everywhere in mid-ground and background. Large shapes (sky, distant church mass, grave silhouettes) use a single value per read-zone. No noise, no dither.
- **Cluster-detail** (2-4px grouped pixel marks) appears only on: the stone tile-floor strip, gravestone caps, fence post knobs, and tree bark on the nearest dead tree layer.
- **1px linework** reserved for foreground silhouettes only — iron fence top edge, hands-from-the-ground outlines, immediate gravestone row. Never on background elements.
- **Dithering**: one specific use case — sky-to-horizon gradient transition during palette-swap states. 2-color ordered dither, 4px checker maximum. Anywhere else, dithering reads as visual noise.

**Decision rule for artists:** If an element is more than two visual layers behind the board, it gets flat fill only. **Earn detail with proximity.**

### 6.3 Prop Density Rules

**Target density:** Title screen establishing shot uses the **rule of comfortable overcrowding** — every zone feels occupied, but the central 40% of horizontal width at mid-ground stays clearer to avoid competing with the in-level board frame.

- Maximum 3 distinct silhouette shapes per vertical column of background
- Foreground fence is continuous but broken — gaps of 3-5 fence-widths at regular intervals
- Dead trees: max 2 full-tree silhouettes visible at any time; additional trees are cropped at frame edges
- Gravestones: cluster in groups of 2-3, not evenly spaced. Gaps between clusters wider than clusters themselves
- **Add a prop** when a background zone reads as empty rectangle of flat color for >30% of its width
- **Remove a prop** when two silhouettes overlap >50% of either shape — they merge into unreadable blobs at small mobile sizes

### 6.4 Environmental Storytelling: Level-Select Map as Scar Record

Level progression reads through **incremental corruption cues**, no text required:

| Chapter | Visual Change |
|---|---|
| 1 (fresh) | Neat(ish) graves, fence intact, moon cream, occasional firefly particle |
| 2 | 1-2 tilted gravestones, one fence section leaning, roots beginning to crack the path tiles |
| 3 | Hands-from-the-ground appear at map edges (not yet center), moon tints amber |
| 4 | Corruption vines creep from the ground around level nodes; cleared nodes show a small glowing rune pressed into the gravestone face |
| 5 (end of MVP) | Moon is full chartreuse, central path cracked wide, church in the distance shows one window lit acid green |

**Rule:** Each corruption layer is additive, never resetting. Completed chapters keep their corruption state visible — the map is a scar record of the player's journey.

**Node treatment:**
- Cleared: glowing rune etched into gravestone face
- Uncleared: plain stone, slightly mossy
- Active (current furthest): candle flame particle on gravestone cap

### 6.5 Background-to-Foreground Hierarchy

Five layers, each with a distinct role:

| Layer | Content | Parallax | Detail |
|---|---|---|---|
| **L0 — Sky** | Solid color, moon, occasional bat silhouette | Static | Flat fill only |
| **L1 — Distant atmosphere** | Church/crypt silhouette, horizon fog band | 0.1× | Flat fill, single value |
| **L2 — Mid-ground** | Dead trees, far gravestone rows, fence (back) | 0.25× | Flat fill + minor cluster detail |
| **L3 — Foreground decoration** | Near gravestones, fence (front), hands-from-ground | 0.5× | Cluster-detail + 1px outlines |
| **L4 — Board substrate** | Stone tile-floor strip, board frame arch | Static (UI layer) | Full detail budget |

**Parallax only activates on title screen and level-select map.** During gameplay the background is static — even subtle movement competes with tile tracking on mobile.

### 6.6 Forward-Compat Reservations

Reserve these visual vocabularies — Graveyard does **not** use them, leaving them unclaimed for future biomes:

| Reserved For | Shape Vocabulary | Palette Range |
|---|---|---|
| **Crypt** | Smooth barrel-vault arches, sarcophagus lids (horizontal mass, low), candle-flame organic drips | Warm bone yellows `#C8A45A`–`#8C6830`; deep burgundy `#5C1A1A` |
| **Catacombs** | Skull-and-bone mosaic patterns (high-frequency small detail), stalactite drips, narrow vertical slits | Chalky pale gray `#B4A890`; earth brown `#4A3020`; absolute black fields |
| **Cathedral** | Fan vault geometry, rose window circle + petal subdivision, stained-glass color panes | Cobalt `#1A2A7A`, jewel red `#8C1A1A`, gold `#C8A020` — entirely banned from Graveyard |

**Consistency anchors across all biomes:** steep pointed gables on any roofline, the "wrong proportions on purpose" rule, flat-fill base + cluster-detail accents, the same moon as a recurring character with its three palette states.

### 6.7 Forbidden Environment Patterns

- **No realistic perspective vanishing points.** Orthographic-leaning or slight isometric only. Hard perspective makes the board float awkwardly above the scene.
- **No flat horizon lines.** The horizon is always broken by silhouettes. A straight skyline reads as a 2D stripe.
- **No gradient fills** on environmental shapes. The sky does palette-swaps; it does not gradient from purple to black within a state.
- **No AAA-style specular or rim-lighting** on stone. Stone is flat. Texture comes from cluster-detail pixel marks, not lighting simulation.
- **No organic blob shapes for man-made elements.** Fence, gravestones, church are angular. Organic curves reserved for living/undead things.
- **No photorealistic reference.** Test: would a 10-year-old draw it this way? If no, redesign.
- **No symmetrical props.** Every gravestone, tree, and fence segment must have at least one asymmetric deviation.

### 6.8 MVP Environmental Element Specs

**Distant Church/Crypt Silhouette**
- Position: right-center background, L1
- Size: ~60px tall at 1×, base ~40px wide
- Shape: stacked geometric masses — wide base block, narrower nave, single pointed steeple off-center (leaning 2-3° left). One lancet window slit per face. No interior detail.
- Color: single flat value `#2A1545` (calm) / `#0D2010` (pressure) / `#0A0520` (critical)
- Special: in final chapter of level-select, one window pixel-lights acid green `#AAFF44`

**Iron Fence**
- Position: L3 foreground, full width with 3-5 unit gaps
- Post height: ~24px at 1×; rail ~8px from bottom
- Shape: 2px-wide vertical posts, topped by 3px fleur-de-lis or skull finial (alternate types). Horizontal rail 1px.
- Color: `#1A1A2A` base, `#2E2E4A` highlight on post tops only (1px)
- Rule: posts NOT evenly spaced — clusters of 3, gap, 4, gap. Never a mechanical grid.

**Dead Trees**
- Count in title shot: 2 full trees (L2-L3 split), branches of a third cropped at left edge
- Trunk: 4-6px at base tapering to 2px. Step-down in 2px increments, not smooth taper.
- Branches: blunt-ended (2px flat cap), max 2 generations. Angle upward 30-45° (drooping = willow = wrong).
- Color: `#1A0E2A` trunk / `#2A1A3A` branch highlight (1px top face only)
- Silhouette rule: negative space between branches must read as distinct shapes

**Gravestones (Background, distinct from Gravestone tile):**
- Background gravestones are silhouettes; the Gravestone *tile* in the board has full detail budget
- 4 shapes rotated: rounded top, pointed top, cross, broken top. Never >2 of same type adjacent.
- Size: 10-18px tall at 1×, 8-12px wide
- Tilt: every gravestone tilts 3-10° L or R. No upright graves.
- Color: L2 = `#2A1545` flat. L3 = `#3D2060` with 1px outline `#1A0E35`

**Stone Tile-Floor Strip**
- Position: L4, bottom ~20px of in-level view, full width
- Purpose: visual base for power-up bar; separates board-world from chrome-UI
- Texture: `#4A4055` flat base; cluster-detail marks `#5A5068` in irregular 2-3px groups every 12-16px. 1px top-edge highlight `#6A607A`.
- Joints: 1px darker seam `#38303A` every ~20px (±2px variance)
- No depth illusion — flat decorative band

**Hands-From-The-Ground**
- Per Section 5: pure silhouette `#1A0A2A`, fingertips above dirt line, 3-frame finger-curl idle at 6fps
- Background context: scale ~18px tall at 1× for title/level-select. In-level appearance matches Section 5 character spec.
- Dirt-line: 1px horizontal mark `#2A1A0A` at base of each hand, implying ground crack. No elaborate soil illustration.

---

## 7. UI / HUD Visual Direction

This section is the synthesis of an art-director visual draft and a ux-designer alignment review. All flagged conflicts have been resolved into the spec below. Resolution decisions are noted inline.

### 7.1 Diegetic Philosophy

All persistent HUD elements are **world-costumed** — they read as objects that exist in the graveyard, not floating glass panels:
- Game board border = carved stone blocks
- Power-up bar sits on the L4 stone tile strip as if resting on a ledge
- Score and moves panels = etched cracked-stone slabs
- Goal panel = vine-wrapped wooden signboard

**Rule**: If an element is visible during play, it must have a material identity (stone, wood, bone, or fabric). Only transient overlays (combo bursts, damage numbers, toast notifications) read as pure screen-space — they float because they are momentary.

Popups (level-start, win, lose) take a theatrical middle ground: they enter like a gravestone rising from the ground, but their interior content can use the diverged UI palette without strict material skin.

### 7.2 Typography Direction

Three tiers, all pixel fonts:

| Tier | Use | Spec | Color |
|---|---|---|---|
| **Display** | Score, moves counter, star counts | Chunky 8×8 or 10×10 pixel display face, thick stroke, slight rounded pixel corners. All-caps OK. Min 24px rendered. | `#FFD53D` Combo Gold on dark — "bone engraved in stone" register |
| **Body** | Goal counts, power-up charges, coin amounts | Clean pixel sans, 6×8 or 7×8 baseline, mixed case. Legible at thumb distance. | Off-white `#EEE8C8` on purple — never pure white |
| **Decorative tags** | "Zombies Are Friends!", "Collect Them All!" | Condensed pixel serif or hand-scratched face with irregular baseline. May sacrifice 1px of legibility for personality. Never used for actionable info. | `#A8FF78` Slime Green or `#FFD53D` Combo Gold |

No font mixing within a single tier. No italic unless the font has an italic variant.

### 7.3 Iconography Style

- **Power-up icons** (poison bomb, potion, shovel): mini illustrated sprites at 16×16 or 20×20, same palette and line weight as the tile set. They read as objects, not UI metaphors.
- **Functional icons** (gear, pause, lock-overlay): 2-color silhouette glyphs at 12×12. Function must be instant — they don't need to match the tile register.
- **Skull motif on moves counter**: 16×16 illustrated sprite, not a Unicode glyph.

### 7.4 Frame Ornament Hierarchy

| Tier | Used For | Treatment |
|---|---|---|
| **Master** | Game board border, score slab, top bar | Carved stone-block border 4-6px, chipped corner detail. Tombstone arch on top edge only. |
| **Mid** | Goal panel, power-up bar, lives display | Wooden signboard plank or cracked stone slab, 2px border, single-arch or flat-top. Goal panel gets vine ornament on banner tag only. |
| **Minor / transient** | Coin display, gear surround, toasts | 1px `#7A7A8C` Gravestone gray border, no ornament, no arch. Recede. |

**Rules:**
- **Only one tombstone arch per screen region.** Two arches in proximity flatten each other's impact.
- **Board frame is always the highest-contrast element on screen.** All HUD frames must be 10-15% lower in value (darker or lighter) than the board frame. *(ux-designer: prevents HUD/tile visual competition.)*

### 7.5 UI Animation — Pixel-Stepped Only

All animation runs on 2-4 frame pixel-stepped cycles. No easing curves that produce subpixel positions.

| Element | Animation |
|---|---|
| **Button press** | 1-pixel sink (entire button shifts 1px down+right; shadow disappears). No squash. Releases on lift. |
| **Score tick-up** | Slot-machine roll. Digits cycle 0-9 sprites at 2 frames/step, landing on target. Rolls from ones place outward. Small gains roll fast (4-6 frames); large combos roll with visible spin (12-16 frames). |
| **Mascot reactions** | Idle sway (2-frame), combo celebration (4-frame bounce + googly-eye wobble), lose-state (2-frame droop, half-closed eyes). Triggered by game events, not UI interaction. |
| **Power-up activation** | Slot flashes 2 frames `#FFFFFF` → tile color → settled highlight; charge counter decrements with slot-machine roll. |
| **Menu open/close** | Panels rise from bottom edge at 4px/frame (tombstone-rising metaphor). Close reverses path. No side-slide. |

### 7.6 Touch Affordance Language

**Rest state — interactive elements have TWO cues** *(resolves ux-designer BLOCKER 2 with the idle shimmer fix):*

1. **Static**: 1px `#FFD53D` Combo Gold highlight on top-left pixel edge (light source is top-left)
2. **Animated**: Idle shimmer cycle — the 1px gold edge brightens to `#FFE980` on alternate frames at **1Hz** (every other 30-frame interval at 60fps). Subtle but pre-touch discoverable.

**Pressed state**: 1px sink + highlight moves to bottom-right for one frame, selling depth inversion.

**Unavailable state**: 2-color desaturated palette swap (desaturated purples, no gold edge, no shimmer). 8×8 lock-icon sprite overlaid bottom-right corner. **Never hidden, never opaque-blocked, never red.** The player should see what they cannot yet use.

**Hit-target padding (BLOCKING implementation rule, resolves ux-designer BLOCKER 1):**
- All interactive elements must declare a minimum **44×44pt iOS / 48×48dp Android** invisible hit region, independent of visible art bounds
- The 1px gold highlight sits on the *visible* element edge; the *touch* edge extends invisibly
- The diegetic carved-stone border is a perceptual boundary, NOT a hit boundary

### 7.7 Clutch-Zone UI Shift

When pressure escalates (3 or fewer moves remaining, OR final goal piece outstanding), the UI signals without interrupting:

**Primary cue (shape change, colorblind-safe)** *(resolves ux-designer CONCERN 2):*
- Moves counter stone slab fills entirely with `#FF4D6D` Coral (replacing `#2A1545`). This is a permanent fill swap, not an animation — readable in any colorblind condition.

**Secondary cue (animation):**
- The Coral fill pulses inward via a 2px inner border alternating between Coral and Coral-with-highlight. Cycle period ≥ **1.5 seconds (0.67Hz)** *(resolves ux-designer CONCERN 1: WCAG 2.3.1 flash threshold compliance — well under the 3Hz limit).*
- A `prefers-reduced-motion` OS preference hook disables the animation entirely; the static Coral fill remains as the sole cue.

**Tertiary cue:**
- Mascot shifts to wide-eyes sprite (one additional frame injected into the idle loop) — no new animation, just expression swap.

**Rule**: Maximum two UI elements may carry the clutch-zone signal simultaneously. The player's eye must stay on the board.

### 7.8 Top Bar Information Hierarchy

*(resolves ux-designer CONCERN 3: pillar mapping)*

Top bar elements share the master-frame stone treatment but **scale by cognitive priority**:

| Element | Frame | Type Tier | Why |
|---|---|---|---|
| **Moves counter** | Master (largest) | Display LARGEST | Pillar P1 "Every Match Matters" — primary cognitive load every turn |
| **Score + stars** | Master (mid) | Display MID | Secondary gratification — tracks pillar P3 "Clutch Is The Point" stars |
| **Level + Coins** | Master (small) or Minor | Body | Tertiary context — players don't act on these mid-level |
| **Settings gear** | Minor | Functional glyph | Utility — should recede entirely during play |

Frame material stays consistent (stone) so the bar reads as a coherent strip, but type and icon scale carry the hierarchy. Players locate Moves first, Score second, ignore the rest unless they choose to look.

### 7.9 Accessibility TODOs

These are required hooks that need design follow-up before ship; they don't block the bible:

- [ ] **Screen reader semantic labels**: Define VoiceOver/TalkBack strings for every interactive HUD element (board tiles, power-ups, settings gear, pause, level select nodes). Forward to ui-programmer for AccessKit wiring (Godot 4.5+).
- [ ] **Scalable text support**: Body-tier text must respect OS-level font-size preferences within reason (cap at +30% before layout breaks).
- [ ] **Reduced-motion preference**: Beyond the clutch pulse hook, audit all UI animations and tag which respect `prefers-reduced-motion`. Idle shimmer should fall back to static gold edge when reduced.
- [ ] **Deuteranopia simulator pass**: Render the in-level HUD through a deuteranopia filter and verify clutch Coral and rest-state Combo Gold edge read as distinct states. Combine with Section 4's tile-set simulator pass.

---

## 8. Asset Standards

> **Note**: This section captures the art-direction-side standards. Technical-artist budgets (engine memory limits, draw call counts, importer settings, Godot-specific constraints) and spritecook tile prototypes are deferred to `/asset-spec` and `/setup-engine` follow-up. See "Open TODOs" at end of section.

### 8.1 Naming Conventions

Pattern: `[category]_[name]_[variant]_[size].[ext]`

| Prefix | Category |
|---|---|
| `tile` | Match-3 tile sprites |
| `char` | Character spritesheets |
| `env` | Environment props and backgrounds |
| `ui` | Interface panels, buttons, icons |
| `vfx` | Particle sprites and screen-space effects |
| `sfx` | Sound effects |
| `mus` | Music tracks |

Biome-ready naming uses a `[biome]` slot in the variant field, so assets survive the four planned biomes without rename. Tiles include the biome even in Biome 1 (Graveyard).

```
tile_brain_graveyard_64.png
char_zombie_idle_01.png
env_tombstone_cluster_large.png
ui_btn_primary_default.png
vfx_match_burst_loop_small.png
sfx_match_brain_01.ogg
mus_graveyard_loop.ogg
```

**Directory anchors:**
```
assets/art/tiles/
assets/art/characters/
assets/art/environment/
assets/art/ui/
assets/art/vfx/
assets/audio/sfx/
assets/audio/music/
assets/data/palettes/
```

### 8.2 Resolution Tiers and Pixel Grid

**Canonical tile size: 64×64 logical pixels.** This is the locked grid unit. The board renders 8×8 tiles → 512×512 px board space, which sits cleanly inside a 1080×1920 portrait canvas on all target devices.

**Authoring rule: pixel-native, no upscaling.** Artists author directly at 64×64. Never author at 2× then downsample — downsampling destroys pixel-grid alignment and bleeds anti-aliasing into outlines. Godot renders at integer scale; fractional scale is forbidden.

**Size tiers for derivative uses:**

| Use | Size | Method |
|---|---|---|
| Board tile | 64×64 | Canonical — authored |
| Goal panel icon | 32×32 | Hand-authored, separate file |
| Level-select node | 16×16 | Hand-authored, separate file |

Each tier is a distinct hand-authored asset (see §8.6 — no auto-scale).

### 8.3 File Format Direction

- **Sprites**: PNG-24 with alpha. No JPG. No indexed-color PNG (breaks alpha on some Android targets).
- **Spritesheets**: Single PNG + `.json` metadata (Aseprite export format, compatible with Godot's SpriteFrames importer).
- **Palettes**: `.gpl` (GIMP Palette) and `.aseprite-palette` both maintained. Source of truth: `assets/data/palettes/graveyard_shift_master.gpl`.
- **Audio**: OGG Vorbis for in-game audio. Uncompressed WAV retained in `assets/audio/_source/` as archival masters.
- **Color depth**: 8 bits per channel (24-bit RGB + 8-bit alpha). HDR source not used.

### 8.4 Spritesheet Layout Philosophy

**One sheet per character, all states included.** A single `char_zombie_all.png` contains idle, react-hit, react-match, celebrate, and any power-up states.

Frame ordering within each sheet:
1. Idle frames (leftmost)
2. React-hit frames
3. React-match frames
4. Celebrate frames
5. Power-up activation frames (if applicable)

Frames run left-to-right, top-to-bottom, uniform frame size. **2 px transparent gap between frames** prevents texture-bleed at fractional UV coordinates.

Atlas packing is **hand-authored**, not automated — automated packers reorder frames and break the frame-index contract animators and programmers rely on.

### 8.5 Color Discipline at the File Level

Master palette file: `assets/data/palettes/graveyard_shift_master.gpl`. Contains all 7 primary palette colors, all tile canonical/highlight/shadow triplets, and all sacred constants named as swatches (`TILE_OUTLINE`, `COMBO_GOLD`, `INFECTION_ACID`).

**Artists must load the master palette before opening any sprite file.** No freehand color picking outside the palette for tiles or characters. Environment props may use unlisted mid-values for terrain detail but must not introduce new pure-hue primaries.

**Palette verification rule**: Before submitting any asset, reduce the sprite to indexed color in Aseprite and confirm no unexpected swatches appear. Flag any new color to the Art Director before commit.

### 8.6 LOD / Variant Strategy

**No auto-scaling. All size tiers are hand-authored.** A 64→16px algorithmic scale reads as mud — pixel-grid integrity demands hand-authored tiers.

Naming: the `[size]` field in the filename carries the pixel dimension (`_64`, `_32`, `_16`). Author 64px canonical first; smaller tiers authored separately afterward — never derived automatically.

### 8.7 VFX Asset Standards

- **Particle sprites**: Authored on the 64×64 grid. Standard cycle = **6 frames** (match burst, infection spread, cascade glow). Master palette discipline applies in gameplay space.
- **Spritesheets**: Single PNG + `.json`, horizontal strip, 2 px padding.
- **Screen-space VFX** (combo banner, cascade glow, infection glow): separate spritesheet, not baked into background. Combo Gold flash = 1-frame flash + 3-frame fade. Infection Acid spread = 2-frame pulse on the leading edge. Hard cap: 4 frames per overlay flash.

### 8.8 Aesthetic-Side Budgets (creative discipline, not engine limits)

| Asset Category | Budget |
|---|---|
| Unique tile sprites per biome (canonical + infection variants) | **10** |
| Unique character designs per biome | **4** |
| Animation frames per character (all states combined) | **24** |
| Unique environment props per biome | **20** |
| Particle frames per VFX type | **6** |
| Screen-space VFX frames per effect | **4** |
| UI icon variants per biome (all sizes/states) | **60** |

Exceeding these budgets requires Art Director sign-off + a note in `production/session-state/active.md` explaining the creative justification.

### 8.9 Versioning and Revision Tracking

- **Working files** (Aseprite source): `tile_brain_graveyard_64_v01.aseprite`. Increment on each significant iteration.
- **Exported production files** (PNG) carry no version suffix — the unsuffixed name is always the current approved asset. Replacing this file in repo = act of promotion.
- Working source files live in `assets/art/_source/` and are committed alongside exports. The `_source/` directory IS the revision history.
- Do not delete old `_vNN` files until asset is locked post-milestone. Deletion is an Art Director call.

### 8.10 Open TODOs (deferred to follow-up skills)

- [ ] **Technical-artist budget pass**: Before art production starts, run technical-artist via `/asset-spec` to define engine-side hard limits (texture memory ceiling, draw-call budget, Godot importer settings, atlas size limits). Cross-check against the aesthetic budgets above.
- [ ] **Tile prototype generation**: Run `/asset-spec` with spritecook MCP to generate the 7 canonical tile sprites at 64×64 using master palette hex constraints. Validates the silhouette family system from Section 3 with real assets.
- [ ] **Master palette file authoring**: Create `assets/data/palettes/graveyard_shift_master.gpl` with all hex values from Section 4 named as swatches.
- [ ] **Aseprite palette setup**: Generate `.aseprite-palette` companion file.
- [ ] **Sample atlas authoring**: Hand-author one reference character spritesheet (mascot zombie all states) as the pattern artists follow.

---

## 9. Reference Direction

> **Note**: Reference Direction is deferred to `/asset-spec` follow-up. The user's primary reference is the project mockup (8×8 board, graveyard backdrop, mascot zombie, "Zombies Are Friends!" tag). The bible's Sections 1-8 already encode the constraints those references would formalize. Re-author this section when the team needs to brief external artists.

*[To be authored via /asset-spec or on demand]*
