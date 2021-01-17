# netatalk-gs - minimalist netatalk-2.2.6 container 

netatalk-gs uses netatalk-2.2.6 to provide read-only guest access to an [AFP](https://en.wikipedia.org/wiki/Apple_Filing_Protocol) share for the Apple IIgs and some very old versions of MacOS.

The default container does not provide any auto-discovery, or any connectivity beyond the TCP/IP layer, i.e. no DDP/EtherTalk, Name Binding, etc.

This service is designed primarily for use on the Apple IIgs with [AFPBridge](https://sheumann.github.io/AFPBridge/) and [Marinetti](http://www.apple2.org/marinetti/) via an [Uthernet-II](http://a2retrosystems.com/index.htm) Ethernet card for the Apple II series. 

The default configuration of netatalk-gs provides a share called share.afp published on the standard AFP TCP port 548.

## Examples

Specify the path you want to share to your GS for [local path]:

```bash
docker run -d -p 548:548 -v [local path]:/share/afp table2eng/netatalk-gs:1.0
```
You can customize the share name using *-e sharename=*

```bash
docker run -d -p 548:548 -e sharename=mystuff -v [local path]:/share/afp table2eng/netatalk-gs:1.0
```

Note that sharename should comply to the AFP v2.2 naming standards. 

## On the Apple IIgs

Refer to the [Marinetti](http://www.apple2.org/marinetti/) and [Uthernet-II](http://a2retrosystems.com/index.htm) documentation for setting up your TCP/IP link layer. Refer to the [AFPBridge](https://sheumann.github.io/AFPBridge/) documentation for general information about configuring AFP Mounter. 

For netatalk-gs, read-only guest access is used (no username or password,) and there is no name binding, so you would specify the share via the IP address of your docker host:

```
afp://192.168.1.100/share.afp
```

You will need to select the arrow in the upper right of the AFP Mounter window and check "Force AFP Version 2.2."

## Troubleshooting

- Make sure your TCP/IP Link Layer is configured properly. 
- Verify that your sharename meets AFP v2.2 standards, or use the default share.afp
- Verify that your firewall allows TCP port 548 from your GS
- Use docker tools to view the logs from the container (docker ps, docker logs)

## BUGS

The share will disconnect from an Apple IIgs when attempting to transfer a file larger than 600k. This may be a memory limitation on my hardware, or an issue with AFP 2.2 vs. 2.0. 

## Acknowledgments

Huge thanks to [@sheumann](https://sheumann.github.io/AFPBridge/) for his work on providing [AFPBridge](https://sheumann.github.io/AFPBridge/) to the Apple IIgs community, and thanks to @cptactionhank for the general concept of the netatalk container.

## WARNING

This container is provided as-is with no warranty either express or implied. The netatalk-2.2.6 code is deprecated and may contain flaws. Use at your own risk. 

## Contributions

Contributions to this system are welcomed via GitHub Issues or PRs as long as they are within the scope of providing an easy to use turnkey solution for retro-computer enthusiasts needing to use AFP 2.2 over TCP.

## TODO

It should be possible to support AFP 2.0, and support for EtherTalk and similar could also be made to work, athough I lack any equipment with which to test those.

It would also be nice to support usernames and passwords, although they would be limited to randnum exchange and thus considered insecure. 

