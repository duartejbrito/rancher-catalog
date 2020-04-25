version: '2'
services:
  plex-media-server:
    image: plexinc/pms-docker:plexpass
    restart: unless-stopped
    volumes:
    - ${volumeConfig}:/config:rw
    - ${volumeData}:/data:rw
    - ${volumeMedia}:/media:rw
    - ${volumeTranscode}:/transcode:rw
    - ${volumeTmp}:/tmp:rw
{{- if eq .Values.networkMode "host"}}
    network_mode: host
{{- end}}
{{- if ne .Values.networkMode "host"}}
{{- if ne .Values.hostname ""}}
    hostname: ${hostname}
{{- end}}
{{- end}}
    environment:
      PLEX_GID: ${envPGID}
      PLEX_UID: ${envPUID}
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
      default:
        ipv4_address: ${ipv4Address}
networks:
  vlan:
    external:
      name: external
{{- end}}