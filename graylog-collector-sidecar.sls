{%- load_yaml as versions %}
- 0.1.6 
- 0.1.5 
- 0.1.4 
- 0.1.3 
- 0.1.2 
- 0.1.1 
- 0.1.0
- 0.1.8
- 1.0.1
- 1.0.2
- 1.1.0
- 1.2.0
- 1.3.0
- 1.4.0
- 1.5.0
{%- endload %}

graylog-collector-sidecar:
  {% for version in versions %}
    {% if salt["pkg.compare_versions"](version, "<", "1.0.0") -%}
    {%   set collectorAddition = " Collector" -%}
    {%   set appFilePrefix = "collector" -%}
    {% endif -%}
  '{{ version }}':
    full_name: Graylog{{ collectorAddition || default("") }} Sidecar
    installer: 'https://github.com/Graylog2/collector-sidecar/releases/download/{{ version }}/{{ appFilePrefix || default("graylog") }}_sidecar_installer_{{ version }}-1.exe'
    install_flags: '/S'
    uninstaller: '%ProgramFiles%\graylog\collector-sidecar\uninstall.exe'
    uninstall_flags: '/S'
    msiexec: False
    locale: en_US
    reboot: False
  {% endfor %}
