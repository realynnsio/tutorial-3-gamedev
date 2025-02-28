# Implementation Explanation

Below are a few short explanations on how I did this tutorial, complete with any references I used for each feature I implemented!


## 1. Double Jump

Reference: https://forum.godotengine.org/t/double-jump-help/16175/2

To implement this feature, I followed the reference above and added a variable that keeps track of whether or not a player is allowed to double jump, called `can_double_jump`. This variable is first set to false, and is only set to true after the player has just jumped from the floor. When the player is mid air after that first jump and another `ui_up` press is detected, the player jumps for a second time and the `can_double_jump` variable is set back to false.

## 2. Dashing

Reference: https://godotforums.org/d/35106-is-there-a-simple-solution-for-a-double-tap/9

This feature was pretty tricky to implement for me since I didn't quite grasp the concept of timers... when I read the reference above, I followed their implementation of a timer but ended up improvising my own way of making the dash work. I had a timer for right tapping and left tapping to check whether the player had double tapped on either, plus two boolean variables for dashing left and dashing right. For as long as the timers are above 0, they'll continually decrease (from `_process` function) until they hit 0. However, they'll restart from 0.25 whenever their corresponding input keys have just been released (`ui_right` and `ui_left`).

If the player hits `ui_right` or `ui_left` just after they've pressed that same key (detected by the corresponding timer value still being above 0), they'll activate the corresponding dash boolean to be true. This allows them to move at run speed instead of walk speed. When the player stops their input, their velocity will be set back to 0 and both dash values will be set back to false.

## 3. Crouching

Reference: *none (I improvised!)*

To implement this crouching feature, I decided to keep it simple and just scale down the Player Character's scale.y value and movement speed for as long as they're holding down the `ui_down` button. Pretty self explanatory!

## 4. Animated Sprites

References:
- https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html
- https://forum.godotengine.org/t/flipping-an-animation-solved/28072/4


To add the animated sprites, I made a few sprite sheets myself using aseprite and imported them into this Godot project. I followed the first reference link above and used AnimatedSprite2D as my preferred method of adding animated sprites. After adding all the types of animations I wanted for the character (idle and walk), I triggered these animations based on what movement the character is doing with the `_animated_sprite.play()` method. To make my life easier, I also didn't make separate sprite sheets for walking right and walking left for the character, I just utilized the `_animated_sprite.flip_h` value as per the second reference linked above.