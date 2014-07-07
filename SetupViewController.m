//
//  SetupViewController.m
//  TicTacToe
//
//  Created by Richard Fellure on 7/7/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "SetupViewController.h"
#import "BrowserViewController.h"
#import "ViewController.h"

@interface SetupViewController ()
@property (weak, nonatomic) IBOutlet UIButton *playVsFriendButton;

@property (weak, nonatomic) IBOutlet UIButton *findOpponentButton;
@property (weak, nonatomic) IBOutlet UIButton *playVsCPUButton;
@end

@implementation SetupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.findOpponentButton setHidden:YES];
    self.findOpponentButton.tag = 0;
    self.playVsCPUButton.tag = 1;
    self.playVsCPUButton.tag = 2;
}

- (IBAction)onButtonPressedPlayVSFriend:(id)sender
{
    [self.findOpponentButton setHidden:NO];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        BrowserViewController *browserVC = segue.destinationViewController;
        browserVC.gameTypeController = @(sender.tag);

    }
    else if (sender.tag == 1)
    {
        ViewController *gameVC = segue.destinationViewController;
    }
    else
    {
        ViewController *gameVC = segue.destinationViewController;
    }
}


@end
