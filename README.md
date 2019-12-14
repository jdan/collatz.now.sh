## collatz.now.sh

<img width="300" src="https://collatz.now.sh/20191209.svg">
`<img width="300" src="https://collatz.now.sh/20191209.svg">`

This generates SVGs for [Collatz](https://en.wikipedia.org/wiki/Collatz_conjecture) sequences.

It is written in OCaml, and compiled to JavaScript using [BuckleScript](https://bucklescript.github.io/) to be served with [Now](https://now.sh).

### Running

In dev you'll want to run `yarn watch` and `now dev` in two separate windows.

Then visit http://localhost:3000/api/server.bs?num=123

### Deploying

`yarn deploy`
