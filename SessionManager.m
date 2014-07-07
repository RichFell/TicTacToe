//
//  SessionManager.m
//  TicTacToe
//
//  Created by Richard Fellure on 7/7/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager

# pragma mark - Session Delegate Methods

-(id)init
{
    self = [super init];
    if (self)
    {
        self.session = nil;
        self.browser = nil;
        self.advtertiser = nil;
        self.peerID = nil;
        self.foundPeersArray = [NSMutableArray array];
        self.invitationHandlerArray = [NSMutableArray array];
    }
    return self;
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{

}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{

}

#pragma mark - NearbyBrowser Delegate Methods

-(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    if (![self.foundPeersArray containsObject:peerID.displayName] && self.peerID.displayName != peerID.displayName)
    {
        NSDictionary *dictionary = @{@"peerID": peerID};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FoundPeerNotification"object:nil userInfo:dictionary];
    }
    [self.foundPeersArray addObject:peerID.displayName];
}

-(void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    [self.foundPeersArray removeObject:peerID.displayName];
}

-(void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error
{
    NSLog(@"DidNotStartBrowsing error %@", error);
}

#pragma mark - NearbyServiceAdvertiser Delegate methods

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler
{
    [self.invitationHandlerArray addObject:invitationHandler];
    NSDictionary *dictionary = @{@"peerID": peerID};

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceivedInviteNotification" object:nil userInfo:dictionary];
}

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error
{
    NSLog(@"didNotStartAdvertisingError %@", error);
}

#pragma mark - Public Methods used to setup session

-(void)setupPeerAndSession:(NSString *)displayName
{
    self.peerID =[[MCPeerID alloc]initWithDisplayName:displayName];
    self.session = [[MCSession alloc]initWithPeer:self.peerID];
    self.session.delegate = self;
}
-(void)startBrowsingForPeers
{
    self.browser = [[MCNearbyServiceBrowser alloc]initWithPeer:self.peerID serviceType:@"TicTacToe"];
    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];
}

-(void)advertiseSelf:(BOOL)shouldAdvertise
{
    if (shouldAdvertise)
    {
        self.advtertiser = [[MCNearbyServiceAdvertiser alloc]initWithPeer:self.peerID discoveryInfo:nil serviceType:@"TicTacToe"];
        self.advtertiser.delegate = self;
        [self.advtertiser startAdvertisingPeer];
    }

    else
    {
        [self.advtertiser stopAdvertisingPeer];
        self.advtertiser = nil;
        self.advtertiser.delegate = nil;
    }
}

@end
