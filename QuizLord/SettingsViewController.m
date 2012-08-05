//
//  SettingsViewController.m
//  QuizLord
//
//  Created by syyang on 8/4/12.
//  Copyright (c) 2012 quizlord. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

  @property (nonatomic, weak) IBOutlet UIButton *dismissButton;

- (IBAction)dismiss:(id)sender;

@end

@implementation SettingsViewController

@synthesize dismissButton = _dismissButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
  [self setDismissButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dismiss:(id)sender
{
  NSLog(@"Dismiss settings");
  [self dismissModalViewControllerAnimated:YES];
}

@end
