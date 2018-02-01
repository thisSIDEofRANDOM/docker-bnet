# Battle.net docker image

This image provides a Battle.net Client for Linux and macOS(testing).

It is based on [i386/debian:stretch-slim](https://hub.docker.com/r/i386/debian/) and wine-staging 2.21.
Much credit to the work of pauleve on his [docker-mtgo](https://github.com/pauleve/docker-mtgo) project.

Using Battle.net inside wine is unsupported and attempting to do so is at your own risk. 
Blizzard has been known to accidently been users running battlenet on Linux so be sure you are OK with the risks!

All copyrights and ownership for Battle.net belong to Blizzard Inc.

See [WineHQ](https://appdb.winehq.org/objectManager.php?iId=28855&sClass=version) for more information on this project.

### Note for macOS users

MacOS support is still under test.
Using [Homebrew](https://brew.sh/), install XQuartz, socat, and the GNU version of getopt:

```
brew cask install xquartz 
brew install socat gnu-getopt wget
```
Then **restart your session** (or reboot) and follow the standard usage.

## Usage

Here are basic usage instructions.
You may want to have a look at the [wiki](https://github.com/thisSIDEofRANDOM/docker-bnet/wiki) as well.

Run the docker image using [run-bnet](./run-bnet?raw=true) helper script
```
./run-bnet
```

The script `run-bnet` can be installed and upgraded as follows:
```
wget -O run-bnet https://raw.githubusercontent.com/thisSIDEofRANDOM/docker-bnet/master/run-bnet
chmod +x run-bnet
```

If you want to customize wine (notably the graphics), you can use
```
./run-bnet --winecfg
```

To ensure running the latest docker image, use
```
./run-bnet --update
```

See
```
./run-bnet --help
```
for other options.

## Troubleshooting
* `run-bnet` never exits, even after <kbd>Ctrl</kbd>+<kbd>C</kbd>:
```
docker kill bnet_running
```

## FAQ

* FAQ to come
