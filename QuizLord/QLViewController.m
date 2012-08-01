//
//  QLViewController.m
//  QuizLord
//
//  Created by syyang on 8/1/12.
//  Copyright (c) 2012 quizlord. All rights reserved.
//

#import "QLViewController.h"

@interface QLViewController()

@property (strong, nonatomic) IBOutlet UIButton *buttonPostQuestion;

- (IBAction)postQuestion:(id)sender;

@end

@implementation QLViewController

@synthesize buttonPostQuestion = _buttonPostQuestion;

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewDidUnload
{
  self.buttonPostQuestion = nil;
  [super viewDidUnload];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  
  }
  
  return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
    (UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  if ([[UIDevice currentDevice] userInterfaceIdiom] ==
      UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

- (IBAction)postQuestion:(id)sender
{  
  NSLog(@"Posting a question...");
  // TODO(syyang):
  // Creat question object
  // Post it via thrift client
}

@end
