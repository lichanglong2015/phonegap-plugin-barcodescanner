//
//  ScanViewController.h
//  TGou
//
//  Created by Franklin Zhang on 11/16/15.
//  Copyright © 2015 macrame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, copy) void(^finishScanAction)(NSString *result);
@property (nonatomic, copy) void(^cancelScanAction)(NSString *result);
//父控制器
@property (nonatomic,strong) UIViewController *parVC;

@end
