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
    # webserver config
    force_https: true
    
    # rel_dir (directory to serve up)
    rel_dir: public
    
    # static asset expiration
    expires:
      extension: jpg|jpeg|png|gif|ico|css|js
      duration: 365d
```

## Generic Usage

todo: explain how to add dev_packages, extra_steps, and cache_dirs to make a site generator work

## Help & Support
This is a static engine provided by [Nanobox](http://nanobox.io). If you need help with this engine, you can reach out to us in the [#nanobox IRC channel](http://webchat.freenode.net/?channels=nanobox). If you are running into an issue with the engine, feel free to [create a new issue on this project](https://github.com/nanobox-io/nanobox-engine-elixir/issues/new).
