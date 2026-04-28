{{/*
Expand the name of the chart.
*/}}
{{- define "livekit-sip.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "livekit-sip.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "livekit-sip.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Determine the listening ports to expose
*/}}
{{- define "livekit-sip.listenPortSIP" -}}
{{- default .Values.livekit.sip_port .Values.livekit.sip_port_listen }}
{{- end }}

{{- define "livekit-sip.listenPortTLS" -}}
{{- default .Values.livekit.tls.port .Values.livekit.tls.port_listen }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "livekit-sip.labels" -}}
helm.sh/chart: {{ include "livekit-sip.chart" . }}
{{ include "livekit-sip.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "livekit-sip.selectorLabels" -}}
app.kubernetes.io/name: {{ include "livekit-sip.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "livekit-sip.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "livekit-sip.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service monitor to use
*/}}
{{- define "livekit-sip.serviceMonitorName" -}}
{{- if .Values.serviceMonitor.create }}
{{- default (include "livekit-sip.fullname" .) .Values.serviceMonitor.name }}
{{- else }}
{{- default "default" .Values.serviceMonitor.name }}
{{- end }}
{{- end }}
