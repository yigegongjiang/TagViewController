Pod::Spec.new do |s|
s.name = 'TagViewController'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'Show Tags.'
s.homepage = 'https://github.com/adronfan/TagViewController'
s.authors = { '杨帆' => 'adronfan@126.com' }
s.source = { :git => 'https://github.com/adronfan/TagViewController.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'testtttt/TagViewController.{h,m}'
end