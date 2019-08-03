# hubot-drone

hubot-drone
A hubot script to interact with Drone CI

See src/drone.coffee for full documentation.

### installation
In hubot project repo, run:

npm install https://github.com/shovelwagon/hubot-drone --save

Then add hubot-drone to your external-scripts.json:
["hubot-drone"]

### sample Interaction
user1>>: hubot drone build restart foo/bar 14

hubot>> started build https://drone.example.com/foo/bar/15

### required environment variables
HUBOT_DRONE_URL

HUBOT_DRONE_TOKEN
