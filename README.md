# steamcmd-ark
Ark: Survival Evolved dedicated server container using SteamCMD

Edit `/etc/containers/containers.conf` and add:
```
default_ulimits = [
  "nofile=1000000:1000000",
]
```
because the Ark server requires it.

To build the image:
```
sudo podman build . -t=steamcmd-ark
```

Useful environment variables:
```
ARKQUERYPORT=37015
ARKGAMEPORT=7777
ARKRAWPORT=7778
ARKRCONPORT=17777
ARKSERVERNAME="Change me"
ARKSERVERPASS="Change me"
ARKSERVERADMINPASS="Change me"
```

To create the container::
```
sudo podman container create --name=ark_dedicated_server --publish=7777:7777/udp --publish=7778:7778/udp --publish=17777:17777/tcp --publish=37015:37015/udp --env=ARKSERVERNAME="Test server please ignore" --env=ARKSERVERPASS="Change me" --env=ARKSERVERADMINPASS="M2wBPEoCvv"  --volume=ark_save:/home/steam/ark-dedicated/ShooterGame/Saved/ localhost/steamcmd-ark:latest
```

Note that the above `create` command creates and uses a container volume named `ark_save`. On Fedora Server 35 (on which this was all tested/used), this creates a folder for the volume at `/var/lib/containers/storage/volumes/ark_save/_data`. This folder persists the `Saved` folder between container runs, and so should be backed up regularly.

`root` is required for both commands because of the ulimit change. The query port was changed to 37015 (whereas most Ark tutorials suggest 27015) to avoid any potential conflicts from forwarding all 27015 traffic. Obviously ports 7777/udp, 7778/udp, and 37015/udp need to be opened up in any firewall settings and forwarded to the server by any NAT router in the way.

Finally to see the server, open Steam, click View > Servers, and open the Favorites tab. Right-clicking in the favorites tab should let you add a server by IP, in which you should enter `255.255.255.255:37015`. Replace `255.255.255.255` with either the server's local IP (for LAN play) or with your external IP (for net play, assuming you've forwarded the ports correctly). If you modify the query port environment variable, replace `37015` with whatever port you chose.
