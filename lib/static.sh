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

# Generate a payload to render the nginx conf
nginx_conf_payload() {
  cat <<-END
{
  "code_dir": "$(nos_code_dir)",
  "data_dir": "$(nos_data_dir)",
  "force_https": $(force_https)
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
