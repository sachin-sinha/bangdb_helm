{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bangdb-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bangdb-chart.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bangdb-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "bangdb-chart.labels" -}}
app.kubernetes.io/name: {{ include "bangdb-chart.name" . }}
helm.sh/chart: {{ include "bangdb-chart.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "bangdb-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "bangdb-chart.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper Storage Class
*/}}
{{- define "bangdb.storageClass" -}}
    {{- if .Values.persistence.storageClass -}}
        {{- if (eq "-" .Values.persistence.storageClass) -}}
            {{- printf "storageClassName: \"\"" -}}
        {{- else }}
            {{- printf "storageClassName: %s" .Values.persistence.storageClass -}}
        {{- end -}}
    {{- end -}}
{{- end -}}

{{/*
Create a default fully qualified name for Ampere
*/}}
{{- define "bangdb-chart.ampere.fullname" -}}
{{ template "bangdb-chart.fullname" . }}-{{ .Values.ampere.name }}
{{- end -}}

{{/*
Create the name of the service account to use for the ampere component
*/}}

{{- define "bangdb-chart.serviceAccountName.ampere" -}}
{{- if .Values.ampere.serviceAccount.create -}}
    {{ default (include "bangdb-chart.ampere.fullname" .) .Values.ampere.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.ampere.serviceAccount.name }}
{{- end -}}
{{- end -}}