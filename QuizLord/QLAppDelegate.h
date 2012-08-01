//
//  QLAppDelegate.h
//  QuizLord
//
//  Created by syyang on 8/1/12.
//  Copyright (c) 2012 quizlord. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QLViewController;

@interface QLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) QLViewController *rootViewController;

@end
