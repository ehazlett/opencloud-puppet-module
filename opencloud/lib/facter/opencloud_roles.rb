require 'net/http'
require 'yaml'
require 'json'
require 'logger'

log = Logger.new(STDOUT)

Facter.add("opencloud_roles") do
  setcode do
    roles = Array.new
    begin
      if ENV['OPENCLOUD_CONFIG']
        cfg_file = ENV['OPENCLOUD_CONFIG']
      else
        cfg_file = '/etc/opencloud.yml'
      end
      cfg = YAML::load(File::open(cfg_file).read())
      server = cfg['server']
      port = cfg['port']
      api_key = cfg['api_key']
      # check for ec2 node
      node_id = Facter.value('ec2_instance_id')
      if node_id
        puts node_id
        # get remote roles
        req = Net::HTTP::Get.new('/api/v1/nodes/' + node_id + '/roles')
        req.add_field('x-api-key', api_key)
        res = Net::HTTP.new(server, port).start do |http|
          if cfg['use_ssl']
            http.use_ssl = true
          end
          http.request(req)
        end
        roles = JSON.parse(res.body)['roles']
        puts roles
      else
        log.warn('Unable to get node ID')
      end
    rescue
      log.error('Unable to read ' + cfg_file)
    end
    roles
  end
end
