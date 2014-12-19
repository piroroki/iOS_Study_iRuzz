//
//  GameViewController.m
//  iRuzz
//
//  Created by cat on 2014/08/09.
//  Copyright (c) 2014年 cat. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
{
 

}
@end


@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // labelのカドを丸くする
    [self setLabel:self.a_card1];
    [self setLabel:self.a_card2];
    [self setLabel:self.a_card3];
    [self setLabel:self.a_card4];
    [self setLabel:self.a_card5];
    [self setLabel:self.a_card6];
    [self setLabel:self.a_card7];
    [self setLabel:self.y_card1];
    [self setLabel:self.y_card2];
    [self setLabel:self.y_card3];
    [self setLabel:self.y_card4];
    [self setLabel:self.y_card5];
    [self setLabel:self.y_card6];
    [self setLabel:self.y_card7];
    
    if (self.card == nil) {
        self.card = [[Card alloc] init];
    
        //debug
//        [self.card check_deck];
        
        self.a_card1.text = @"";
        self.a_card2.text = @"";
        self.a_card3.text = [self.card getCardName:4];
        self.a_card4.text = [self.card getCardName:6];
        self.a_card5.text = [self.card getCardName:8];
        self.a_card6.text = [self.card getCardName:10];
        self.a_card7.text = @"";

        self.y_card1.text = [self.card getCardName:1];
        self.y_card2.text = [self.card getCardName:3];
        self.y_card3.text = [self.card getCardName:5];
        self.y_card4.text = [self.card getCardName:7];
        self.y_card5.text = [self.card getCardName:9];
        self.y_card6.text = [self.card getCardName:11];
        self.y_card7.text = [self.card getCardName:13];
        
        self.a_card4.hidden = YES;
        self.a_card5.hidden = YES;
        self.a_card6.hidden = YES;
        self.a_card7.hidden = YES;
        self.y_card4.hidden = YES;
        self.y_card5.hidden = YES;
        self.y_card6.hidden = YES;
        self.y_card7.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)call:(id)sender
{
    if (self.y_card4.hidden == YES) {
        self.y_card4.hidden = NO;
        self.a_card4.hidden = NO;
        return;
    };
    if (self.y_card5.hidden == YES) {
        self.y_card5.hidden = NO;
        self.a_card5.hidden = NO;
        return;
    };
    if (self.y_card6.hidden == YES) {
        self.y_card6.hidden = NO;
        self.a_card6.hidden = NO;
        return;
    };
    if (self.y_card7.hidden == YES) {
        self.y_card7.hidden = NO;
        self.a_card7.hidden = NO;
        return;
    };
    if (self.y_card7.hidden == NO) { /* showdown */
        self.a_card1.text = [self.card getCardName:0];
        self.a_card2.text = [self.card getCardName:2];
        self.a_card7.text = [self.card getCardName:12];
        self.a_card1.backgroundColor = [UIColor whiteColor];
        self.a_card2.backgroundColor = [UIColor whiteColor];
        self.a_card7.backgroundColor = [UIColor whiteColor];
        NSArray *handA = [NSArray arrayWithObjects:self.a_card1.text, self.a_card2.text, self.a_card3.text, self.a_card4.text, self.a_card5.text, self.a_card6.text, self.a_card7.text, nil];
        NSArray *handY = [NSArray arrayWithObjects:self.y_card1.text, self.y_card2.text, self.y_card3.text, self.y_card4.text, self.y_card5.text, self.y_card6.text, self.y_card7.text, nil];
        int ret = [self.card judgeHandA:handA HandB:handY];
        
        // for debug
        NSString *alertMessage;
        if (ret == 0) {
            alertMessage = @"You Lose!";
        } else if (ret == 1) {
            alertMessage = @"You Win!";
        } else {
            alertMessage = @"Draw";
        }
        UIAlertView *alert =
        [[UIAlertView alloc]
         initWithTitle:@"Result"
         message:alertMessage
         delegate:nil
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil
         ];
        [alert show];
        
        return;
    };
}

- (IBAction)fold:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil]; /* Close */
}

- (void) setLabel:(UILabel *)label
{
    [[label layer] setCornerRadius:10.0];
    [label setClipsToBounds:YES];
    [[label layer] setBorderColor:[[UIColor blueColor] CGColor]];
    [[label layer] setBorderWidth:1.0];
}

@end
