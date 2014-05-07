//
//  GamePiece.h
//  Connexion
//
//  Created by Christopher Cohen on 5/5/14.
//  Copyright (c) 2014 Christopher Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class Player, GameBoard, GamePieceView;

@interface GamePiece : UIView

@property (strong, nonatomic) UIColor       *color;

//bool flags
@property(nonatomic, readwrite) BOOL isHighlighted;
@property (nonatomic) enum State state;

-(void)setState:(enum State)state;
-(BOOL)isBlack;
-(BOOL)isRed;
-(void)refreshView;

+(GamePiece *)newPieceWithColor: (UIColor *)color;

@end
