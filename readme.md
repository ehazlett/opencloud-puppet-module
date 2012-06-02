# OpenCloud Puppet Module

This puppet modules provides integration support with the [OpenCloud](https://github.com/ehazlett/opencloud/) project.  It contains a custom Facter fact that will query the OpenCloud API for all roles that the node contains.  Currently, there is only support for Amazon EC2 instances, but more are planned (Rackspace being the next).

## Installation

To install, clone the repository, and copy the `opencloud` directory to your puppet module path.

## Configuration

Once installed, you will need to create an `opencloud.yml` config.  This repo contains a sample.  By default, the OpenCloud puppet module will look for the file at `/etc/opencloud.yml` or the location set in the environment variable `OPENCLOUD_CONFIG`.  Once configured, Facter will contain the fact `opencloud_roles` with a list of roles set in the OpenCloud admin.
