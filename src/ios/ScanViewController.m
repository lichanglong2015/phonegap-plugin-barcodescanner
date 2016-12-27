//
//  ScanViewController.m
//  TGou
//
//  Created by Franklin Zhang on 11/16/15.
//  Copyright © 2015 macrame. All rights reserved.
//

#import "ScanViewController.h"
#import "Constant.h"

#define screenW [UIScreen mainScreen].bounds.size.width

#define screenH [UIScreen mainScreen].bounds.size.height

@interface ScanViewController ()
{
    UIView *previewView;
    UIImageView *scanLineView;
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *videoPreviewLayer;
}
@end

@implementation ScanViewController
@synthesize titleLabel = titleLabel;
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void) cancelAction:(id) sender
{
    [self stopReading];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)loadView
{
    [super loadView];
    
    self.title = @"扫一扫";
    
    [self buildLayout];
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self startReading];
}
//设置状态栏为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) buildLayout
{
    
    
    CGRect viewRect = self.view.frame;
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewRect.size.width, viewRect.size.height)];
    
    previewView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    previewView.backgroundColor = [UIColor clearColor];
    previewView.hidden = YES;
    [mainView addSubview:previewView];
    
//  创建顶部界面
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 60)];
    topView.backgroundColor = [UIColor blackColor];
    [mainView addSubview:topView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"left_indicator"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(7.5, 0, 60, 60);
    [backButton addTarget:self action:@selector(cancelScan:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 28, 20, 20)];
    
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"CDVBarcodeScanner" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    NSString *QRSbackArrowPath = [bundle pathForResource:@"QRSbackArrow" ofType:@"png"];
    NSString *scannerImagePath = [bundle pathForResource:@"scannerImage" ofType:@"png"];
    NSString *line_saoyisao_03Path = [bundle pathForResource:@"line_saoyisao_03" ofType:@"png"];
//    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    backImage.image = [UIImage imageNamed:QRSbackArrowPath];
    [backButton addSubview:backImage];

    UILabel *qrTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenW - 100) / 2, 28, 100, 20)];
    qrTitleLabel.textColor = [UIColor whiteColor];
    qrTitleLabel.text = @"扫描二维码";
    qrTitleLabel.font = [UIFont systemFontOfSize:17];
    qrTitleLabel.textAlignment = NSTextAlignmentCenter;
//    [qrTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [topView addSubview:qrTitleLabel];
    
//    二维码扫描框
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(screenW *0.15, (viewRect.size.height - screenW *0.7)/2, screenW *0.7, screenW *0.7)];
    
    
    imageView.image = [UIImage imageNamed:scannerImagePath];
    [mainView addSubview:imageView];
//    扫描线
    scanLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:line_saoyisao_03Path]];
    scanLineView.frame = CGRectMake(screenW *0.15, (viewRect.size.height - screenW *0.7)/2, screenW *0.7, 2);
    [mainView addSubview:scanLineView];
    [self.view addSubview:mainView];
    
//    背景遮罩层
    UIView *coverView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 60, screenW, CGRectGetMinY(imageView.frame) - 60)];
    coverView1.backgroundColor = [UIColor blackColor];
    coverView1.alpha = 0.5;
    
    UIView *coverView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(coverView1.frame), CGRectGetMinX(imageView.frame), CGRectGetMaxY(imageView.frame) - CGRectGetMaxY(coverView1.frame))];
    coverView2.backgroundColor = [UIColor blackColor];
    coverView2.alpha = 0.5;
    
    UIView *coverView3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), CGRectGetMaxY(coverView1.frame), screenW - CGRectGetMaxX(imageView.frame), CGRectGetMaxY(imageView.frame) - CGRectGetMaxY(coverView1.frame))];
    coverView3.backgroundColor = [UIColor blackColor];
    coverView3.alpha = 0.5;
    
    UIView *coverView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), screenW, screenH - CGRectGetMinY(imageView.frame))];
    coverView4.backgroundColor = [UIColor blackColor];
    coverView4.alpha = 0.5;
    
    [mainView addSubview:coverView1];
    [mainView addSubview:coverView2];
    [mainView addSubview:coverView3];
    [mainView addSubview:coverView4];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(imageView.frame) + 10, viewRect.size.width-20, 21)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"请将二维码放置于取景框内";
    [mainView addSubview:titleLabel];
    
}

- (void) startReading
{
    NSError *error;
    NSArray *deviceList = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    if(deviceList.count < 1)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"Common.Failure",nil)
                              message:@"This deivce does not support QR scan"
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Common.OK",nil)
                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    previewView.hidden = NO;
    AVCaptureDevice *captureDevice = [deviceList objectAtIndex:0];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if(!input)
    {
        NSLog(@"error:%@",error.localizedDescription);
    }
    captureSession = [[AVCaptureSession alloc] init];
    [captureSession addInput:input];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [captureSession addOutput:output];
    
    videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    videoPreviewLayer.frame = previewView.layer.bounds;
    [previewView.layer addSublayer:videoPreviewLayer];
//    先执行该方法，再获取扫描范围
    [captureSession startRunning];
//    metadataOutputRectOfInterestForRect方法必须在startRunning方法执行后才有效
    CGRect rect =  CGRectMake(screenW *0.15, (screenH - screenW *0.7)/2, screenW *0.7, screenW *0.7);
//    获取扫描范围
    CGRect intertRect = [videoPreviewLayer metadataOutputRectOfInterestForRect:rect];
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("scanQR", NULL);
    [output setMetadataObjectsDelegate:self queue:dispatchQueue];
    [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
//    output.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    output.rectOfInterest = intertRect;
    
   
    [self startAnimation];
}
- (void) stopReading
{
    [captureSession stopRunning];
    captureSession = nil;
    [videoPreviewLayer removeFromSuperlayer];
    [self endAnimation];
    
}
- (void) cancelScan:(id)sender
{
    [self.parVC dismissViewControllerAnimated:YES completion:^{
        self.cancelScanAction(@"cancel");
    }];
}
- (void) startAnimation
{
    /*[UIView animateWithDuration:2.0 animations:^{
     sectorImage.transform = CGAffineTransformMakeRotation(M_PI * 2.0);
     } completion:^(BOOL finished) {
     if(finished)
     {
     [self startRotateSector];
     }
     }];*/
    [UIView setAnimationRepeatAutoreverses:YES];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    rotationAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, (kScreenHeight - screenW *0.7)/2)];
    rotationAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2, (screenH - screenW *0.7) / 2 + screenW *0.7)];
    rotationAnimation.autoreverses = NO;
    
    //[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 3;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [scanLineView.layer addAnimation:rotationAnimation forKey:nil];
    
}

- (void) endAnimation
{
    [scanLineView.layer removeAllAnimations];
}
#pragma mark – private function
- (void) quickResponseCodeDidFinished:(NSString *)result
{
    if(self.finishScanAction){
        [self.parVC dismissViewControllerAnimated:YES completion:^{
            NSLog(@"%@",result);
        }];
        self.finishScanAction(result);
    }else
        titleLabel.text = result;
}
#pragma mark –
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if(metadataObjects != nil && metadataObjects.count >0)
    {
        NSLog(@"has something");
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            NSString *result = metadataObject.stringValue;
            NSLog(@"Scan result = %@",result);
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:YES];
            
            [self performSelectorOnMainThread:@selector(quickResponseCodeDidFinished:) withObject:result waitUntilDone:NO];
        }
    }
}
//不允许横屏
- (BOOL)shouldAutorotate
{
    return NO;
}

@end
