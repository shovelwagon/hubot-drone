# Description
#   A hubot script to execute Drone CI builds
#
# Configuration:
#   HUBOT_DRONE_URL
#   HUBOT_DRONE_TOKEN
#
# Commands:
#   hubot drone build - allows interaction with Drone CI via the API
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Lee Sautia[shovelwagon@gmail.com]

HUBOT_DRONE_TOKEN = process.env.HUBOT_DRONE_TOKEN
HUBOT_DRONE_URL = process.env.HUBOT_DRONE_URL

module.exports = (robot) ->
  robot.hear /^drone build restart (.*\/.*) (\d+)/i, (msg) ->
    console.log(msg.match[1])
    console.log(msg.match[2])
    restartBuild(msg, HUBOT_DRONE_URL, HUBOT_DRONE_TOKEN, msg.match[1], msg.match[2])

restartBuild = (msg, drone_url, drone_token, repo, build_number) ->
    url = "#{drone_url}/api/repos/#{repo}/builds/#{build_number}"
    console.log(url)
    repositories = msg.http(url).post(null).header("Content-Type", "application/json").header("Authorization", "Bearer #{drone_token}") (err, res, body) ->
        resp = JSON.parse(body)
        console.log(resp)
        msg.send "started build #{drone_url}/#{repo}/#{resp["number"]}"
