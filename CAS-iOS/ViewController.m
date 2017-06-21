//
//  ViewController.m
//  CAS-iOS
//
//  Created by Bill Hu on 2017/6/21.
//  Copyright © 2017年 ifLab. All rights reserved.
//

#import "ViewController.h"
#import "CAS.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *loginURL = @"";
    [CAS defaultCAS].casServer = @"";
    [CAS defaultCAS].path = @"";
    [[CAS defaultCAS] requestTGTWithUsername:@"" password:@"" callBackBlock:^(NSString * tgt, NSError * error) {
        if (!error) {
            NSLog(@"%@", tgt);
            
            [[CAS defaultCAS] requestSTForService:loginURL callBackBlock:^(NSString *st, NSError *error) {
                if (!error) {
                    NSLog(@"%@", st);
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
}

@end
