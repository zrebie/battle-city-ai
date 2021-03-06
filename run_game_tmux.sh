#!/bin/bash
set -e

CMD_A='python -m battle_city.examples.random'
CMD_B='python -m battle_city.examples.random'
source _run_game.sh

SESSION=${USER}_BATTLECITY

tmux -2 new-session -d -s $SESSION "/bin/sh"

# top window - server
tmux split-window -v "/bin/sh"
tmux select-pane -t 0
tmux send-keys "trap finish INT" C-m
tmux send-keys "trap finish exit" C-m
tmux send-keys "finish() { tmux kill-session -t $SESSION; }" C-m
tmux send-keys "clear; echo 'press CTRL+C (^C) or CTRL+D (^D) to close.'; "
tmux send-keys "python -m battle_city.server --ip $IP --port $PORT --map $MAP --speed $SPEED $SERVER_OPTS; "
tmux send-keys "echo 'press CTRL+C (^C) or CTRL+D (^D) to close.'" C-m

# player windows
tmux select-pane -t 1 
tmux split-window -h "/bin/sh"

# left window - 1st player
sleep 0.25
tmux select-pane -t 1
tmux send-keys "clear; echo PLAYER 1; sleep 2 && $CMD_A" C-m

# right window - 2nd player
sleep 0.25
tmux select-pane -t 2
tmux send-keys "clear; echo PLAYER 2; sleep 2 && $CMD_B" C-m

# return to server window
tmux select-pane -t 0

tmux -2 attach-session -t $SESSION
