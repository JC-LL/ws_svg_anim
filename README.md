# Animating SVG using Ruby through _Websockets_  

## Presentation
A set of small experiments to drive SVG animation _via websockets_.
I struggled too much on trying to animate scenes using various GUI librairies.
My conclusion is that there's nothing better than SVG.

Here, I use a simple Ruby websocket server on one side and a simple browser (my case Firefox) that displays the SVG. The server is here to send drawing commands of my own, to a Javascript client that applies the commands to the SVG elements. We can also imagine that the client can send status or user events back to the server.

## Contents description

* **Test 1** : where I started playing with the idea. Various commands are prototyped.
* **Test 2** : crude (but cheap) animation of a graphviz finite-state machine.
* **Test 3** : dealing with scale command.
* **Test 4** : trying to animate external SVG file (TO COME)

## How to install ?

Simply clone the github projet project.

## How to reproduce ?

```[bash]
  cd test_1
  cd server
  ruby app.rb #start the server
```
Then open test_1/browser/index.html in your browser. An animation should be displayed.

## Questions ?
If you have suggestions, plase contact me **jean-christophe.le_lann** at ensta-bretagne dot fr.
