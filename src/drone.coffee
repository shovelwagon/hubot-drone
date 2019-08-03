# Description
#   A hubot script to execute Drone CI builds
#
# Configuration:
#   HUBOT_DRONE_URL
#   HUBOT_DRONE_TOKEN
#
# Commands:
#   hubot drone ping
#   hubot drone build
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Lee Sautia[shovelwagon@gmail.com]

HUBOT_DRONE_TOKEN = process.env.HUBOT_DRONE_TOKEN
HUBOT_DRONE_URL = process.env.HUBOT_DRONE_URL

module.exports = (robot) ->
  robot.hear /^drone ping/i, (msg) ->
    msg.send "pong"
  robot.hear /^drone build restart (.*\/.*) (\d+)/i, (msg) ->
    restartBuild(msg, HUBOT_DRONE_URL, HUBOT_DRONE_TOKEN, msg.match[1], msg.match[2])
  robot.hear /^drone build cancel (.*\/.*) (\d+)/i, (msg) ->
    cancelBuild(msg, HUBOT_DRONE_URL, HUBOT_DRONE_TOKEN, msg.match[1], msg.match[2])
  robot.hear /^drone repo disable (.*\/.*)/i, (msg) ->
    disableRepo(msg, HUBOT_DRONE_URL, HUBOT_DRONE_TOKEN, msg.match[1])
  robot.hear /^drone repo enable (.*\/.*)/i, (msg) ->
    enableRepo(msg, HUBOT_DRONE_URL, HUBOT_DRONE_TOKEN, msg.match[1])

disableRepo = (msg, drone_url, drone_token, repo) ->
    url = "#{drone_url}/api/repos/#{repo}"
    console.log(url)
    repositories = msg.http(url).header("Content-Type", "application/json").header("Authorization", "Bearer #{drone_token}").delete(null) (err, res, body) ->
        resp = JSON.parse(body)
        console.log(resp)
        msg.send "disabled repo #{drone_url}/#{repo}"

enableRepo = (msg, drone_url, drone_token, repo) ->
    url = "#{drone_url}/api/repos/#{repo}"
    console.log(url)
    repositories = msg.http(url).header("Content-Type", "application/json").header("Authorization", "Bearer #{drone_token}").post(null) (err, res, body) ->
        resp = JSON.parse(body)
        console.log(resp)
        msg.send "enabled repo #{drone_url}/#{repo}"

restartBuild = (msg, drone_url, drone_token, repo, build_number) ->
    url = "#{drone_url}/api/repos/#{repo}/builds/#{build_number}"
    console.log(url)
    repositories = msg.http(url).header("Content-Type", "application/json").header("Authorization", "Bearer #{drone_token}").post(null) (err, res, body) ->
        resp = JSON.parse(body)
        console.log(resp)
        msg.send "started build #{drone_url}/#{repo}/#{resp["number"]}"

cancelBuild = (msg, drone_url, drone_token, repo, build_number) ->
    url = "#{drone_url}/api/repos/#{repo}/builds/#{build_number}"
    console.log(url)
    repositories = msg.http(url).header("Content-Type", "application/json").header("Authorization", "Bearer #{drone_token}").delete(null) (err, res, body) ->
        resp = JSON.parse(body)
        console.log(resp)
        msg.send "cancelled build #{drone_url}/#{repo}/#{build_number}"
