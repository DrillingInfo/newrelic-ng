#
# Cookbook Name:: newrelic-ng
# Test:: generic-agent-default
#
# Copyright 2012, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

require File.expand_path('../support/helpers', __FILE__)

describe 'newrelic-ng::generic-agent-default' do
  include Helpers::TestHelper

  it 'installs installs newrelic nginx agent' do
    file("#{node['newrelic-ng']['generic-agent']['target_dir']}/nginx_status_agent/newrelic_nginx_agent.daemon/")
  end

  it 'must set license key (nginx)' do
    file("#{node['newrelic-ng']['generic-agent']['target_dir']}/nginx_status_agent/config/newrelic_plugin.yml").must_include('TESTKEY_GENERIC_AGENT')
  end

  it 'newrelic nginx agent must be running' do
    # service status doesn't work, so grepping process table instead
    cmd = shell_out('ps aux |grep -v grep |grep -q newrelic_nginx_agent')
    cmd.exitstatus.to_s.must_include('0')
  end

  it 'installs installs newrelic sidekiq agent' do
    file("#{node['newrelic-ng']['generic-agent']['target_dir']}/sidekiq_status_agent/newrelic_sidekiq_agent.daemon/")
  end

  it 'must set license key (sidekiq)' do
    file("#{node['newrelic-ng']['generic-agent']['target_dir']}/sidekiq_status_agent/config/newrelic_plugin.yml").must_include('TESTKEY_GENERIC_AGENT')
  end

  it 'newrelic sidekiq agent must be running' do
    # service status doesn't work, so grepping process table instead
    cmd = shell_out('ps aux |grep -v grep |grep -q newrelic_sidekiq_agent')
    cmd.exitstatus.to_s.must_include('0')
  end
end
