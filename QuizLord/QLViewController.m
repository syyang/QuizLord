//
//  QLViewController.m
//  QuizLord
//
//  Created by syyang on 8/1/12.
//  Copyright (c) 2012 quizlord. All rights reserved.
//

#include <stdlib.h>

#import "QLViewController.h"

#import "THTTPClient.h"
#import "TBinaryProtocol.h"
#import "quizlord.h"

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
    (UIInterfaceOrientation)interfaceOrientation
{
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
  
  NSURL *url = [NSURL URLWithString:@"http://localhost:8080"];
  THTTPClient *transport = [[THTTPClient alloc] initWithURL:url];

  TBinaryProtocol *protocol = [[TBinaryProtocol alloc]
                               initWithTransport:transport
                                      strictRead:YES
                                     strictWrite:YES];
  QuestionStoreClient *client = [[QuestionStoreClient alloc]
                                 initWithProtocol:protocol];
  
  NSLog(@"Established connection...");

  NSInteger a = arc4random() % 100;
  NSInteger b = arc4random() % 100;
  
  NSString *questionStr = [NSString stringWithFormat:@"%d + %d", a, b];
  NSString *answerStr = [NSString stringWithFormat:@"%d", a + b];
  
  Question *question = [[Question alloc] initWithQuestion:questionStr
                                                   answer:answerStr];
  NSLog(@"Add question: %@", question);
  [client addQuestion:question];
  
  NSLog(@"Get questions:");
  NSArray * questions = [client getQuestions];
  for (NSString *question in questions) {
    NSLog(@"%@", question);
  }
}

@end
