//
//  Card.h
//  iRuzz
//
//  Created by Ryou Inoue on 8/29/14.
//  Copyright (c) 2014 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RuzzHand.h"

@interface Card : NSObject

#define DECK_SIZE 52 /* 52枚 */
#define HAND_SIZE 7 /* 手札は最大7枚 */
@property(strong, nonatomic, readwrite) NSMutableArray *deck; /* 52枚のデッキにする */

- (void) check_deck;
- (NSString *) getCardName:(NSInteger) atIndex;
- (NSInteger) judgeHandA:(NSArray *)handA HandB:(NSArray *) handB;

@end
