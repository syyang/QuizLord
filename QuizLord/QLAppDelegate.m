//
//  QLAppDelegate.m
//  QuizLord
//
//  Created by syyang on 8/1/12.
//  Copyright (c) 2012 quizlord. All rights reserved.
//

#import "QLAppDelegate.h"
#import "QLViewController.h"

@implementation QLAppDelegate

- (void)applicationWillTerminate:(UIApplication *)application
{
  // TODO(syyang): close session
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  QLViewController *qvc = nil;
  if ([[UIDevice currentDevice] userInterfaceIdiom] ==
      UIUserInterfaceIdiomPhone) {
    qvc = [[QLViewController alloc]
      initWithNibName:@"QLViewController_iPhone" bundle:nil];
  } else {
    qvc = [[QLViewController alloc]
      initWithNibName:@"QLViewController_iPad" bundle:nil];
  }

  UINavigationController *unc = [[UINavigationController alloc]
                                 initWithRootViewController:qvc];
  [[self window] setRootViewController:unc];

  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  
  return YES;
}
          
@end
