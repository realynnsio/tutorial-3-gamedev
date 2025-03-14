# Tutorial 5: Implementation Explanation

Below are a few short explanations on how I did this tutorial, complete with any references I used for each feature I implemented!

## 1. New Object (Seal!)

Reference: https://forum.godotengine.org/t/enemy-movement-controll/75581/2

To make the seal, I pretty much copied exactly the steps I would've done to make a player character, except this time this CharacterBody2D didn't take in input to move but followed a script for its path. I used the script in the reference above except added some gravity to it just so it wouldn't awkwardly float.

I also wanted to make the seal sprite on my own (I love seals), so I ended up taking a bit of time to create a simple seal walking/wobbling animation in Aseprite and exported it as a spritesheet. To make the animation, I used AnimatedSprite2D much like how I animated Hungre (the player character) for tutorial-3 previously.

## 2. New SFX Audio (Oof!)

Reference: https://csui-game-development.github.io/tutorials/tutorial-5/

To make the SFX Audio, I just recorded myself saying "oof!" into my laptop mic and cleaned it up in Audacity with noise reduction. I imported it into the project as-is right afterwards :D.

## 3. New BGM (Self-made!)

I had some old loops in Bandlab lying around since 2024, so I decided to download one of them to import as a new BGM for this tutorial. I genuinely just titled it as "loop2" in Bandlab!

## 4. New Interaction (Ground-Pound!)

Reference:
- https://docs.godotengine.org/en/stable/classes/class_raycast2d.html
- https://docs.godotengine.org/en/stable/classes/class_area2d.html
- KenKomKom :D

I knew it would be fun to implement a "ground-pound" mechanism for this tutorial since I coincidentally already implemented a fast fall feature since tutorial-3, but I wasn't sure how to do it properly. My reference for doing this was purely Kenichi's advice on what to do and the Godot docs...

Ken first suggested using RayCast2D, so I tried that by triggering a `death()` function in the Seal if it comes into contact to the player's RayCast2D while the player is slamming down. This turned out to be a bit tricky since it only worked if the player's center was aligned with the seal.

Since the gameplay was a bit frustrating with RayCast2D, I switched to Area2D instead. This proved to work a lot better for the collision detection and that's what I decided on keeping in the end.

## 5. Audio Feedback (Oof!)

Reference:
- https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
- KenKomKom :D

For the audio feedback, I placed the audio player with the death sound in the Seal node at first, but Ken suggested to keep all the audio in one place so I moved it to my main scene. To call this audio player in `Main.tscn` whenever the `death()` function was called in the Seal node, I created an extra script for global signals.

In this `GlobalSignals.gd`, I created a `mob_died` signal. Whenever a Seal died, it would call and emit this `mob_died` global signal and my `Main.gd` would be the one to listen for it. In `Main.gd`, this global signal is connected to an `_on_mob_died()` function which plays the seal death sound in my main level whenever a signal is received.

<br>

# Tutorial 3: Implementation Explanation

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