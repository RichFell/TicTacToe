//
//  AppDelegate.h
//  TicTacToe
//
//  Created by Richard Fellure on 5/15/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property SessionManager *sessionManager;

@end
