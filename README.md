# MyGodotTemplates

This godot Project Includes two Platformer player scripts that I have created.
you can use this template as starting point for platformer player

project includes

## Functionalities
- Smooth movement with acceleration
- can double triple quadpal jump :)
- jump is very tweakable
- insted of is_on_floor we use ray case since it works better

## Simple Player Script
- very readable code, commented
- not complex works smooth
- you can tweak the export variables to make player move/jump as you want
- very handy if you want to make a basic mario

## State Pattern Player
- still readable code, commented 
- its easy if you know state pattern but you can read through comments
- you can tweak the export variables to make player move/jump as you want
- add more states (attack, doge, climb) or change the functionalities for more
- not very optimised for small project (has alot boilerplate)

# TWEAKING
- Max Speed: Player max speed for lower scale games use less value
- Acceleration : more the value faster the player reaches its max_speed

- Max Jump : how many jumps player can make
- Jump Height : how much player ascends vertically
- Jump Time to Peak : in how much time player will reach its peak height (in seconds)
- Jump Time To Decent: after reaching peak in how much time player will reach the point he jumped

- you can set these variables according to your game size and like :)