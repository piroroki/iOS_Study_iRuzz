//
//  Card.m
//  iRuzz
//
//  Created by Ryou Inoue on 8/29/14.
//  Copyright (c) 2014 cat. All rights reserved.
//

#import "Card.h"

#include <stdlib.h>

/* ソート関数 */
int int_sort( const void * a , const void * b ) {
    /* 引数はvoid*型と規定されているのでint型にcastする */
    if( *( int * )a < *( int * )b ) {
        return -1;
    }
    else
        if( *( int * )a == *( int * )b ) {
            return 0;
        }
    return 1;
}

@implementation Card

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.deck = [NSMutableArray array];
        
        int i;
        int d52[DECK_SIZE] = {0};
        
        for ( i = 0; i < DECK_SIZE; i++ ) {
            // 1から52までの一様乱数を発生させる */
            int n = arc4random_uniform(DECK_SIZE);
 //           NSLog(@"%2d回目 = %2d", i + 1, n);
            
            while (d52[n] != 0) {
                n++;
                if (n > DECK_SIZE) {
                    n = 0;
                }
            }
            [self.deck addObject:[NSNumber numberWithInt:n]];
            d52[n]=1;
        }
    }
    return self;
}

- (void) check_deck
{
    for (int i = 0; i < DECK_SIZE; i++) {
        NSNumber *n = [self.deck objectAtIndex:i];
        NSLog(@"%2@",n);
    }
}

/*
 * 0 - 12 : A♠ - K♠
 * 13 - 25 : A♥ - K♥
 * 26 - 38 : A♦ - K♦
 * 39 - 51 : A♣ - K♣
 */
- (NSString *) getCardName:(NSInteger) atIndex
{
    NSNumber *n = [self.deck objectAtIndex:atIndex];
    
    int m = n.intValue / 13;
    int num = n.intValue % 13 + 1; /* 0-12なので、+1して1-13にする */
    NSString *suit;
    switch (m) {
        case 0:
            suit = [NSString stringWithFormat:@"♠"];
            break;
        case 1:
            suit = [NSString stringWithFormat:@"♥"];
            break;
        case 2:
            suit = [NSString stringWithFormat:@"♦"];
            break;
        case 3:
            suit = [NSString stringWithFormat:@"♣"];
            break;
    }
    
    NSString *rank;
    if ((num >= 2) && (num <= 9)) {
        rank = [NSString stringWithFormat:@"%d", num];
    } else if (num == 1) {
        rank = @"A";
    } else if (num == 10) {
        rank = @"T";
    } else if (num == 11) {
        rank = @"J";
    } else if (num == 12) {
        rank = @"Q";
    } else if (num == 13) {
        rank = @"K";
    } else {
        assert("");
    }
    return [NSString stringWithFormat:@"%@\n%@", rank, suit];
}

/*
 @retval    0     HandAの勝ち
 @retval    1     HandBの勝ち
 @retval    2     引き分け
 @retval    -1    HandAとHandBの要素数が違う or ハンドが8枚以上ある
 
 handAの中身例 [@"A♥",@"2♦",@"K♠",@"J♦"]
 */
- (NSInteger) judgeHandA:(NSArray *)handA HandB:(NSArray *)handB
{
    int handAOfR[HAND_SIZE] = {0};
    int handBOfR[HAND_SIZE] = {0};
    
    // 要素数チェック
    if (([handA count] != [handB count]) && ([handA count] <= HAND_SIZE)) {
        return -1;
    }
    
    int count = [handA count];
    for (int i = 0; i < count; i++) {
        handAOfR[i] = [self getRank:[handA objectAtIndex:i]];
        handBOfR[i] = [self getRank:[handB objectAtIndex:i]];
    }
    NSLog(@"Before");
    NSLog(@"handA=%2d,%2d,%2d,%2d,%2d,%2d,%2d\n", handAOfR[0], handAOfR[1], handAOfR[2], handAOfR[3], handAOfR[4], handAOfR[5], handAOfR[6]);
    NSLog(@"handB=%2d,%2d,%2d,%2d,%2d,%2d,%2d\n", handBOfR[0], handBOfR[1], handBOfR[2], handBOfR[3], handBOfR[4], handBOfR[5], handBOfR[6]);

    /* クイックソート */
    qsort( handAOfR, [handA count], sizeof(int), int_sort );
    qsort( handBOfR, [handB count], sizeof(int), int_sort );
    
    handA = [handA sortedArrayUsingSelector:@selector(compare:)];
    handB = [handB sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"After");
    NSLog(@"handA=%2d,%2d,%2d,%2d,%2d,%2d,%2d\n", handAOfR[0], handAOfR[1], handAOfR[2], handAOfR[3], handAOfR[4], handAOfR[5], handAOfR[6]);
    NSLog(@"handB=%2d,%2d,%2d,%2d,%2d,%2d,%2d\n", handBOfR[0], handBOfR[1], handBOfR[2], handBOfR[3], handBOfR[4], handBOfR[5], handBOfR[6]);
    
    RuzzHand *rh = [[RuzzHand alloc] init];
    return [rh judgeHandA:handAOfR HandB:handBOfR];
}

/*
 @retval    1　　　Aの時
 @retval    2〜9   2〜9
 @retval    10    T
 @retval    11    J
 @retval    12    Q
 @retval    13    K
 @retval    -1    その他

 @param    @"A♥"を想定
 */

-(int) getRank:(NSString *)card
{
    NSString *str = [card substringToIndex:1];
    
    if ([str isEqualToString:@"A"]) {
        return 1;
    } else if ([str isEqualToString:@"T"]) {
        return 10;
    } else if ([str isEqualToString:@"J"]) {
        return 11;
    } else if ([str isEqualToString:@"Q"]) {
        return 12;
    } else if ([str isEqualToString:@"K"]) {
        return 13;
    } else if (   [str isEqualToString:@"2"] || [str isEqualToString:@"3"]
               || [str isEqualToString:@"4"] || [str isEqualToString:@"5"]
               || [str isEqualToString:@"6"] || [str isEqualToString:@"7"]
               || [str isEqualToString:@"8"] || [str isEqualToString:@"9"]) {
         
        return [str intValue];
    } else {
        return -1;
    }
}

@end
