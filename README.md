# Static

This is a basice engine used to launch static apps on [Nanobox](http://nanobox.io).

## Usage
To use the static engine, specify `static` as your `engine` in your boxfile.yml.

```yaml
run.config:
  engine: static
```

## Configuration Options
This engine exposes configuration options through the [boxfile.yml](http://docs.nanobox.io/boxfile/), a yaml config file used to provision and configure your app's infrastructure when using Nanobox. This engine makes the following options available.

#### Overview of Boxfile Configuration Options
```yaml
run.config:
  engine.config:
    # whether to redirect http to https
    force_https: true
    
    # the directory to serve up
    rel_dir: public

    # optional custom error pages
    error_pages:
      - errors: 404
        page: errors/404/index.html
```

## Generic Usage
The only configuration you need to do is to point the system to the directory containing the files to be served by the web server. This can be configured in the engine config in the boxfile with the `rel_dir` option as demonstrated above. The path should be relative to the directory the boxfile is in, and should not have a trailing slash.

To redirect http traffic to https you can specify `force_https: true` as shown above. By default https is not enforced.

### Custom error pages

It is possible to optionally specify your own error pages for different HTTP status codes. For this you can specify `error_pages` in `engine.config` as shown above.

For each error page you add to the list you can specify multiple errors by listing the error codes separated by a space, as shown below.

```yaml
error_pages:
  - errors: 500 502 503 504
    page: errors/500/index.html
```

### Using site generators
If your site requires some processing, for example a compile step to turn your templates into plain html, you can still use this engine. In the explanation below [Jekyll](https://jekyllrb.com/) is used as an example.

First you need to identify which packages you require. For Jekyll you need at least `ruby24-bundler` and most likely `nodejs`. You can specify these packages in the `dev_packages` setting in the boxfile. The packages will only be used in the compile step on your machine, so they will not be available in production. An example of this can be found below.

After specifying the packages the last thing to do is to list the commands required to compile your site in `extra_steps` as shown below.

```yaml
run.config
  dev_packages:
    - ruby24-bundler
    - nodejs

deploy.config
  extra_steps:
    - bundle install
    - bundle exec jekyll build
```

## Help & Support
This is a static engine provided by [Nanobox](http://nanobox.io). If you need help with this engine, you can reach out to us in the [#nanobox IRC channel](http://webchat.freenode.net/?channels=nanobox). If you are running into an issue with the engine, feel free to [create a new issue on this project](https://github.com/nanobox-io/nanobox-engine-elixir/issues/new).
