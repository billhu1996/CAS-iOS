# CAS-iOS
CAS Client for iOS(using Restful API)

## How To Get Started

#### Podfile

```
source 'https://github.com/billhu1996/CAS-iOS.git'
platform :ios, '10.0'

target 'TargetName' do
  use_frameworks!
  pod 'CAS-iOS'
end
```

```

    NSString *loginURL = @"";
    [CAS defaultCAS].casServer = @"";
    [CAS defaultCAS].path = @"";
    //Get TGT
    [[CAS defaultCAS] requestTGTWithUsername:@"" password:@"" callBackBlock:^(NSString * tgt, NSError * error) {
        if (!error) {
            NSLog(@"%@", tgt);
            //Get ST
            [[CAS defaultCAS] requestSTForService:loginURL callBackBlock:^(NSString *st, NSError *error) {
                if (!error) {
                    NSLog(@"%@", st);
                    //Using ST
                    NSString *url = [NSString stringWithFormat:@"%@?ticket=%@", loginURL, st];
                    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
                    [[CAS defaultCAS] sendrequestWithRequest:req callBackBlock:^(NSData *data, NSURLResponse *resp, NSError *error) {
                        if (!error) {
                            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            if (info) {
                                NSLog(@"%@", info[@"xm"]);
                            }
                        }
                    }];
                } else {
                    NSLog(@"%@", error);
                }
            }];
        } else {
            NSLog(@"%@", error);
        }
    }];

```
