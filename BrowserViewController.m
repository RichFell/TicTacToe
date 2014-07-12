//
//  BrowserViewController.m
//  TicTacToe
//
//  Created by Richard Fellure on 7/7/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *displayNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *users;
@property AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIButton *startBrowsingButton;
@property (weak, nonatomic) IBOutlet UIButton *invitingPeerButton;

@end

@implementation BrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.users = [NSMutableArray array];

}

#pragma mark - UITableView Delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    MCPeerID *peerID = [self.users objectAtIndex:indexPath.row];

    cell.textLabel.text = peerID.displayName;

    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCPeerID *peerID = [self.users objectAtIndex:indexPath.row];
    [self.appDelegate.sessionManager.browser invitePeer:peerID toSession:self.appDelegate.sessionManager.session withContext:nil timeout:30.0];
}

#pragma mark - TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setupSession];
    return YES;
}
#pragma mark - Button Action Starting Browser and Session

- (IBAction)onButtonPressedStartBrowsing:(id)sender
{
    [self setupSession];
}

#pragma mark - Handling of invitation

-(void)receivedInvite:(NSNotification *)notification
{
    MCPeerID *peerID = [[notification userInfo]objectForKey:@"peerID"];
    NSString *invitationString = [NSString stringWithFormat:@"%@ wants to play you", peerID.displayName];

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:invitationString message:nil delegate:self cancelButtonTitle:@"Decline" otherButtonTitles:@"Accept", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL accept = (buttonIndex != alertView.cancelButtonIndex);

    if (accept)
    {
        void (^invitationHandler)(BOOL, MCSession *) = [self.appDelegate.sessionManager.invitationHandlerArray objectAtIndex:0];
        invitationHandler(accept, self.appDelegate.sessionManager.session);
        ViewController *gameVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertSegue"];
        [self.navigationController pushViewController:gameVC animated:YES];
    }

}

#pragma mark - Helper Methods

-(void)setupSession
{
    [self.appDelegate.sessionManager setupPeerAndSession:self.displayNameTextField.text];
    [self.appDelegate.sessionManager startBrowsingForPeers];
    [self.appDelegate.sessionManager advertiseSelf:YES];
    [self.startBrowsingButton setEnabled:NO];
}

-(void)findPeers:(NSNotification *)notification
{
    MCPeerID *peerID = [[notification userInfo]objectForKey:@"peerID"];
    [self.users addObject:peerID];
    [self.tableView reloadData];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *gameVC = segue.destinationViewController;

    if ([segue.identifier isEqual:@"CellSegue"])
    {
        gameVC.gameTypeController = @(0);
    }
    else if ([segue.identifier isEqual:@"AlertSegue"])
    {
        gameVC.gameTypeController = @(3);
    }
}

#pragma mark - Notification Listener

-(void)notificationHandler
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(findPeers:) name:@"FoundPeerNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivedInvite:) name:@"ReceivedInviteNotification" object:nil];
}

@end
