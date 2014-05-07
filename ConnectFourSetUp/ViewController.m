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
@property (strong, nonatomic) UIView *shape;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _gameBoard = [[GameBoard alloc] initWithEmptySlots];
    _shape = [UIView new];
    _shape.frame = CGRectMake(0, 0, CIRCLE_SIZE, CIRCLE_SIZE);
    _shape.backgroundColor = [UIColor redColor];
    
    [self setupBoardView];
    [self.view addSubview:_shape];
    _shape.layer.cornerRadius = _shape.frame.size.width / 2;
    [self changeShapeColorToCurrent];

}

-(void)setupBoardView
{
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
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        CGPoint touchPoint = [touch locationInView:self.view];
        
        if ([self distanceBetween:touchPoint and:_shape.center] < (_shape.frame.size.width * 2)) {
            NSLog(@"%f", [self distanceBetween:touchPoint and:_shape.center]);
            
            [UIView animateWithDuration:.25 animations:^{
                _shape.transform = CGAffineTransformMakeScale(.9, .9);
                _shape.center   = touchPoint;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.25 animations:^{
                    _shape.transform = CGAffineTransformMakeScale(1, 1);
                }];
            }];
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInView:self.view];
        if ([self distanceBetween:touchPoint and:_shape.center] < (_shape.frame.size.width * 2)) {
            _shape.center = touchPoint;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInView:self.view];
            
        NSInteger locationInMatrix = touchPoint.x / CIRCLE_SIZE;
        
        CGPoint destinationPoint = [_gameBoard addPieceForColumn:(int)locationInMatrix];

         //animate snap to column
         [UIView animateWithDuration:.25 animations:^{
             
             _shape.center = CGPointMake(destinationPoint.x, _shape.center.y);
             
             //animate down to destination point
             [UIView animateWithDuration:.75 animations:^{
                 _shape.center = destinationPoint;
             } completion:^(BOOL finished) {
                 _shape.center = CGPointMake(self.view.center.x, 50);
                 [self changeShapeColorToCurrent];
                 [_gameBoard revealStateForNewPeice];
             }];
             
         }];
        }
     
    
    
}

- (float)distanceBetween: (CGPoint) p1 and: (CGPoint)p2
{
    return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2));
}

- (void)changeShapeColorToCurrent
{
    switch (_gameBoard.turn) {
        case blackTurn:
            _shape.backgroundColor = [UIColor blackColor];
            break;
        case redTurn:
            _shape.backgroundColor = [UIColor redColor];
            break;
        default:
            _shape.backgroundColor = [UIColor clearColor];
            break;
    }
}


@end
