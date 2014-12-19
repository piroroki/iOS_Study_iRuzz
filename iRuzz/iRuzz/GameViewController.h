//
//  GameViewController.h
//  iRuzz
//
//  Created by cat on 2014/08/09.
//  Copyright (c) 2014年 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "Card.h"

@interface GameViewController : UIViewController

@property (strong, nonatomic) Card * card;
@property (weak, nonatomic) IBOutlet UILabel *a_card1;
@property (weak, nonatomic) IBOutlet UILabel *a_card2;
@property (weak, nonatomic) IBOutlet UILabel *a_card3;
@property (weak, nonatomic) IBOutlet UILabel *a_card4;
@property (weak, nonatomic) IBOutlet UILabel *a_card5;
@property (weak, nonatomic) IBOutlet UILabel *a_card6;
@property (weak, nonatomic) IBOutlet UILabel *a_card7;
@property (weak, nonatomic) IBOutlet UILabel *y_card1;
@property (weak, nonatomic) IBOutlet UILabel *y_card2;
@property (weak, nonatomic) IBOutlet UILabel *y_card3;
@property (weak, nonatomic) IBOutlet UILabel *y_card4;
@property (weak, nonatomic) IBOutlet UILabel *y_card5;
@property (weak, nonatomic) IBOutlet UILabel *y_card6;
@property (weak, nonatomic) IBOutlet UILabel *y_card7;

- (IBAction)call:(id)sender;
- (IBAction)fold:(id)sender;

@end
