
## Load
function ./load:
    scoreboard objectives add ___.data dummy

    execute unless score %installed ___.data matches 1 run function ./install
    execute if score %installed ___.data matches 1 unless score $version ___.data matches ctx.meta.version run function ./update


function_tag minecraft:load:
    values:
        - "___:core/load"


## Install
function ./install:
    scoreboard players set %installed ___.data 1

    # Add scoreboards
    scoreboard objectives add ___.data dummy
    # Set the version in format: xx.xx.xx
    scoreboard players set $version ___.data ctx.meta.version

    # Sent installation message after 4 seconds
    schedule function ./send_message 4s replace:
      tellraw @a:
          text: f"Installed {ctx.project_name} {ctx.project_version} from {ctx.project_author}!"
          color: "green"


## Uninstall
function ./uninstall:
    scoreboard objectives remove ___.data

    tellraw @a:
        text: f"Uninstalled {ctx.project_name} {ctx.project_version} from {ctx.project_author}!"
        color: "green"

    datapack disable "file/<name>"
    datapack disable "file/<name>.zip"
