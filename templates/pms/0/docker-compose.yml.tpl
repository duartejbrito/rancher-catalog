version: '2'
services:
  plex-media-server:
    image: plexinc/pms-docker
    restart: unless-stopped
    volumes:
    - ${volumeConfig}:/config:rw
    - ${volumeData}:/data:rw
    - ${volumeMedia}:/media:rw
    - ${volumeTranscode}:/transcode:rw
    network_mode: host
    environment:
      VERSION: latest 
      PGID: ${envPGID}
      PUID: ${envPUID}
      TZ: ${envTimezone}
      ADVERTISE_IP: ${envAdvertiseIp}
      ALLOWED_NETWORKS: ${envAllowedNetworks}
      HOME: '/config'