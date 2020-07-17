{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "demo-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "demo-helm.fullname" -}}
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
{{- define "demo-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "demo-helm.labels" -}}
helm.sh/chart: {{ include "demo-helm.chart" . }}
{{ include "demo-helm.selectorLabelsBlue" . }}
{{ include "demo-helm.selectorLabelsGreen" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels - blue
*/}}
{{- define "demo-helm.selectorLabelsBlue" -}}
app.kubernetes.io/name: {{ include "demo-helm.name" . }}-blue
app.kubernetes.io/instance: {{ .Release.Name }}-blue
{{- end }}

{{/*
Selector labels - green
*/}}
{{- define "demo-helm.selectorLabelsGreen" -}}
app.kubernetes.io/name: {{ include "demo-helm.name" . }}-green
app.kubernetes.io/instance: {{ .Release.Name }}-green
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "demo-helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "demo-helm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
