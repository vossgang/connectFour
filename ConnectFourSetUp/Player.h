//
//  Player.h
//  Connexion
//
//  Created by Christopher Cohen on 5/5/14.
//  Copyright (c) 2014 Christopher Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject


@property (assign,nonatomic) UIColor *color;
@property (weak, nonatomic) NSArray *pieces;
@property (nonatomic, readwrite) BOOL isCurrentTurn;

-(id)initWithColor: (UIColor *)color;
-(id)initWithColor: (UIColor *)color andPieceCount: (NSInteger)count;


@end
