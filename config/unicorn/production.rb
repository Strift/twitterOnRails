worker_processes 2
timeout 60


before_exec do |_server|
  ENV['BUNDLE_GEMFILE'] = '/home/Strift/twitter_on_rails/current/Gemfile'
end

working_directory '/home/Strift/twitter_on_rails/current/' # available in 0.94.0+

listen '/tmp/unicorn.sock'

pid '/home/Strift/twitter_on_rails/current/tmp/pids/unicorn.pid'

stderr_path '/home/Strift/twitter_on_rails/unicorn.stderr.log'
stdout_path '/home/Strift/twitter_on_rails/unicorn.stdout.log'

preload_app true
GC.respond_to?(:copy_on_write_friendly=) &&
  (GC.copy_on_write_friendly = true)

check_client_connection false

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
  if old_pid != server.pid
    begin
        sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
        Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
  end
end

after_fork do |_server, _worker|
  # other settings
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end