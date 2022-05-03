
def external
  clone_and_test("sinatra", "https://github.com/sinatra/sinatra.git", "bundle exec rake")
end

private

def clone_and_test(name, remote, test_command)
  require 'fileutils'

  path = "external/#{name}"
  FileUtils.rm_rf path
  FileUtils.mkdir_p path

  system("git", "clone", remote, path)

  # I tried using `bundle config --local local.async ../` but it simply doesn't work.
  # system("bundle", "config", "--local", "local.async", __dir__, chdir: path)

  gemfile_paths = ["#{path}/Gemfile", "#{path}/gems.rb"]
  gemfile_path = gemfile_paths.find{|path| File.exist?(path)}

  # bundle add can't add gems with local paths.
  gemfile_lines = File.readlines(gemfile_path)
  gemfile_lines = gemfile_lines.grep_v(/gem.*?['"](rack|rack-session)['"]/)
  gemfile_lines.push 'gem "rack-session", path: "../../"'
  gemfile_lines.push 'gem "rack", git: "https://github.com/rack/rack.git", branch: "main"'
  File.open(gemfile_path, "w") {|file| file.puts gemfile_lines}

  env = Bundler.unbundled_env
  system(env, "bundle", "install", chdir: path)
  system(env, test_command, chdir: path) or abort("Tests failed!")
end
