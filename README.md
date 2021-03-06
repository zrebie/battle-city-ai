# battle-city-ai
[![Build Status](https://travis-ci.org/firemark/battle-city-ai.svg?branch=master)](https://travis-ci.org/firemark/battle-city-ai)

## Legend

- [What is this?](#what-is-this)
- [How does this work?](#how-does-this-work)
- [What is the goal?](#what-is-the-goal)
  - [How to achieve that?](#how-to-achieve-that)
  - [Tips](#tips)
  - [Scores](#scores)
- [Protocol Documentation](#protocol-documentation)
- [How to Install?](#how-to-install)
- [How to write first bot?](#how-to-write-first-bot)
- [Server script](#server-script)
- [Run tests](#run-tests)
- [Technology](#technology)
- [Contributors](#contributors)


## What is this?

It is a simple clone of battle city from NES.
Video: https://www.youtube.com/watch?v=KwnwKErXGrI

![Game](image.png)

## How does this work?
The game runs on a server with a game window and listens for two connections: player1 and player2.
Each player is a separate client (tank) connected to the game server. The clients control their tanks 
by sending actions to the server. The game starts when both connections are established and 
greetings messages are send to both clients. The client's moves are defined once, and do not 
undergo any changes during the gameplay.

## What is the goal?

There are two goals:

1. **SURVIVE** in 2 minutes
2. Get more points than the second player

### How to achieve that?
In order to survive and score the biggest amount of points, you need to program the moves 
of your client with a thorough and clever approach. 

### Tips

TODO

### Scores

* **1** for each destroyed tiny-brick
* **5** for each 'freeze' second player
* **200** for each destroyed NPC tank
* **100** for each coin

## Protocol documentation

Is [here](docs/).

* [General rules of game](docs/rules.md)
* [General Protocol](docs/protocol.md)
* [Player actions](docs/actions.md)
* [Unit's messages](docs/units.md)
* [Game's messages](docs/game.md)
* [Types in game](docs/types.md)

## How to install?

Clone This repo.

code works in Python 3.5, 3.6 and 3.7

*remember* about virtualenv or pipenv!

* https://docs.python.org/3/tutorial/venv.html
* https://pipenv.readthedocs.io/en/latest/

```sh
python setup.py develop
```

To get OpenGL support (mega boost!) please install pyglet (not required)
```sh
pip install pyglet
```

## How to write first bot?

First, copy [example code](battle_city/examples/random.py) to main dir with game.
(more examples are [here](battle_city/examples/))

remember about virtualenv or pipenv!

* https://docs.python.org/3/tutorial/venv.html
* https://pipenv.readthedocs.io/en/latest/

#### For linux/mingw/osx/wsl
```sh
./run_game.sh --cmd-p1 "python copied_client.py"
```

 The color of your tank will be yellow.


#### maybe windows?
Omg why?

You have four options:

1. Install http://www.mingw.org/ and run bash shell
2. WSL https://docs.microsoft.com/en-us/windows/wsl/install-win10
3. Virtualbox https://www.osboxes.org/ubuntu/
4. Run three scripts in seperate consoles:
    * `python -m battle_city.server`
    * `python client_a.py`
    * `python -m battle_city.examples.random`

#### tmux version - more hackerable (with split screens in terminal)!
```
./run_game_tmux.sh --cmd-p1 "python copied_client.py"
```

command would be a runner, example `"python copied_client.py"` - **remember** about quotes and command (python, nodejs, ruby or something else) to run your script!!

Another examples:

* *[random](battle_city/examples/random.py)* - show logs and make random actions
* *[boilerplate](battle_city/examples/boilerplate.py)* - empty client
* *[window](battle_city/examples/window.py)* - client shows window and draw game from recevied data

```
run_game.sh [OPTIONS...]
    --help               print this text
    --cmd-p1 CMD_P1	     command to run client as player1. Default is "python -m battle_city.examples.random"
    --cmd-p2 CMD_P2	     command to run client as player2. Default is "python -m battle_city.examples.random silent"
    --map MAP            select map to run game. Default is pilif
    --ip IP              IP of server. Default is 127.0.0.1
    --port PORT          PORT of server. Default is 8888
    --speed SPEED        tick speed of game. default is 1
    --hidden-window      don't show window with game, run only server
    --turn-off-after-end turn off server when game is end. Good option for machine learning
```

The `run_game.sh` script will run the whole game with two clients. There is no need to run anything else.
The script includes a command for running server and commands for running two clients. The basic clients are dummy.
They will just move randomly.
If you want to start implementing your algorithms for moves, create your own
client, based on the example [example code](battle_city/examples/random.py), and after finishing,
use it in `run_game.sh` script (examples are above).

## Server script

```
python -m battle_city.server [--ip IP] [--port PORT] [--hide-window] [--speed SPEED]
```

Note that `run_game.sh` script runs the server as well as both clients by default.
If you want to create your own configuration for running the game, use the command above 
in your own script.

## Run tests

```sh
pip install -e '.[test]'
pytest tests/
```

## Technology

* Python >=3.5
* Pygame
* Pyglet
* Asyncio
* JSON
* Love

## Contributors

* Firemark - game logic and everything else
* Socek - idea
* Stachu - documentation improvment, beta testing
* Noemi - beta testing
* Prs - nice tips
