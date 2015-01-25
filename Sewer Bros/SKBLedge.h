//
//  SKBLedge.h
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 27/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"

#define kLedgeBrickFileName @"LedgeBrick.png"
#define kLedgeBrickSpacing 9
#define kLedgeSideBufferSpacing 4

@interface SKBLedge : NSObject
- (void) createNewSetOfLedgeNodes:(SKScene *)whichScene startingPoint:(CGPoint)leftSide
            withHowManyBlocks:(int)blockCount startingIndex:(int)indexStart;
@end
