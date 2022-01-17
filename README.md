# Dancing Monkeys in Docker

This repo contains a Dockerfile that allows you to run [Dancing
Monkeys](https://monket.net/dancing-monkeys/) inside a
container. Dancing Monkeys is an old matlab application used (in this case) to
calculate **precise** BPM and offsets for music to be used with rhythm games such as
[StepMania](https://www.stepmania.com/).

This builds on the popular [docker
image](https://github.com/scottyhardy/docker-wine) for running wine in general,
something I very much appreciate not having to set up myself!

I haven't yet pushed an image based on this to dockerhub, I first want to make
sure it works as intended, and figure out the not obvious licensing issue since
pushing essentially means I'm distributing binaries.

## How to build
```
$ docker build -t tobsan/docker-monkeys .
```

## How to run
You'll need to give docker access to whatever music file you want to use,
preferably by bind-mounting its directory. Then use that path as argument when
running the image. Any arguments after the music argument will be passed on to
Dancing Monkeys.

```
$ docker run -v ~/Music/:/music tobsan/docker-monkeys --music /music/mysong.mp3
```
