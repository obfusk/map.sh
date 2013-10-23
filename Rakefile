cuke = ENV['CUKE']

desc 'Run cucumber'
task :cuke do
  sh "cucumber -fprogress #{cuke}"
end

desc 'Run cucumber strictly'
task 'cuke:strict' do
  sh "cucumber -fprogress -S #{cuke}"
end

desc 'Run cucumber verbosely'
task 'cuke:verbose' do
  sh "cucumber #{cuke}"
end

desc 'Run cucumber verbosely, view w/ less'
task 'cuke:less' do
  sh "cucumber -c #{cuke} | less -R"
end

desc 'Cucumber step defs'
task 'cuke:steps' do
  sh 'cucumber -c -fstepdefs | less -R'
end
