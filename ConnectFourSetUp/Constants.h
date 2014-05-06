//
//  Constants.h
//  Connexion
//
//  Created by Christopher Cohen on 5/6/14.
//  Copyright (c) 2014 Christopher Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

enum State {empty, redPiece, blackPiece};
enum Turn {redTurn, blackTurn, start, end};

#define CIRCLE_SIZE 45.5
#define ROWS 9
#define COLUMNS 7
#define NUMBER_NEEDED_FOR_DELETION 4
@end
