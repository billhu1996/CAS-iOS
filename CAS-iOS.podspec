Pod::Spec.new do |s|

  s.name          = "CAS-iOS"
  s.version       = "0.0.1"
  s.summary       = "CAS Client for iOS(using Restful API)."
  s.homepage      = "https://github.com/billhu1996/CAS-iOS"
  s.license       = "MIT"
  s.author        = { "billhu1996" => "billhu1996@gmail.com" }
  s.platform      = :ios
  s.platform      = :ios, "5.0"
  s.source        = { :git => "https://github.com/billhu1996/CAS-iOS.git", :tag => "#{s.version}" }
  s.source_files  = "CAS-iOS/CAS/CAS.{h,m}"
  s.requires_arc = true

end
