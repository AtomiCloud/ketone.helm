{{/*
Expand the name of the chart.
*/}}
{{- define "let___platform___-let___service___.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
allows triming of names
*/}}
{{- define "let___platform___-let___service___.fullname-with-suffix" -}}
{{ $fname := (include "let___platform___-let___service___.fullname" .root) }}
{{- printf "%s-%s" $fname .arg | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "let___platform___-let___service___.fullname" -}}
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
{{- define "let___platform___-let___service___.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "let___platform___-let___service___.labels" -}}
helm.sh/chart: {{ include "let___platform___-let___service___.chart" . }}
{{- range $k, $v := .Values.serviceTree }}
"atomi.cloud/{{ $k }}": "{{ $v }}"
{{- end }}
{{ include "let___platform___-let___service___.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "let___platform___-let___service___.annotations" -}}
helm.sh/chart: {{ include "let___platform___-let___service___.chart" . }}
{{- range $k, $v := .Values.serviceTree }}
"atomi.cloud/{{ $k }}": "{{ $v }}"
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "let___platform___-let___service___.selectorLabels" -}}
app.kubernetes.io/name: {{ include "let___platform___-let___service___.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- range $k, $v := .Values.atomiLabels }}
"atomi.cloud/{{ $k }}": "{{ $v }}"
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "let___platform___-let___service___.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "let___platform___-let___service___.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
