Output demo.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 50ms

Type "sudo netwatch"
Enter
Sleep 5s
Type "bmw1Series"
Enter
# Dashboard - live interface stats, bandwidth graphs, health probes, heatmap
Sleep 4s

# Cycle themes from Dashboard: dark -> light -> solarized -> dracula -> nord
Type "t"
Sleep 2s
Type "t"
Sleep 2s
Type "t"
Sleep 2s
Type "t"
Sleep 2s

# Back to default dark theme
Type "t"
Sleep 2s

# Open Settings menu with ','
Type ","
Sleep 2s

# Navigate theme selector with arrow keys
Right
Sleep 1s
Right
Sleep 1s
Left
Sleep 1s

# Close settings
Escape
Sleep 2s

# Connections tab - latency sparklines & RTT trend column
Type "2"
Sleep 4s

# Scroll through connections
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Up
Sleep 500ms
Up
Sleep 2s

# Interfaces tab
Type "3"
Sleep 3s

# Packets tab with capture
Type "4"
Sleep 2s

# Start packet capture
Type "c"
Sleep 5s

# Scroll through captured packets
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 1s

# Select a packet to see detail
Enter
Sleep 3s

# Back out of detail
Escape
Sleep 1s

# Stop capture
Type "c"
Sleep 2s

# Stats tab - protocol hierarchy
Type "5"
Sleep 3s

# Topology tab
Type "6"
Sleep 3s

# Timeline tab
Type "7"
Sleep 3s

# Insights tab - trigger AI analysis
Type "8"
Sleep 2s
Type "a"
Sleep 15s

# Processes tab - per-process bandwidth
Type "9"
Sleep 4s

# Scroll through processes
Down
Sleep 500ms
Down
Sleep 500ms
Up
Sleep 2s

# Show help overlay
Type "?"
Sleep 3s

# Close help and quit
Type "?"
Sleep 1s
Type "q"
Sleep 1s
