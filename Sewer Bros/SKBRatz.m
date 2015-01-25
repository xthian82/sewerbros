//
//  SKBRatz.m
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 28/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import "SKBRatz.h"
#import "SKBGameScene.h"

@implementation SKBRatz

#pragma mark Initialization

+ (SKBRatz*)initNewRatz:(SKScene*)whichScene startingPoint:(CGPoint)location ratzIndex:(int)index
{
    SKTexture* f1 = [SKTexture textureWithImageNamed: kRatzRunRight1FileName];
    
    SKBRatz* ratz = [SKBRatz spriteNodeWithTexture:f1];
    ratz.name = [NSString stringWithFormat:@"ratz%d", index];
    ratz.position = location;
    ratz.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ratz.size];
    ratz.physicsBody.categoryBitMask = kRatzCategory;
    ratz.physicsBody.contactTestBitMask = kBaseCategory | kWallCategory | kLedgeCategory | kPipeCategory | kRatzCategory | kCoinCategory;
    ratz.physicsBody.collisionBitMask = kBaseCategory | kWallCategory | kLedgeCategory | kRatzCategory | kCoinCategory;
    ratz.physicsBody.density = 1.0;
    ratz.physicsBody.linearDamping = 0.1;
    ratz.physicsBody.restitution = 0.2;
    ratz.physicsBody.allowsRotation = NO;
    
    // add the sprite to the scene
    [whichScene addChild:ratz];
    
    return ratz;
}

- (void) spawnedInScene:(SKScene*)whichScene;
{
    SKBGameScene* gameScene = (SKBGameScene *)whichScene;
    _spriteTextures = gameScene.spriteTextures;
    
    // Sound Effects
    _spawnSound = [SKAction playSoundFileNamed:kRatzSpawnSoundFileName waitForCompletion:NO];
    [self runAction:_spawnSound];
    
    if (self.position.x < CGRectGetMidX(gameScene.frame))
        [self runRight];
    else
        [self runLeft];
}

#pragma mark Screen wrap

- (void)wrapRatz:(CGPoint)where
{
    SKPhysicsBody* storePB = self.physicsBody;
    self.physicsBody = nil;
    self.position = where;
    self.physicsBody = storePB;
}

- (void)hitLeftPipe:(SKScene *)whichScene
{
    int leftSideX = CGRectGetMinX(whichScene.frame) + kEnemySpawnEdgeBufferX;
    int topSideY = CGRectGetMaxY(whichScene.frame) - kEnemySpawnEdgeBufferY;
    
    /*SKPhysicsBody *storedPB = self.physicsBody;
    self.physicsBody = nil;
    self.position = CGPointMake(leftSideX, topSideY);
    self.physicsBody = storedPB; */
    [self wrapRatz:CGPointMake(leftSideX, topSideY)];
    [self removeAllActions];
    [self runRight];
    
    //Play spawning sound
    [self runAction:self.spawnSound];
}

- (void)hitRightPipe:(SKScene *)whichScene
{
    int rightSideX = CGRectGetMaxX(whichScene.frame) - kEnemySpawnEdgeBufferX;
    int topSideY = CGRectGetMaxY(whichScene.frame) - kEnemySpawnEdgeBufferY;
    
    /*SKPhysicsBody *storedPB = self.physicsBody;
     self.physicsBody = nil;
     self.position = CGPointMake(rightSideX, topSideY);
     self.physicsBody = storedPB; */
    [self wrapRatz:CGPointMake(rightSideX, topSideY)];
    [self removeAllActions];
    [self runLeft];
    
    //Play spawning sound
    [self runAction:self.spawnSound];
}

#pragma mark Contact
- (void)knockedOut:(SKScene *)whichScene
{
    [self removeAllActions];
    NSArray* textureArray = nil;
    
    if (_ratzStatus == SBRatzRunningLeft) {
        _ratzStatus = SBRatzKOFacingLeft;
        textureArray = [NSArray arrayWithArray:_spriteTextures.ratzKOFacingLeftTextures];
    } else {
        _ratzStatus = SBRatzKOFacingRight;
        textureArray = [NSArray arrayWithArray:_spriteTextures.ratzKOFacingRightTextures];
    }
    
    SKAction* knockedOutAnimation = [SKAction animateWithTextures:textureArray timePerFrame:0.2];
    SKAction* knockedOutAwhile = [SKAction repeatAction:knockedOutAnimation count:1];
    
    [self runAction:knockedOutAwhile completion:^{
        if (_ratzStatus == SBRatzKOFacingLeft) {
            [self runLeft];
        } else if (_ratzStatus == SBRatzKOFacingRight) {
            [self runRight];
        }
    }];
}

#pragma mark Movement

- (void)runRight
{
    NSLog(@"Right tap");
    _ratzStatus = SBRatzRunningRight;
    SKAction* walkAnimation = [SKAction animateWithTextures:_spriteTextures.ratzRunRightTextures timePerFrame:0.05];
    SKAction* walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction* moveRight = [SKAction moveByX:kRatzRunningIncrement y:0 duration:1];
    SKAction* moveForever = [SKAction repeatActionForever:moveRight];
    [self runAction:moveForever];
}

- (void)runLeft
{
    NSLog(@"Left tap");
    _ratzStatus = SBRatzRunningLeft;
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.ratzRunLeftTextures timePerFrame:0.05];
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction* moveLeft = [SKAction moveByX:-kRatzRunningIncrement y:0 duration:1];
    SKAction* moveForever = [SKAction repeatActionForever:moveLeft];
    [self runAction:moveForever];
}

- (void)turnRight
{
    self.ratzStatus = SBRatzRunningRight;
    [self removeAllActions];
    SKAction* moveRight = [SKAction moveByX:5 y:0 duration:0.4];
    [self runAction:moveRight completion:^{ [self runRight]; }];
}

- (void)turnLeft
{
    self.ratzStatus = SBRatzRunningLeft;
    [self removeAllActions];
    SKAction* moveLeft = [SKAction moveByX:-5 y:0 duration:0.4];
    [self runAction:moveLeft completion:^{ [self runLeft]; }];
}

@end
