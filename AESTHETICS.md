# NetWatch — Aesthetic & Usability Review

Comprehensive review of visual design, usability, and recommendations for appealing to both hobbyists and professional network engineers.

---

## What Works Well

### ✓ Strong Foundations
- **Colour-coded state indicators** — ESTABLISHED (green), LISTEN (yellow), CLOSE_WAIT (red) provide instant readability across connections, timeline, and topology
- **Latency heatmap** — the `▁▂▃▄▅▆▇█` block characters with green→yellow→orange→red gradient is genuinely impressive and professional-grade
- **Protocol colouring** — consistent per-protocol colours (TCP=Magenta, UDP=Blue, DNS=Green, ICMP=Yellow, ARP=Cyan) across Packets, Stats, and filtering
- **Sparklines for bandwidth** — live-updating RX/TX sparklines give immediate visual feedback
- **Expert indicators** — `●▲·` severity system in Packets tab mirrors Wireshark's expert info
- **Stream direction arrows** — `→`/`←` with green/magenta colour coding for A↔B traffic
- **Handshake histogram** — the `█░` bar chart with latency buckets is a standout feature

### ✓ Good Progressive Disclosure
- Tabs ordered simple→advanced (Dashboard→Packets→Timeline→Topology)
- Help overlay (`?`) is comprehensive and well-organized
- Filter bar appears only when invoked (`/`)

---

## Issues & Recommendations

### 1. Monochrome Header — No Visual Identity

**Problem:** The header bar is a flat line of text with no visual distinction. The `NetWatch` brand gets lost in the tab list. On wide terminals, `[1] Dashboard [2] Connections [3] Interfaces [4] Packets [5] Stats [6] Topology [7] Timeline [8] Insights` runs together as a grey wall of text.

**Recommendation:**
- Make `NetWatch` a **bold Cyan on a subtle dark background** with a small logo character (e.g. `🔭 NetWatch` or `◉ NetWatch`)
- Only highlight the **active tab** in Yellow+Bold; render inactive tabs in DarkGray instead of default White
- Add a **thin separator** (`│`) between each tab number for visual grouping
- Move the clock to the right edge, right-aligned

**Impact:** Instant brand recognition. Hobbyists feel the app has personality; professionals can locate their current tab at a glance.

---

### 2. Uniform DarkGray Borders — Everything Looks the Same

**Problem:** Every single panel uses `border_style(Style::default().fg(Color::DarkGray))`. This makes all panels blend together with no visual hierarchy. The Dashboard's 7 panels are indistinguishable at a glance.

**Recommendation:**
- **Active/focused panels** get a brighter border (Cyan or White)
- **Data panels** (Interfaces, Connections, Packets) use DarkGray borders — this is fine
- **Status panels** (Health, Latency Heatmap, Summary bars) get **no borders** — use coloured left-edge accents instead (a single `│` in Cyan on the left)
- **Section titles** should use Cyan text, not just the default block title styling

**Impact:** Clear visual hierarchy. The eye naturally flows to the most important information first.

---

### 3. Footer Key Hints — Too Dense, Truncated on Normal Terminals

**Problem:** The Packets tab footer crams 15+ keybindings into a single line:
```
q:Quit  a:Analyze  c:Stop  /:Filter  s:Stream  b:BPF  w:Save  f:Follow  m:Bookmark  n/N:Next/Prev  W:Whois  p:Pause  r:Refresh  1-8:Tab  g:Geo  ?:Help
```
On an 80-column terminal, this truncates. Users never see the rightmost hints.

**Recommendation:**
- Show only the **most relevant 6-8 keybindings** for the current context
- Use a **two-tier priority system**:
  - **Always visible:** `q:Quit  ?:Help  ↑↓:Scroll  1-8:Tab`
  - **Context-specific:** Show 3-4 bindings relevant to the current tab/state
- When `?` is available, trust that power users will discover the rest via help

**Impact:** Key hints are actually readable. Hobbyists aren't overwhelmed; professionals use `?` for the full reference.

---

### 4. Selection Highlight — DarkGray Background Is Nearly Invisible

**Problem:** The selected row in tables uses `Style::default().bg(Color::DarkGray)` which is nearly invisible on dark terminal backgrounds. On some terminal themes, it's completely indistinguishable.

**Recommendation:**
- Use `bg(Color::Rgb(40, 40, 60))` — a very subtle blue-tinted highlight that works on all dark themes
- Add a `►` or `▶` marker in the leftmost column of the selected row
- For the timeline, the selected connection already uses Yellow bold text — extend this pattern to other tabs

**Impact:** Users always know which row is selected. Critical for keyboard-driven navigation.

---

### 5. Dashboard Layout — Health Section Is Cramped

**Problem:** The Health section squeezes gateway RTT, DNS RTT, loss percentages, error counts, and eBPF status into a single line. On narrower terminals, this wraps or truncates.

**Recommendation:**
- Split into a **2-row layout**:
  ```
  GW 192.168.1.1  ● 1.2ms  0% loss   │  DNS 8.8.8.8  ● 12ms  0% loss
  Errors: 0  Drops: 0                  │  eBPF: off
  ```
- Use the health dot (`●`) with colour instead of writing "0% loss" — the colour already conveys the information
- For hobbyists: `Gateway: OK ● 1.2ms` is clearer than `GW 192.168.1.1: 1.2ms (0% loss)`

**Impact:** More scannable. The health section becomes a true at-a-glance indicator.

---

### 6. Topology Tab — Box Drawing Could Be More Polished

**Problem:** The topology uses basic `─` lines for edges and `Borders::ALL` boxes. Edge labels like `── 3× ──` are functional but visually sparse. The layout doesn't dynamically adapt well to terminal size.

**Recommendation:**
- Use **rounded corners** (`╭╮╰╯`) for node boxes via `BorderType::Rounded` (ratatui supports this)
- Colour-code node borders: Cyan for local machine, Green for healthy infrastructure, Yellow for degraded, Red for down
- Add **line styles** to edges: solid for active connections, dotted (`┄`) for idle
- Show a **mini traffic indicator** on edges: `─▶ 12KB/s ─` instead of just `── 3× ──`

**Impact:** The topology becomes a visual centrepiece — the "wow" feature that screenshots well and impresses both audiences.

---

### 7. Timeline Gantt Chart — Needs Time Axis Labels

**Problem:** The timeline bar chart has no time axis. Users see coloured bars but can't tell if a bar started 30 seconds ago or 4 minutes ago without counting characters. The title says "now ← → 5m ago" but there are no tick marks.

**Recommendation:**
- Add a **time axis row** at the top or bottom of the chart:
  ```
  now ─────── 1m ─────── 2m ─────── 3m ─────── 4m ─────── 5m
  ```
- Use `│` tick marks at regular intervals aligned with the bar width
- The active edge marker (`▓`) is good — keep it

**Impact:** Professionals can correlate connection lifetimes with specific events. Hobbyists understand what the chart means without reading docs.

---

### 8. Packets Tab — Info Column Needs Smarter Truncation

**Problem:** The `Info` column gets `Constraint::Min(25)` but packet info strings can be very long (e.g., full HTTP headers, DNS query details). Long info pushes useful detail off-screen.

**Recommendation:**
- Truncate info strings with `…` at the column width boundary
- Bold the **most important part** of info: for DNS, bold the query name; for HTTP, bold the method+path; for TCP, bold the flags
- Show the full info in the detail pane below (already works)

**Impact:** Scan the packet list faster. The info column becomes a useful summary, not a wall of text.

---

### 9. Stats Tab — Distribution Bar Needs Polish

**Problem:** The `bar_visual` function uses `█░` blocks but the entire bar is a single green colour regardless of the protocol. The bars don't visually connect to the protocol colours used elsewhere.

**Recommendation:**
- Colour each distribution bar to match the protocol colour (TCP=Magenta, UDP=Blue, etc.)
- Already partially done in `render_handshake_histogram` (green/yellow/orange/red by bucket) — apply the same pattern to the protocol distribution bars

**Impact:** Visual consistency across the app. The Stats tab becomes a colourful, Wireshark-like protocol hierarchy view.

---

### 10. Missing Paused State Indicator

**Problem:** When the user presses `p` to pause, there's no visible indicator that data collection has stopped. The user might think the network went quiet.

**Recommendation:**
- Show a prominent `⏸ PAUSED` indicator in the header bar, styled with Yellow background + Black text
- Dim all data panels slightly (reduce foreground brightness) while paused
- Alternatively, add a blinking `▌PAUSED▐` badge next to the clock

**Impact:** Users never accidentally leave the app paused and wonder why nothing is updating.

---

## Implementation Priority

| Priority | Item | Effort | Visual Impact |
|----------|------|--------|---------------|
| **P0** | 4. Selection highlight visibility | 30min | High — fixes a usability bug |
| **P0** | 10. Paused indicator | 30min | High — prevents user confusion |
| **P1** | 1. Header redesign (active tab, brand) | 1hr | High — first impression |
| **P1** | 3. Footer key hint pruning | 1hr | High — readability on 80-col |
| **P1** | 5. Health section 2-row layout | 1hr | Medium — scanability |
| **P2** | 2. Border hierarchy (accent borders) | 1hr | Medium — visual polish |
| **P2** | 9. Protocol-coloured distribution bars | 30min | Medium — consistency |
| **P2** | 8. Info column truncation | 30min | Medium — packets usability |
| **P3** | 6. Topology rounded corners + edge labels | 2hr | High — "wow" factor |
| **P3** | 7. Timeline time axis | 1hr | Medium — comprehension |

**Total estimated effort: ~9 hours**

---

## Colour Palette Summary (Current)

| Role | Colour | Usage |
|------|--------|-------|
| Brand / Headers | Cyan | NetWatch name, section titles, table headers |
| Active tab / Keybinds | Yellow | Tab highlights, footer key shortcuts |
| Healthy / RX data | Green | ESTABLISHED, UP, RX rates, low RTT |
| TX data / Outbound | Blue | TX rates, UDP protocol |
| Warning / Degraded | Yellow | LISTEN, ICMP, medium RTT |
| Error / Critical | Red | DOWN, CLOSE_WAIT, high loss, RST |
| Accent / Protocol | Magenta | TCP protocol, stream B→A direction |
| Infrastructure | Cyan | ARP, topology labels, health dots |
| Muted / Inactive | DarkGray | Timestamps, inactive connections, borders |
| Data text | White | Default content text |

The palette is solid and well-chosen. No changes needed — just more intentional application of the hierarchy described above.
