//
//  DeepTests.m
//  RaptureXML
//
//  Created by John Blanco on 9/24/11.
//  Copyright (c) 2011 Rapture In Venice. All rights reserved.
//

#import "RXMLElement.h"

@interface DeepTests : SenTestCase {
}

@end



@implementation DeepTests

- (void)testQuery {
    RXMLElement *rxml = [RXMLElement elementFromXMLFile:@"players.xml"];
    __block NSInteger i;
    
    // count the players
    i = 0;
    
    [rxml iterate:@"players.player" usingBlock: ^(RXMLElement *e) {
        i++;
    }];    
    
    STAssertEquals(i, 9, nil);

    // count the first player's name
    i = 0;
    
    [rxml iterate:@"players.player.name" usingBlock: ^(RXMLElement *e) {
        i++;
    }];    
    
    STAssertEquals(i, 1, nil);

    // count the coaches
    i = 0;
    
    [rxml iterate:@"players.coach" usingBlock: ^(RXMLElement *e) {
        i++;
    }];    
    
    STAssertEquals(i, 1, nil);
}

- (void) testCommonParent {
    RXMLElement *rxml = [RXMLElement elementFromXMLFile:@"players.xml"];
    
    NSArray* players = [rxml childrenWithRootXPath:@"//player"];
    STAssertEquals(9U, players.count, nil);
    
    RXMLElement* parent1 = ((RXMLElement*) players[0]).parent;
    RXMLElement* parent2 = ((RXMLElement*) players[1]).parent;
    STAssertEquals(parent1, parent2, @"should return same object");
}

@end
