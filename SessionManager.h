//
//  SessionManager.h
//  TicTacToe
//
//  Created by Richard Fellure on 7/7/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface SessionManager : NSObject<MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate>

@property MCPeerID *peerID;
@property MCNearbyServiceAdvertiser *advtertiser;
@property MCNearbyServiceBrowser *browser;
@property MCSession *session;
@property NSMutableArray *foundPeersArray;
@property NSMutableArray *invitationHandlerArray;

-(void)advertiseSelf:(BOOL)shouldAdvertise;
-(void)setupPeerAndSession:(NSString *)displayName;
-(void)startBrowsingForPeers;


@end
