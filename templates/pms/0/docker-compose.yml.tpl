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
    environment:
      PGID: ${envPGID}
      PUID: ${envPUID}
      TZ: ${envTimezone}
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
      HOME: '/config'