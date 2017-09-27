# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# Copy the code into the live directory which will be used to run the app
publish_release() {
  nos_print_bullet "Moving build into live code directory..."
	rsync -a $(nos_code_dir)/$(rel_dir)/ $(nos_app_dir)
}

# Install the node runtime along with any dependencies.
install_runtime_packages() {
  pkgs=("nginx")

  nos_install ${pkgs[@]}
}

# force https if it's required
force_https() {
	echo $(nos_validate "$(nos_payload "config_force_https")" "boolean" "false")
}

# directory to serve up via nginx
rel_dir() {
	echo $(nos_validate "$(nos_payload "config_rel_dir")" "string" "public")
}

expires() {
  declare -a expires_list
  if [[ "${PL_config_expires_type}" = "array" ]]; then
    for ((i=0; i < PL_config_expires_length ; i++)); do
      type=PL_config_expires_${i}_type
      if [[ ${!type} = "map" ]]; then
        extension=PL_config_expires_${i}_extension_value
        duration=PL_config_expires_${i}_duration_value
        if [[ -n ${!extension} && -n ${!duration} ]]; then
          entry="{\"extension\":\"${!extension}\",\"duration\":\"${!duration}\"}"
          expires_list+=("${entry}")
        fi
      fi
    done
  fi
  if [[ -z "expires_list[@]" ]]; then
    echo "[]"
  else
    echo "[ $(nos_join ',' "${expires_list[@]}") ]"
  fi
}

# Generate a payload to render the nginx conf
nginx_conf_payload() {
  cat <<-END
{
  "code_dir": "$(nos_code_dir)",
  "data_dir": "$(nos_data_dir)",
  "force_https": $(force_https),
  "expires": $(expires)
}
END
}

# Generate an nginx conf
configure_nginx() {
	mkdir -p $(nos_data_dir)/var/tmp/nginx/client_body_temp
  nos_template \
    "nginx/nginx.conf" \
    "$(nos_etc_dir)/nginx/nginx.conf" \
    "$(nginx_conf_payload)"
}
