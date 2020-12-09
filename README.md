# Veins framework docker image
Docker image for Veins Simulator
## About the project
Veins is an open source framework for running vehicular network simulations. It is based on two well-established simulators: OMNeT++, an event-based network simulator, and SUMO, a road traffic simulator.
## Usage
### Clone repository
```console
$ git clone https://github.com/habe33/veins-env.git
```
### Build Docker Image
```console
$ make setup
```
### Run
```console
$ make run-bash
```
### Test simulator
* OMNeT++
```console
$ omentpp
```
* SUMO
```console
$ sumo
$ sumo-gui
```
### Commands
Feel free to edit commands.sh to run your simulations
## Requirements
* Docker
* X11
