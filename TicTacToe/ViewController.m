//
//  ViewController.m
//  TicTacToe
//
//  Created by Richard Fellure on 5/15/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *myLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *myLabelTwo;
@property (strong, nonatomic) IBOutlet UILabel *myLabelThree;
@property (strong, nonatomic) IBOutlet UILabel *myLabelFour;
@property (strong, nonatomic) IBOutlet UILabel *myLabelFive;
@property (strong, nonatomic) IBOutlet UILabel *myLabelSix;
@property (strong, nonatomic) IBOutlet UILabel *myLabelSeven;
@property (strong, nonatomic) IBOutlet UILabel *myLabelEight;
@property (strong, nonatomic) IBOutlet UILabel *myLabelNine;
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //setting the whichPLayerLabel to X because my method follows its text to set the X and O for the labels
    self.whichPlayerLabel.text = @"X";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
-(UILabel *)findLabelUsingPoint: (CGPoint) point
{
    //helper method to find if the point is within the frame of the label, and if it is to return the label so we can do something to it

    if (CGRectContainsPoint(self.myLabelOne.frame, point))
    {
        return self.myLabelOne;
    }
    else if (CGRectContainsPoint(self.myLabelTwo.frame, point))
    {
        return self.myLabelTwo;
    }
    else if (CGRectContainsPoint(self.myLabelThree.frame, point))
    {
        return self.myLabelThree;
    }
    else if (CGRectContainsPoint(self.myLabelFour.frame, point))
    {
        return self.myLabelFour;
    }
    else if (CGRectContainsPoint(self.myLabelFive.frame, point))
    {
        return self.myLabelFive;
    }
    else if (CGRectContainsPoint(self.myLabelSix.frame, point))
    {
        return self.myLabelSix;
    }
    else if (CGRectContainsPoint(self.myLabelSeven.frame, point))
    {
        return self.myLabelSeven;
    }
    else if (CGRectContainsPoint(self.myLabelEight.frame, point))
    {
        return self.myLabelEight;
    }
    else if (CGRectContainsPoint(self.myLabelNine.frame, point))
    {
        return self.myLabelNine;
    }
    else{
        return nil;
    }
}
-(UILabel *)switchPlayerLabel
//helper method to switch the whichPlayerLabel from X to O and so on
{
    if([self.whichPlayerLabel.text isEqual:@"X"])
    {
        self.whichPlayerLabel.text = @"O";
    }
    else if ([self.whichPlayerLabel.text isEqual:@"O"])
    {
        self.whichPlayerLabel.text = @"X";
    }
    return nil;
}


-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    //setting the point that we want to check as the the point where we are tapping
    CGPoint point;
    point = [tapGestureRecognizer locationInView:self.view];
    UILabel *label = [self findLabelUsingPoint:point];//calls on the helper method to ineract with whatever label we are touching

    //this first if statement stops us from being able to change a label after its been selected
    if ([label.text isEqual:@"X"])
    {
        label.text = @"X";
    }
    else if ([label.text isEqual:@"O"])
    {
        label.text = @"O";
    }
    else
    {
        //now I am deciding whether the next title tapped will be either an X or O and to set the color

        if ([self.whichPlayerLabel.text  isEqual: @"X"])
        {
            label.text = @"X";
            label.textColor = [UIColor blueColor];
        }
        else
        {
            label.text = @"O";
            label.textColor = [UIColor redColor];
        }
        [self switchPlayerLabel];//helper method to switch the whichPlayerLabel.text
//        [self whoWon];
    }
    [self whoWon];//calling my helper method to show alert when X is the winner
    [self oIsMyWinner];//calling my helper method to show alert when O is the winner

}
-(void) whoWon
{
    //helper method to decide if X was the winner
    if ([self.myLabelOne.text  isEqual:@"X"] &&  [self.myLabelTwo.text  isEqual:@"X"] && [self.myLabelThree.text  isEqual:@"X"])
    {
        [self xWins];
    }
    else if ([self.myLabelFour.text  isEqual:@"X"] &&  [self.myLabelFive.text  isEqual:@"X"] && [self.myLabelSix.text  isEqual:@"X"])
    {
        [self xWins];
    }
    else if ([self.myLabelSeven.text  isEqual:@"X"] &&  [self.myLabelEight.text  isEqual:@"X"] && [self.myLabelNine.text  isEqual:@"X"])
    {
        [self xWins];
    }
    else if ([self.myLabelOne.text  isEqual:@"X"] &&  [self.myLabelFour.text  isEqual:@"X"] && [self.myLabelSeven.text  isEqual:@"X"])
    {
        [self xWins];
    }
    else if ([self.myLabelTwo.text  isEqual:@"X"] &&  [self.myLabelFive.text  isEqual:@"X"] && [self.myLabelEight.text  isEqual:@"X"])
    {
        [self xWins];
    }
    else if ([self.myLabelThree.text  isEqual:@"X"] &&  [self.myLabelSix.text  isEqual:@"X"] && [self.myLabelNine.text  isEqual:@"X"])
    {
        [self xWins];
    }
    else if ([self.myLabelOne.text  isEqual:@"X"] &&  [self.myLabelFive.text  isEqual:@"X"] && [self.myLabelNine.text  isEqual:@"X"])
    {
        [self xWins];
    }
    else if ([self.myLabelThree.text  isEqual:@"X"] &&  [self.myLabelFive.text  isEqual:@"X"] && [self.myLabelSeven.text  isEqual:@"X"])
    {
        [self xWins];
    }
}
-(void) xWins
{
    //helper method to call my alert view for X winning
    UIAlertView *winningAlert = [[UIAlertView alloc] init];
    winningAlert.title = @"X is the winner";
    [winningAlert addButtonWithTitle:@"Play Again?"];
    winningAlert.delegate = self;
    [winningAlert show];
}
-(void) oIsMyWinner
{
    //helper method to evaluate whether O was the winner
    if ([self.myLabelOne.text  isEqual:@"O"] &&  [self.myLabelTwo.text  isEqual:@"O"] && [self.myLabelThree.text  isEqual:@"O"])
    {
        [self oWins];
    }
    else if ([self.myLabelFour.text  isEqual:@"O"] &&  [self.myLabelFive.text  isEqual:@"O"] && [self.myLabelSix.text  isEqual:@"O"])
    {
        [self oWins];
    }
    else if ([self.myLabelSeven.text  isEqual:@"O"] &&  [self.myLabelEight.text  isEqual:@"O"] && [self.myLabelNine.text  isEqual:@"O"])
    {
        [self oWins];
    }
    else if ([self.myLabelOne.text  isEqual:@"O"] &&  [self.myLabelFour.text  isEqual:@"O"] && [self.myLabelSeven.text  isEqual:@"O"])
    {
        [self oWins];
    }
    else if ([self.myLabelTwo.text  isEqual:@"O"] &&  [self.myLabelFive.text  isEqual:@"O"] && [self.myLabelEight.text  isEqual:@"O"])
    {
        [self oWins];
    }
    else if ([self.myLabelThree.text  isEqual:@"O"] &&  [self.myLabelSix.text  isEqual:@"O"] && [self.myLabelNine.text  isEqual:@"O"])
    {
        [self oWins];
    }
    else if ([self.myLabelOne.text  isEqual:@"O"] &&  [self.myLabelFive.text  isEqual:@"O"] && [self.myLabelNine.text  isEqual:@"O"])
    {
        [self oWins];
    }
    else if ([self.myLabelThree.text  isEqual:@"O"] &&  [self.myLabelFive.text  isEqual:@"O"] && [self.myLabelSeven.text  isEqual:@"O"])
    {
        [self oWins];
    }
}
-(void) oWins
{
    //helper method to call my alert to show that O is the winner
    UIAlertView *winningAlert = [[UIAlertView alloc] init];
    winningAlert.title = @"O is the winner";
    [winningAlert addButtonWithTitle:@"Play Again?"];
    winningAlert.delegate = self;
    [winningAlert show];
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //method to reset game after hitting the button on the alert
    self.myLabelOne.text = @"";
    self.myLabelTwo.text = @"";
    self.myLabelThree.text = @"";
    self.myLabelFour.text = @"";
    self.myLabelFive.text = @"";
    self.myLabelSix.text = @"";
    self.myLabelSeven.text = @"";
    self.myLabelEight.text = @"";
    self.myLabelNine.text = @"";
    self.whichPlayerLabel.text = @"X";
    NSLog(@"what?");
}
//-(IBAction)onDrag:(UIPanGestureRecognizer *) panGestureRecognizer
//{
//    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
//        <#statements#>
//    }
//}




@end
