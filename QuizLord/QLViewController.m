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

@property (nonatomic, strong) IBOutlet UIButton *postQuestionButton;
@property (nonatomic, strong) IBOutlet UILabel *questionField;
@property (nonatomic, strong) IBOutlet UILabel *answerField;

@property (nonatomic, strong) QuestionStoreClient *questionStore;
@property (nonatomic, strong) NSOperationQueue *mainQueue;
@property (nonatomic, strong) NSOperationQueue *asyncQueue;

- (IBAction)postQuestion:(id)sender;

@end

@implementation QLViewController

@synthesize postQuestionButton = _postQuestionButton;
@synthesize questionField = _questionField;
@synthesize answerField = _answerField;

- (void)viewDidLoad
{
  [super viewDidLoad];

  _mainQueue = [NSOperationQueue mainQueue];
  _asyncQueue = [[NSOperationQueue alloc] init];
  [_asyncQueue setMaxConcurrentOperationCount:2];

  NSURL *url = [NSURL URLWithString:@"http://localhost:8080"];
  THTTPClient *transport = [[THTTPClient alloc] initWithURL:url];

  TBinaryProtocol *protocol = [[TBinaryProtocol alloc]
                               initWithTransport:transport
                               strictRead:YES
                               strictWrite:YES];
  _questionStore = [[QuestionStoreClient alloc] initWithProtocol:protocol];

  NSLog(@"Initialized client: %@", url);
}

- (void)viewDidUnload
{
  self.postQuestionButton = nil;
  self.questionField = nil;
  self.answerField = nil;
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

  int a = arc4random() % 100;
  int b = arc4random() % 100;
  
  NSString *questionStr = [NSString stringWithFormat:@"%d + %d", a, b];
  NSString *answerStr = [NSString stringWithFormat:@"%d", a + b];
  
  Question *question = [[Question alloc] initWithQuestion:questionStr
                                                   answer:answerStr];

  // update the labels
  [_questionField setText:questionStr];
  [_answerField setText:answerStr];

  NSLog(@"Add question: %@", question);
  [_questionStore addQuestion:question];
  
  NSLog(@"Get questions:");
  NSArray * questions = [_questionStore getQuestions];
  for (NSString *question in questions) {
    NSLog(@"%@", question);
  }
}

@end
