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

static NSString *kAPI_SERVER_BASE_URL = @"http://localhost:8080";

///////////////////////////////////////////////////////////////////////////////////////////////////

@interface QLViewController()

// private properties
@property (nonatomic, strong) IBOutlet UIButton *postQuestionButton;
@property (nonatomic, strong) IBOutlet UILabel *questionField;
@property (nonatomic, strong) IBOutlet UILabel *answerField;

@property (nonatomic, strong) QuestionStoreClient *questionStore;
@property (nonatomic, strong) NSOperationQueue *mainQueue;
@property (nonatomic, strong) NSOperationQueue *asyncQueue;

- (IBAction)postQuestion:(id)sender;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation QLViewController

@synthesize   postQuestionButton = _postQuestionButton,
                   questionField = _questionField,
                     answerField = _answerField,
                       mainQueue = _mainQueue;

///////////////////////////////////////////////////////////////////////////////////////////////////
//private
- (IBAction)postQuestion:(id)sender
{
  __unsafe_unretained QLViewController *weakSelf = self;
  [_asyncQueue addOperationWithBlock:^(void) {

    __unsafe_unretained QLViewController *weakSelf2 = weakSelf;
    @try {
      NSLog(@"Posting a question...");

      int a = arc4random() % 100;
      int b = arc4random() % 100;

      NSString *questionStr = [NSString stringWithFormat:@"%d + %d", a, b];
      NSString *answerStr = [NSString stringWithFormat:@"%d", a + b];

      Question *question = [[Question alloc] initWithQuestion:questionStr
                                                       answer:answerStr];

      NSLog(@"Add question: %@", question);
      NSDate *start = [NSDate date];
      [[weakSelf questionStore] addQuestion:question];
      NSDate *stop = [NSDate date];
      NSTimeInterval interval = [stop timeIntervalSinceDate:start];
      NSLog(@"Add completed in %f ms", interval * 1000);

      //NSLog(@"Get questions:");
      //NSArray * questions = [[weakSelf questionStore] getQuestions];
      //for (NSString *question in questions) {
      //  NSLog(@"%@", question);
      //}

      [[weakSelf mainQueue] addOperationWithBlock:^(void) {
        [[weakSelf2 questionField] setText:questionStr];
        [[weakSelf2 answerField] setText:answerStr];
      }];
    }
    @catch (NSException *e) {
      NSLog(@"Error: %@", e);
      [[weakSelf mainQueue] addOperationWithBlock:^(void) {
        [[weakSelf2 questionField] setText:@"ERROR!"];
        [[weakSelf2 answerField] setText:@"ERROR!"];
      }];
    }
  }];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  _mainQueue = [NSOperationQueue mainQueue];
  _asyncQueue = [[NSOperationQueue alloc] init];
  [_asyncQueue setMaxConcurrentOperationCount:4];

  NSURL *url = [NSURL URLWithString:kAPI_SERVER_BASE_URL];
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

@end
