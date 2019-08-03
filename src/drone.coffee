# Description
#   A hubot script to execute Drone CI builds
#
# Configuration:
#   HUBOT_DRONE_URL
#   HUBOT_DRONE_TOKEN
#
# Commands:
#   hubot drone project - allows interaction with Drone CI via the API
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Lee Sautia[shovelwagon@gmail.com]

HUBOT_DRONE_TOKEN = process.env.HUBOT_DRONE_TOKEN
HUBOT_DRONE_URL = process.env.HUBOT_DRONE_URL

module.exports = (robot) ->
  robot.respond /^drone build restart (.*\/.*) (\d+)/i, (msg) ->
    restartBuild(msg, HUBOT_DRONE_URL, HUBOT_DRONE_TOKEN, msg.match[1], msg.match[2])

restartBuild = (msg, drone_url, drone_token, repo, build_number) ->
    repositories = msg.http("#{drone_url}/api/repos/#{repo}/builds/#{build_number}").post(null).header("Content-Type", "application/json").header("Authorization", "Bearer #{drone_token}") (err, res, body) ->
        resp = JSON.parse(body)
        msg.send "started build #{drone_url}/#{repo}/#{resp["number"]}"
