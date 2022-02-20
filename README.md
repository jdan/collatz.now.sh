## collatz.now.sh

<img width="795" alt="image" src="https://user-images.githubusercontent.com/287268/154855756-e3352066-8d8a-4447-a863-40c8f66483ad.png">

This generates SVGs for [Collatz](https://en.wikipedia.org/wiki/Collatz_conjecture) sequences. This technique comes from an excellent Numberphile video on the [Recamán sequence](https://www.youtube.com/watch?v=FGC5TdIiT9U),

It is written in OCaml, and compiled to JavaScript using [BuckleScript](https://bucklescript.github.io/) to be served with [Now](https://now.sh).

### Running

In dev you'll want to run `yarn watch` and `now dev` in two separate windows.

Then visit http://localhost:3000/api/collatz?num=123

### Deploying

`yarn deploy`
