{{/*
Expand the name of the chart.
*/}}
{{- define "hello-world.fullname" -}}
{{- printf "%s-%s" .Release.Name "hello-world" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a name for the app label.
*/}}
{{- define "hello-world.name" -}}
hello-world
{{- end -}}

{{/*
Create a chart label.
*/}}
{{- define "hello-world.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}
