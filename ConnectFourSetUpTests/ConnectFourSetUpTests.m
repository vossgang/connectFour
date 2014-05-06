//
//  ConnectFourSetUpTests.m
//  ConnectFourSetUpTests
//
//  Created by Matthew Voss on 5/6/14.
//  Copyright (c) 2014 Matthew Voss. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GamePiece.h"
#import "GameBoard.h"
#import "Player.h"

@interface ConnectFourSetUpTests : XCTestCase

@property (nonatomic, strong) GameBoard *gameBoard;

@end

@implementation ConnectFourSetUpTests

- (void)setUp
{
    [super setUp];
    
    _gameBoard = [[GameBoard alloc] initWithEmptySlots];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    _gameBoard = nil;
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void)testColorOfNewPiece {
    GamePiece *redPiece, *blackPiece;
    
    redPiece = [GamePiece newPieceWithColor:[UIColor redColor]];
    blackPiece = [GamePiece newPieceWithColor:[UIColor blackColor]];
    
    XCTAssertEqual(blackPiece.color, [UIColor blackColor], @"black color");
    XCTAssertEqual(redPiece.color, [UIColor redColor], @"red color");
    
    
}

//-(void)testNewGamePlayerCount {
//    XCTAssertTrue(_gameBoard.players.count == 2, @"a new gamboard should have 2 players");
//
//}
//
//-(void)testNewGamePlayerColors {
//    Player *p1 = _gameBoard.players[0];
//    Player *p2 = _gameBoard.players[1];
//
//    XCTAssertNotEqual(p1.color, p2.color, @"colors should be different");
//    XCTAssertTrue([p1.color isEqual:[UIColor redColor]], @"player 1 should be red");
//    XCTAssertTrue([p2.color isEqual:[UIColor blackColor]], @"player 2 should be black");
//
//
//}

//-(void)testNewGamePlayersExist {
//
//    for (NSInteger i = 0; i < _gameBoard.players.count; i++) {
//        XCTAssertNotNil(_gameBoard.players[i], @"Player %d should exist", i);
//    }
//
//}

//-(void)testGameBoardForPieces {
//
//    for (GamePiece *piece in _gameBoard.pieces) {
//        XCTAssertEqualObjects(piece.gameBoard, _gameBoard, @"pieces should refference thier gameboard");
//    }
//
//}

//-(void)testPieceHasPlayerColor {
//    for (Player *player in _gameBoard.players) {
//        for (GamePiece *piece in player.pieces) {
//            XCTAssertEqual(piece.color, player.color, @"the pieces should be the same color as the player color");
//        }
//    }
//}

//#pragma mark - gamepiece view
//-(void)testGamePieceViewExists {
//    for (GamePiece *piece in _gameBoard.pieces) {
//        XCTAssertFalse(piece.view, @"Piece View Should exist");
//    }
//}

//-(void)testGamePieceViewFrameShouldHaveStartLocation {
//
//    for (GamePiece *piece in _gameBoard.pieces) {
//
//        XCTAssert(piece.view.frame.origin.y < 0, @"game piece view should have starting location that is vertically off the screen");
//    }
//}

-(void)testMatrixIsNil {
    XCTAssertTrue(_gameBoard.matrixIsNil, @"matrix should be nil");
}


#pragma mark - GamePiece

-(void)testOffStateForSlot {
    
    CGPoint positionInMatrix;
    
    for (positionInMatrix.x = 0; positionInMatrix.x < 7; positionInMatrix.x++) {
        for (positionInMatrix.y = 0 ; positionInMatrix.y < 6; positionInMatrix.y++) {
            XCTAssertFalse([_gameBoard getStateForPieceAt:positionInMatrix], @"slot should be empty when initialized");
        }
    }
}

//-(void)testSetStateForPieceInMatrix {
//
//    CGPoint positionInMatrix;
//
//    for (positionInMatrix.x = 0; positionInMatrix.x < 7; positionInMatrix.x++) {
//        for (positionInMatrix.y = 0 ; positionInMatrix.y < 6; positionInMatrix.y++) {
//
//            [_gameBoard setState:black forPieceAt:positionInMatrix];
//
//            XCTAssertNotEqual([_gameBoard getStateForPieceAt:positionInMatrix], emptySlot, @"piece state should be populated");
//        }
//    }
//}

-(void)testifPieceCanBeAddedToColumn {
    
    _gameBoard = [[GameBoard alloc] initWithEmptySlots];
    
    for (int i = 0; i < 7; i++ ) {
        XCTAssertTrue([_gameBoard addPieceForColumn:i], @"Piece should have been added to column");
    }
}

-(void)testSetFrameForPieceInMatrix {
    _gameBoard = [[GameBoard alloc] initWithEmptySlots];
    
    [_gameBoard setFrame:CGRectMake(0, 0, 50, 50) forPieceAt:CGPointMake(0, 0)];
    
}


-(void)textGameBoardTurn {
    
    XCTAssertEqual([_gameBoard nextTurn], [_gameBoard nextTurn], @"should change turn");
    
}

-(void)testShoudExamineBoardForWinningCondition {
    
    XCTAssertTrue([_gameBoard examineGameBoardForWinningCondition], @"Should examine board for winning condition");
}

@end