# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "myapp"
set :repo_url, "git@github.com:FreeSoulll/image_compress.git"


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/www"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
#append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Path to the folder with application assets
set :assets_dir, ["app/assets", "lib/assets", "vendor/assets"]

# Exclusions from applying link_tree
set :assets_exclude, %w{javascripts/stylesheets/.DS_Store}

# List of directories with static content
set :linked_dirs, fetch(:linked_dirs, []).push('public/system', 'public/uploads', 'public/assets')


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# Skip migration if files in db/migrate were not modified
# Defaults to false
#set :conditionally_migrate, true