#  NevHaptics

Nevyn Bengtsson (nevyn.jpg@gmail.com)

This README explains the framework as I'm imagining it would work; it has not yet been implemented.

## Abstract

NevHaptics makes iOS UIKit controls feelable, and not just touchable. By making touch pressure
a first class citizen, and making a light touch mean "let me feel the texture and edges of this thing"
instead of "perform the action associated with this thing", iOS becomes more accessible to less-sighted
people; and less prone to mis-touches as you have to press hard enough to make an action deliberate,
rather than just nudging it.

It uses the Taptic engine to let the user feel the texture of the thing being touched. If the user feels
the control they know they want to interact with, they can press harder to activate the control,
just like you would if you felt the surface of an array of light buttons on the wall, and pressed harder
to activate the one you want right now.

## Concepts

NevHaptics overrides `-[UIApplication sendEvent:]` and interprets touches differently. If the
current device does not support touch pressure, it's forwarded to the original implementation.

Otherwise, it tracks the finger movement more akin to `-[mouseMoved:]`. As the finger traces the
screen, the view hierarchy is hit-tested, and then the responder chain is searched for
 `-[haptic_touchesTraced:withEvent:]`. In contrast to
 `-[touches{Began|Moved|Ended|Cancelled}:withEvent:]`, touch tracing does not track
only within the first-touched view, but rather continuously hit tests under the finger.

The default implementation of `-[haptic_touchesTraced::]` queries `self`'s `-[haptic_texture]` to
determine the surface texture of the thing. If it isn't `None`, the finger movement is translated into
an animation of the Taptic engine.

NevHaptics monitors the pressure of the touch, and acts when the pressure passes threshold
values. When a touch is harder than `-[haptic_interactionPressureThreshold]`, tracing is
stopped, and normal `touches{...}` behavior is begun, including tracking the control under the
finger exclusively. You can customize this threshold by overriding the method on a UIResponder
subclass.

NevHaptics does not currently consider multi-touch, as Taptic engine can only emulate finger
haptics for a single finger, because it's device-wide and can't emit different
vibrations to different fingers. Pressure-sensitive UI only makes sense if you can make
sense of the surface under the finger by touch, which requires haptic feedback. (orrr some sort
of complex visual or audio feedback system, which is out of scope for this project).

### Undecided

* Should there be two thresholds? Like a physical button: `0 to X` to just feel it, `X to Y`
  to start moving the button, and `>Y` to make it click and perform its action?
* An API or behavior to feel the edge or outline of an UIResponder? A generic behavior
  to feel the outline of any UIResponder?
* Buttons: Should the pressure threshold be `initial presssure + X`, rather than a
  fixed value? Or at least have a bit of flexibility?

## Built-in behaviors

### UIButton

The edges of the button have a texture, so that when you pass your fingers from the exterior
to the interior of the button, you can feel the edge.

As you press down on the button, it's animated as moving down into the screen with your
finger.

### UIScrollView

Just touching a scroll view does not scroll it, but instead traces its surface. It has a light texture,
and if you press slightly harder, scrolling begins with slightly more coarse texture. Releasing
pressure without releasing the finger will seize the scrolling, and resume touch tracing.

### UINavigationController


