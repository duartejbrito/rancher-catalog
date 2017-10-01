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
{{- if eq .Values.networkMode "host"}}
    network_mode: host
{{- end}}
{{- if ne .Values.networkMode "host"}}
{{- if ne .Values.hostname ""}}
    hostname: ${hostname}
{{- end}}
{{- end}}
    environment:
      PGID: ${envPGID}
      PUID: ${envPUID}
      TZ: ${envTimezone}
      HOME: '/config'
{{- if ne .Values.envPlexClaim ""}}
      PLEX_CLAIM: ${envPlexClaim}
{{- end}}
{{- if ne .Values.envAllowedNetworks ""}}
      ALLOWED_NETWORKS: ${envAllowedNetworks}
{{- end}}
{{- if eq .Values.networkMode "bridge"}}
{{- if ne .Values.envAdvertiseIp ""}}
      ADVERTISE_IP: 'http://${envAdvertiseIp}:32400'
{{- end}}
{{- end}}
{{- if eq .Values.networkMode "macvlan"}}
    networks:
      external:
        ipv4_address: ${ipv4Address}
networks:
  external:
    driver: macvlan
    driver_opts:
      parent: eth0
    ipam:
      config:
        - subnet: 192.168.1.51/24
          gateway: 192.168.1.254
          ip_range: 192.168.1.51/24 # IP from this pool are assigned automatically
{{- end}}