//
//  ViewController.m
//  Connexion
//
//  Created by Christopher Cohen on 5/5/14.
//  Copyright (c) 2014 Christopher Cohen. All rights reserved.
//

#import "ViewController.h"
#import "GameBoard.h"
#import "GamePiece.h"
#import "Player.h"
#import "Constants.h"

@interface ViewController ()

@property (strong, nonatomic) GameBoard *gameBoard;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _gameBoard = [[GameBoard alloc] initWithEmptySlots];
    
    [self setupBoardView];
}

-(void)setupBoardView {
    
    CGPoint locationInMatrix;
    
    //setup initial cell states
    for (locationInMatrix.x = 0; locationInMatrix.x < COLUMNS; locationInMatrix.x++) {
        for (locationInMatrix.y = 0; locationInMatrix.y < ROWS; locationInMatrix.y++) {
            [self.view addSubview:[_gameBoard viewAt:locationInMatrix]];
        }
    }
    
    return;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInView:self.view];
        
        NSInteger touchStripe = CIRCLE_SIZE;
        
        if (touchPoint.x < touchStripe) {
            [_gameBoard addPieceForColumn:0];
            return;
        }
        if (touchPoint.x > touchStripe && touchPoint.x < touchStripe + CIRCLE_SIZE) {
            [_gameBoard addPieceForColumn:1];
            return;
        }
        
        touchStripe += CIRCLE_SIZE;
        
        if (touchPoint.x > touchStripe && touchPoint.x < touchStripe + CIRCLE_SIZE) {
            [_gameBoard addPieceForColumn:2];
            return;
        }
        
        touchStripe += CIRCLE_SIZE;

        if (touchPoint.x > 136.5 && touchPoint.x < 182) {
            [_gameBoard addPieceForColumn:3];
            return;
        }
        
        touchStripe += CIRCLE_SIZE;

        if (touchPoint.x > 182 && touchPoint.x < 227) {
            [_gameBoard addPieceForColumn:4];
            return;
        }
        
        touchStripe += CIRCLE_SIZE;

        if (touchPoint.x > 227 && touchPoint.x < 273) {
            [_gameBoard addPieceForColumn:5];
            return;
        }
        
        touchStripe += CIRCLE_SIZE;

        
        if (touchPoint.x > 273) {
            [_gameBoard addPieceForColumn:6];
            return;
        }
    
        
        
    }
}


@end
