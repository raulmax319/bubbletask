Pod::Spec.new do |s|
  s.name             = 'BubbleTask'
  s.version          = '0.0.1'
  s.summary          = 'A short description of BubbleTask.'

  s.homepage         = 'https://github.com/raulmax319/bubbletask'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Raul Max' => 'raulmax319@gmail.com' }
  s.source           = { :git => 'https://github.com/raulmax319/bubblebask.git', :tag => s.version.to_s }
  s.swift_version = '5.3'
  s.ios.deployment_target = '13.0'

  s.default_subspec = 'Release'

  s.subspec 'Release' do |release|
    release.vendored_frameworks = 'BubbleTask.xcframework'
  end

  s.subspec 'Debug' do |debug|
    debug.source_files = 'Lib/**/*'

    debug.test_spec do |test|
      test.source_files = 'Tests/**/*'
    end
  end
end
