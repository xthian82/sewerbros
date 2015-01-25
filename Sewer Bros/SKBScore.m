//
//  SKBScore.m
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 1/1/15.
//  Copyright (c) 2015 Cristhian Recalde. All rights reserved.
//

#import "SKBScore.h"

@implementation SKBScore

- (void)createScoreNumberTextures
{
    NSMutableArray *textureArray = [NSMutableArray arrayWithCapacity:10];
    SKTexture *numberTexture = [SKTexture textureWithImageNamed:kTextNumber0FileName];
    [textureArray insertObject:numberTexture atIndex:0];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber1FileName];
    [textureArray insertObject:numberTexture atIndex:1];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber2FileName];
    [textureArray insertObject:numberTexture atIndex:2];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber3FileName];
    [textureArray insertObject:numberTexture atIndex:3];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber4FileName];
    [textureArray insertObject:numberTexture atIndex:4];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber5FileName];
    [textureArray insertObject:numberTexture atIndex:5];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber6FileName];
    [textureArray insertObject:numberTexture atIndex:6];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber7FileName];
    [textureArray insertObject:numberTexture atIndex:7];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber8FileName];
    [textureArray insertObject:numberTexture atIndex:8];
    numberTexture = [SKTexture textureWithImageNamed:kTextNumber9FileName];
    [textureArray insertObject:numberTexture atIndex:9];
    
    _arrayOfNumberTextures = [NSArray arrayWithArray:textureArray];
    NSLog(@"numbers created");
}

- (void)createScoreNodes:(SKScene *)whichScene
{
    if (!_arrayOfNumberTextures) {
        [self createScoreNumberTextures];
    }
    SKTexture *headerTexture = [SKTexture textureWithImageNamed:kTextPlayerHeaderFileName];
    CGPoint startWhere = CGPointMake(CGRectGetMinX(whichScene.frame) + kScorePlayer1distanceFromLeft,
                                     CGRectGetMaxY(whichScene.frame) - kScoreDistanceFromTop);
    // Header
    SKSpriteNode *header = [SKSpriteNode spriteNodeWithTexture:headerTexture];
    header.name = @"score_player_header";
    header.position = startWhere;
    header.xScale = 2;
    header.yScale = 2;
    header.physicsBody.dynamic = NO;
    [whichScene addChild:header];
    
    // Score, 5-digits
    SKTexture *textNumber0Texture = [SKTexture textureWithImageNamed:kTextNumber0FileName];
    for (int index=1; index <= kScoreDigitCount; index++) {
        SKSpriteNode *zero = [SKSpriteNode spriteNodeWithTexture:textNumber0Texture];
        zero.name = [NSString stringWithFormat:@"score_player_digit%d", index];
        zero.position = CGPointMake(startWhere.x + 20 + (16*index), CGRectGetMaxY(whichScene.frame) - kScoreDistanceFromTop);
        zero.xScale = 2;
        zero.yScale = 2;
        zero.physicsBody.dynamic = NO;
        [whichScene addChild:zero];
    }
}

- (void)updateScore:(SKScene *)whichScene newScore:(int)theScore
{
    NSString *numberString = [NSString stringWithFormat:@"00000%d", theScore];
    NSString *substring = [numberString substringFromIndex:[numberString length]- 5];
    for (int index = 1; index <= 5; index++) {
        [whichScene enumerateChildNodesWithName:[NSString stringWithFormat:@"score_player_digit%d", index]
                    usingBlock:^(SKNode *node, BOOL *stop) {
                        NSString *charAtIndex = [substring substringWithRange:NSMakeRange(index-1, 1)];
                        int charIntValue = [charAtIndex intValue];
                        SKTexture *digitTexture = [_arrayOfNumberTextures objectAtIndex:charIntValue];
                        SKAction *newDigit = [SKAction animateWithTextures:@[digitTexture] timePerFrame:0.1];
                        [node runAction:newDigit];
                    }
        ];
    }
}

@end
