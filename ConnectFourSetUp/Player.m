//
//  Player.m
//  Connexion
//
//  Created by Christopher Cohen on 5/5/14.
//  Copyright (c) 2014 Christopher Cohen. All rights reserved.
//

#import "Player.h"
#import "GamePiece.h"

@implementation Player

-(id)initWithColor: (UIColor *)color {
    if (self = [super init]) {
        _color = color;
    }
    
    return self;
}

-(id)initWithColor: (UIColor *)color andPieceCount: (NSInteger)count{
    
    if (self = [super init]) {
        
        _color = color;
        
        NSMutableArray *tempPieces = [NSMutableArray new];
        for (int i = 0; i < count; i++ ) {
            if ([color isEqual:[UIColor blackColor]]) {
                [tempPieces addObject:[GamePiece newPieceWithColor:[UIColor blackColor]]];
            } else
                [tempPieces addObject:[GamePiece newPieceWithColor:[UIColor redColor]]];
        }
        
        _pieces = tempPieces;
        
    }
    
    return self;
}



@end
