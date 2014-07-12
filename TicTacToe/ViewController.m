//
//  ViewController.m
//  TicTacToe
//
//  Created by Richard Fellure on 5/15/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "ViewController.h"
#import "CustomLabel.h"

@interface ViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelOne;
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelTwo;
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelThree;
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelFour;
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelFive;
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelSix;
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelSeven;
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelEight;
@property (strong, nonatomic) IBOutlet CustomLabel *myLabelNine;
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property CGAffineTransform whichPlayerLabelTransform;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property BOOL switchPlayer;
@property NSMutableArray *labelsArray;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //setting the whichPLayerLabel to X because my method follows its text to set the X and O for the labels
    self.whichPlayerLabel.text = @"X";
    self.whichPlayerLabelTransform = self.whichPlayerLabel.transform;
    [self createTimer];
    self.switchPlayer = YES;
    self.labelsArray = [NSMutableArray array];

}

-(CustomLabel *)findLabelUsingPoint: (CGPoint) point
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
    if (self.switchPlayer == YES)
    {
        self.whichPlayerLabel.text = @"X";
    }

    else
    {
        self.whichPlayerLabel.text = @"O";
    }

    return nil;
}


-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    //setting the point that we want to check as the the point where we are tapping
    CGPoint point;
    point = [tapGestureRecognizer locationInView:self.view];
    CustomLabel *label = [self findLabelUsingPoint:point];//calls on the helper method to interact with whatever label we are touching

    //this first if statement stops us from being able to change a label after its been selected
    if (label.canTap == YES)
    {
        if (self.switchPlayer == YES)
        {
            label.text = @"X";
            label.textColor = [UIColor blueColor];

        }
        else
        {
            label.text = @"O";
            label.textColor = [UIColor redColor];
        }
        [self.labelsArray addObject:label];

        label.canTap = NO;
    }
    [self isThereAWinner]; //helper method to see if there is a winner or not
    [self whoWon];//calling my helper method to show alert when X is the winner
}
-(IBAction)onLabelDrag: (UIPanGestureRecognizer *) panGestureRecognizer
{
    CGPoint point;
    point = [panGestureRecognizer locationInView: self.view];
    self.whichPlayerLabel.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    point.x += self.whichPlayerLabel.center.x;
    point.y += self.whichPlayerLabel.center.y;


        if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
        {
            UILabel *label = [self findLabelUsingPoint:point];
            NSLog(@"%@", label);

            self.whichPlayerLabel.transform = self.whichPlayerLabelTransform;
            if (CGRectContainsPoint(label.frame, point))
            {
                NSLog(@"found our label");

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
                    if ([self.whichPlayerLabel.text isEqual:@"X"])
                    {
                        label.text = @"X";
                    }
                    else
                    {
                        label.text = @"O";
                    }
                    [self switchPlayerLabel];
                }
            }
        }
}

-(void) whoWon
{
    //helper method to decide if X was the winner

    if (self.myLabelOne.text == self.myLabelTwo.text  && self.myLabelTwo.text == self.myLabelThree.text)
    {
        [self showWinner:self.myLabelThree.text];
    }
    else if (self.myLabelFour.text == self.myLabelFive.text && self.myLabelSix.text == self.myLabelFive.text)
    {
        [self showWinner:self.myLabelFive.text];
    }
    else if (self.myLabelSeven.text == self.myLabelEight.text && self.myLabelEight.text == self.myLabelNine.text)
    {
        [self showWinner:self.myLabelNine.text];
    }
    else if (self.myLabelOne.text == self.myLabelFour.text && self.myLabelFour.text == self.myLabelSeven.text)
    {
        [self showWinner:self.myLabelOne.text];
    }
    else if (self.myLabelTwo.text == self.myLabelFive.text && self.myLabelFive.text == self.myLabelEight.text)
    {
        [self showWinner:self.myLabelEight.text];
    }
    else if (self.myLabelThree.text == self.myLabelSix.text && self.myLabelSix.text == self.myLabelNine.text)
    {
        [self showWinner:self.myLabelNine.text];
    }
    else if (self.myLabelOne.text == self.myLabelFive.text && self.myLabelFive.text == self.myLabelNine.text)
    {
        [self showWinner:self.myLabelNine.text];
    }
    else if (self.myLabelThree.text == self.myLabelFive.text && self.myLabelFive.text == self.myLabelSeven.text)
    {
        [self showWinner:self.myLabelSeven.text];
    }
}

-(void)showWinner:(NSString *)string
{
    NSString *winnerString = [NSString stringWithFormat:@"%@ is the winner", string];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:winnerString message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)isThereAWinner
{
    if (self.labelsArray.count == 9)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Winner Restart?" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //resets the game after the alertView is shown
    for (CustomLabel *label in self.labelsArray)
    {
        label.text = @"";
        label.canTap = YES;
    }
}
-(void) createTimer
{
//    NSTimer *timer = [NSTimer timerWithTimeInterval:15.0 target:self selector:@selector(atSelector) userInfo:NO repeats:YES];
    

}
-(void) showAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No winner game over!" message:nil delegate:self cancelButtonTitle:@"Restart Game" otherButtonTitles:nil, nil];
    [alertView show];
}



@end
