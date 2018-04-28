//
//  MainViewController.m
//  ARScan
//
//  Created by youdian on 2018/4/28.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 120, 55);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(scanAR) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    // Do any additional setup after loading the view.
}




-(void)scanAR{
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
