//
//  GameBoard.m
//  Connexion
//
//  Created by Christopher Cohen on 5/5/14.
//  Copyright (c) 2014 Christopher Cohen. All rights reserved.
//

#import "GameBoard.h"
#import "Player.h"
#import "GamePiece.h"
#import "Constants.h"

@interface GameBoard () {
    GamePiece *matrix[COLUMNS][ROWS];
}

@end

@implementation GameBoard

-(id)initWithEmptySlots
{
    if (self = [super init]) {
        
        _turn = redTurn;
        
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        //initial setup
        CGFloat xCoordinate = 0.f;
        CGFloat yCoordinate = screenHeight - CIRCLE_SIZE;
        CGPoint locationInMatrix;
        
        //setup initial cell states
        for (locationInMatrix.x = 0; locationInMatrix.x < COLUMNS; locationInMatrix.x++) {
            for (locationInMatrix.y = 0; locationInMatrix.y < ROWS; locationInMatrix.y++) {
                
                //allocate and initialize
                matrix[(int)locationInMatrix.x][(int)locationInMatrix.y] = [GamePiece new];

                //set piece state
                [self setPieceState:empty forLocation:locationInMatrix];

                //assign a frame to each piece
                [self setFrame:CGRectMake(xCoordinate, yCoordinate, CIRCLE_SIZE, CIRCLE_SIZE) forPieceAt:locationInMatrix];
                [self setState:empty forPieceAt:locationInMatrix];
                
                yCoordinate = yCoordinate - CIRCLE_SIZE;
            } //end inner 'for loop'
            xCoordinate = xCoordinate + CIRCLE_SIZE;
            yCoordinate = screenHeight - CIRCLE_SIZE;
        } //end outer 'for loop'
        
    }
    return self;
}

-(enum Turn)nextTurn
{
    if (_turn == blackTurn) {
        _turn = redTurn;
        return redTurn;
    } else {
        _turn = blackTurn;
        return blackTurn;
    }
}

-(BOOL)matrixIsNil
{
    CGPoint slot;
    for (slot.x = 0; slot.x < ROWS; slot.x++) {
        for (slot.y = 0; slot.y < COLUMNS; slot.y++) {
            if (matrix[(int)slot.x][(int)slot.y] != nil) return NO;
        }
    }
    return  YES;
}

#pragma state access and interactions

-(enum State)getStateForPieceAt: (CGPoint)location
{
    return matrix[(int)location.x][(int)location.y].state;
}

-(void)setState: (enum State)state forPieceAt: (CGPoint)location
{
    matrix[(int)location.x][(int)location.y].state = state;
    
    return;
}

-(void)setFrame:(CGRect)frame forPieceAt:(CGPoint)location
{
    matrix[(int)location.x][(int)location.y].frame = frame;
}

-(CGPoint)addPieceForColumn:(NSInteger)column
{
    CGPoint thispoint;
    if (_turn == redTurn) {
      thispoint =  [self addPieceWithState:redPiece forColumn:column];
    } else {
      thispoint =  [self addPieceWithState:blackPiece forColumn:column];
    }
    [self examineGameBoardForWinningConditionFromPoint:_lastPieceAddedToBoard];
    [self nextTurn];

    return thispoint;
}

-(CGPoint)addPieceWithState:(enum State)state forColumn:(NSInteger)column
{
    CGPoint thispoint;
    for (int i = 0; i < ROWS; i++) {
        if (matrix[column][i].state == empty) {
            matrix[column][i].state = state;
            _lastPieceAddedToBoard = CGPointMake(column, i);
            thispoint =  matrix[column][i].center;
            break;
        }
    }
    
    return thispoint;
}

-(void)setPieceState:(enum State)state forLocation:(CGPoint)location
{
    matrix[(int)location.x][(int)location.y].state = state;
    return;
}

-(GamePiece *)viewAt:(CGPoint)location
{
    return matrix[(int)location.x][(int)location.y];
}

-(BOOL)examineGameBoardForWinningConditionFromPoint:(CGPoint)point
{
    _lastPieceAddedToBoard = point;
    if ([self examineRowForWinningCondition] || [self examineColumnForWinningCondition] || [self examineDiagonalForWinningCondition]) {
        NSLog(@"WIN!");
        return YES;
    }
    
    return NO;
}

-(BOOL)examineRowForWinningCondition
{
    NSInteger row               = _lastPieceAddedToBoard.y;
    NSInteger conjoinedPieces   = 1;
    CGPoint   startOfConnectedPieces;
    
    for (int column = 0; column < COLUMNS-1; column++) {
        if (matrix[column][row].state != empty) {
            if (matrix[column][row].state == matrix[column+1][row].state) {
                if (conjoinedPieces == 1) {
                    startOfConnectedPieces = CGPointMake(column, row);
                }
                conjoinedPieces++;
                if (conjoinedPieces == NUMBER_NEEDED_FOR_DELETION){
                    [self deleteRowPiecesStartingAtLocation:startOfConnectedPieces];
                    return YES;
                }
            } else {
                conjoinedPieces = 1;
            }
        } else {
            conjoinedPieces = 1;
        }
    }
    
    return NO;
}

-(void)deleteRowPiecesStartingAtLocation:(CGPoint)location
{
    for (int i = 0 ; i < NUMBER_NEEDED_FOR_DELETION; i++) {
        [self setState:empty forPieceAt:CGPointMake(location.x + i, location.y)];
        //remove
    }
    [self movePiecesDown];
}

-(BOOL)examineColumnForWinningCondition {
    NSInteger column            = _lastPieceAddedToBoard.x;
    NSInteger conjoinedPieces   = 1;
    CGPoint   startOfConnectedPieces;
    
    for (int row = 0; row < ROWS-1; row++) {
        if (matrix[column][row].state != empty) {
            if (matrix[column][row].state == matrix[column][row+1].state) {
                if (conjoinedPieces == 1) {
                    startOfConnectedPieces = CGPointMake(column, row);
                }
                conjoinedPieces++;
                if (conjoinedPieces == NUMBER_NEEDED_FOR_DELETION){
                    [self deleteColumnPiecesStartingAtLocation:startOfConnectedPieces];
                    //delete pieces and move rest down
                    return YES;
                }
            } else {
                conjoinedPieces = 1;
            }
        } else {
            conjoinedPieces = 1;
        }
    }
    return NO;
}

-(void)deleteColumnPiecesStartingAtLocation:(CGPoint)location
{
    for (int i = 0 ; i < NUMBER_NEEDED_FOR_DELETION; i++) {
        [self setState:empty forPieceAt:CGPointMake(location.x, location.y + i)];
        //remove
    }
    [self movePiecesDown];
}

-(BOOL)examineDiagonalForWinningCondition
{
    return ([self examineLeftDiagonalForWinningCondition] + [self examineRightDiagonalForWinningCondition]);
}


-(BOOL)examineLeftDiagonalForWinningCondition
{
    NSInteger X_location = _lastPieceAddedToBoard.x;
    NSInteger Y_location = _lastPieceAddedToBoard.y;
    CGPoint   startOfConnectedPieces;

    //get the bottom left diagonal location
    while ((X_location > 0) && (Y_location > 0)) {
        X_location--;
        Y_location--;
    }
    
    NSInteger conjoinedPieces = 1;
    
    for (int col = X_location, row = Y_location; col < COLUMNS-1 && row < ROWS-1; col++, row++) {
        if (matrix[col][row].state != empty) {
            if (matrix[col][row].state == matrix[col+1][row+1].state) {
                if (conjoinedPieces == 1) {
                    startOfConnectedPieces = CGPointMake(col, row);
                }
                conjoinedPieces++;
                if (conjoinedPieces == NUMBER_NEEDED_FOR_DELETION){
                    [self deleteLeftDiagonalPiecesStartingAtLocation:startOfConnectedPieces];
                    return YES;
                }
            } else {
                conjoinedPieces = 1;
            }
        } else {
            conjoinedPieces = 1;
        }//end of IF_IS_Empty
    }//end of FOR
    
    return NO;
}


-(void)deleteLeftDiagonalPiecesStartingAtLocation:(CGPoint)location
{
    for (int i = 0 ; i < NUMBER_NEEDED_FOR_DELETION; i++) {
        [self setState:empty forPieceAt:CGPointMake(location.x + i, location.y + i)];
        //remove
    }
    [self movePiecesDown];
}

-(BOOL)examineRightDiagonalForWinningCondition
{
    NSInteger X_location = _lastPieceAddedToBoard.x;
    NSInteger Y_location = _lastPieceAddedToBoard.y;
    CGPoint   startOfConnectedPieces;

    //get the bottom left diagonal location
    while ((X_location < COLUMNS - 1) && (Y_location > 0)) {
        X_location++;
        Y_location--;
    }
    
    NSInteger conjoinedPieces = 1;
    
    for (int col = X_location, row = Y_location; col > 1 && row < ROWS-1; col--, row++) {
        if (matrix[col][row].state != empty) {
            if (matrix[col][row].state == matrix[col-1][row+1].state) {
                if (conjoinedPieces == 1) {
                    startOfConnectedPieces = CGPointMake(col, row);
                }
                conjoinedPieces++;
                if (conjoinedPieces == NUMBER_NEEDED_FOR_DELETION){
                    [self deleteRightDiagonalPiecesStartingAtLocation:startOfConnectedPieces];
                    return YES;
                }
            } else {
                conjoinedPieces = 1;
            }
        } else {
            conjoinedPieces = 1;
        }//end of IF_IS_Empty
    }//end of FOR
    
    return NO;
}

-(void)deleteRightDiagonalPiecesStartingAtLocation:(CGPoint)location
{
    for (int i = 0 ; i < NUMBER_NEEDED_FOR_DELETION; i++) {
        [self setState:empty forPieceAt:CGPointMake(location.x - i, location.y + i)];
        //remove
    }
    [self movePiecesDown];
}


-(void)movePiecesDown
{
    for (int row = 1 ; row < ROWS; row++) {
        for (int col = 0; col < COLUMNS; col++) {
            if ([matrix[col][row] state] != empty) {
                if ([matrix[col][row-1] state] == empty) {
                    //swap the one above with the one below
                    [self setState:[matrix[col][row] state] forPieceAt:CGPointMake(col, row-1)];
                    [self setState:empty forPieceAt:CGPointMake(col, row)];
                }
            }
        }
    }
    [self checkForNewWinnigCondition];
}

-(void)checkForNewWinnigCondition
{
    for (int col = 0; col < COLUMNS; col++) {
        for (int row = 0; row < ROWS; row++) {
            if (matrix[col][row].state != empty) {
                [self examineGameBoardForWinningConditionFromPoint:CGPointMake(col, row)];
            }
        }
    }
    
}
@end
