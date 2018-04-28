//
//  AppDelegate.m
//  ARScan
//
//  Created by youdian on 2018/4/28.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <easyar/engine.oc.h>


NSString * key = @"Lxjf2nXdMEqGLGkPrKG6g4M2ikynHyrFJ1crIIyv9LzaeMnXA98gLBsmVRqK0TvoZnLgqFMVxsi8TALax0fiXEtk0WtVJ3Vu3R2YTRE678TQCLugWXFiaiaAVQxY60VEL7VUGhbWeYZryJntf6rjOLXS86Crs9qbrA6sBVyf1Q9VU3r1oT7PQUc3ep6MOcR1rCpBNV8p";
NSString * cloud_server_address = @"6296c09052012b394de6c002d7b81508.cn1.crs.easyar.com:8080";
NSString * cloud_key = @"a1d3c25006629cf8e3bbabd0c64003dd";
NSString * cloud_secret = @"kYSRElAeH4ceubOnGnBiMqyrHYUgspVHZqBcibifXD10ldVjwhU1RGRwebMjGsry7ItPyreLGBQfG5ZB6IzSKspVmhOeLGQ3ZkB08G7BPE9gSnZyLQiscnHiEOiBS5I8";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    if (![easyar_Engine initialize:key]) {
        NSLog(@"Initialization Failed.");
    }
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[MainViewController new]];
    self.window.rootViewController  = nav;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
