//=============================================================================================================================
//
// Copyright (c) 2015-2017 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
// EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
// and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
//
//=============================================================================================================================
#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define MAINCOLOR    [UIColor colorWithRed:254/255.f green:168/255.f blue:0.f alpha:1]


#import "OpenGLView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "helloar.h"
#import "ArAndSaoBtn.h"

#import <easyar/engine.oc.h>

@interface OpenGLView ()<UIWebViewDelegate>
{
//    IRCameraMask * view;
    BOOL _flag;
    UIButton * btn;
    UIButton * _lastbtn;
}

@end

@implementation OpenGLView {
    BOOL initialized;
}

- (id)initWithFrame:(CGRect)frame
{
    _flag = NO;
    frame.size.width = frame.size.height = MAX(frame.size.width, frame.size.height);
    self = [super initWithFrame:frame];
    self->initialized = false;
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    self.drawableStencilFormat = GLKViewDrawableStencilFormat8;
    [self bindDrawable];

 
    _web = [[UIWebView alloc] initWithFrame:CGRectMake(50, 88,[UIScreen mainScreen].bounds.size.width - 100 ,     [UIScreen mainScreen].bounds.size.height-178)];
    _web.delegate = self;
    _web.alpha = 0.8;
     btn= [[UIButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30)/2, [UIScreen mainScreen].bounds.size.height - 60, 30, 30)];
    btn.hidden = YES;
    [btn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
    [self addSubview:btn];

    NSArray * array = @[@"AR扫描",@"扫一扫"];
    NSArray * picArray = @[@"03",@"扫一扫"];
    for (int i = 0; i < 2; i ++) {
        ArAndSaoBtn * btn = [[ArAndSaoBtn alloc] initWithFrame:CGRectMake(60 + (ScreenWidth - 50- 60*2)*i, ScreenHeigth - 90, 50, 60)];
        if (i == 0) {
            btn.selected = YES;
            _lastbtn = btn;
            [[NSUserDefaults standardUserDefaults] setObject:@"AR" forKey:@"AROrSaoyiSao"];
        }
        btn.tag = 100+i;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setImage:[UIImage imageNamed:picArray[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(ARORSAO:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [self addSubview:btn];
    }
 
    //扫描到图片的 回调通知监听
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"x" object:nil];
    //扫描到二维码的 回调通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEr:) name:@"er" object:nil];
    //视频播放完成 回调通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endPlay:) name:@"endplay" object:nil];
    
    return self;
}

- (void)ARORSAO:(UIButton *)btn{
    if (btn.tag ==100) {//AR
         [[NSUserDefaults standardUserDefaults] setObject:@"AR" forKey:@"AROrSaoyiSao"];
    }else{//扫一扫
         [[NSUserDefaults standardUserDefaults] setObject:@"saoyisao" forKey:@"AROrSaoyiSao"];
    }
    _lastbtn.selected = NO;
    btn.selected = YES;
    _lastbtn = btn;
}
#pragma mark - 扫描二维码
- (void)changeEr:(NSNotification *)sender{
    NSString * urlString = sender.object;
    NSURL * url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}
#pragma mark - 扫描到图片之后的回调
- (void)change:(NSNotification *)sender{
    btn.hidden = NO;
   
    NSString * url = sender.object;
    if (url) {
         [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"sta"];
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];//创建NSURLRequest
        [_web loadRequest:request];
        [self addSubview:_web];
    }
  
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_flag) {
        SystemSoundID soundId;
        NSString *path = [[NSBundle mainBundle ] pathForResource:@"5012" ofType:@"wav"];
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundId);
        // 添加摇动声音
        AudioServicesPlaySystemSound (soundId);
        // 3.设置震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        _flag = NO;
    }

}
#pragma mark - 视频播放完成之后的回调
- (void)endPlay:(NSNotification *)sender{
        [self quxiao];
        NSString * string= sender.object;
        NSURL * url = [NSURL URLWithString:string];
        [[UIApplication sharedApplication] openURL:url];
    
    
}

#pragma mark - 取消视频或网页
- (void)quxiao{
    btn.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setObject:@"暂停" forKey:@"zanting"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"sta"];
    if (_web) {
        [_web removeFromSuperview];
        
    }
}


- (void)start
{
    if (initialize()) {
        start();
    }
}

- (void)stop
{
    stop();
    finalize();
}

- (void)resize:(CGRect)frame orientation:(UIInterfaceOrientation)orientation
{
    float scale;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
        scale = [[UIScreen mainScreen] nativeScale];
#pragma clang diagnostic pop
    } else {
        scale = [[UIScreen mainScreen] scale];
    }

    resizeGL(frame.size.width * scale, frame.size.height * scale);
}

- (void)drawRect:(CGRect)rect
{
    if (!initialized) {
        initGL();
        initialized = YES;
    }
    render();
}

- (void)setOrientation:(UIInterfaceOrientation)orientation
{
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
            [easyar_Engine setRotation:270];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            [easyar_Engine setRotation:90];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [easyar_Engine setRotation:180];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [easyar_Engine setRotation:0];
            break;
        default:
            break;
    }
}

@end
