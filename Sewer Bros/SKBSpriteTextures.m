//
//  SKBSpriteTextures.m
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 21/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import "SKBSpriteTextures.h"

@implementation SKBSpriteTextures

- (void)createAnimationTextures
{
    // 4 animation frames stored as textures
    SKTexture *f1 = [SKTexture textureWithImageNamed: kPlayerRunRight1FileName];
    SKTexture *f2 = [SKTexture textureWithImageNamed: kPlayerRunRight2FileName];
    SKTexture *f3 = [SKTexture textureWithImageNamed: kPlayerRunRight3FileName];
    SKTexture *f4 = [SKTexture textureWithImageNamed: kPlayerRunRight4FileName];
    
    // an array of these textures
    _playerRunRightTextures = @[f1,f2,f3,f4];
    
    //right, jump
    f1 = [SKTexture textureWithImageNamed:kPlayerJumpRightFileName];
    _playerJumpingRightTextures = @[f1];
    
    //right, skidding
    f1 = [SKTexture textureWithImageNamed:kPlayerSkidRightFileName];
    _playerSkiddingRightTextures = @[f1];
    
    //right, still
    f1 = [SKTexture textureWithImageNamed: kPlayerStillRightFileName];
    _playerStillFacingRightTextures = @[f1];
    
    //Left
    f1 = [SKTexture textureWithImageNamed: kPlayerRunLeft1FileName];
    f2 = [SKTexture textureWithImageNamed: kPlayerRunLeft2FileName];
    f3 = [SKTexture textureWithImageNamed: kPlayerRunLeft3FileName];
    f4 = [SKTexture textureWithImageNamed: kPlayerRunLeft4FileName];
    
    // an array of these textures
    _playerRunLeftTextures = @[f1,f2,f3,f4];
    
    //left, jump
    f1 = [SKTexture textureWithImageNamed:kPlayerJumpLeftFileName];
    _playerJumpingLeftTextures = @[f1];
    
    //left, skidding
    f1 = [SKTexture textureWithImageNamed:kPlayerSkidLeftFileName];
    _playerSkiddingLeftTextures = @[f1];
    
    //left, still
    f1 = [SKTexture textureWithImageNamed: kPlayerStillLeftFileName];
    _playerStillFacingLeftTextures = @[f1];
    
    //ratz, left
    f1 = [SKTexture textureWithImageNamed:kRatzRunLeft1FileName];
    f2 = [SKTexture textureWithImageNamed:kRatzRunLeft2FileName];
    f3 = [SKTexture textureWithImageNamed:kRatzRunLeft3FileName];
    f4 = [SKTexture textureWithImageNamed:kRatzRunLeft4FileName];
    SKTexture *f5 = [SKTexture textureWithImageNamed:kRatzRunLeft5FileName];
    _ratzRunLeftTextures = @[f1, f2, f3, f4, f5];
    
    //ratz, right
    f1 = [SKTexture textureWithImageNamed:kRatzRunRight1FileName];
    f2 = [SKTexture textureWithImageNamed:kRatzRunRight2FileName];
    f3 = [SKTexture textureWithImageNamed:kRatzRunRight3FileName];
    f4 = [SKTexture textureWithImageNamed:kRatzRunRight4FileName];
    f5 = [SKTexture textureWithImageNamed:kRatzRunRight5FileName];
    _ratzRunRightTextures = @[f1, f2, f3, f4, f5];
    
    //ratz, KO facing left
    f1 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft1FileName];
    f2 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft2FileName];
    f3 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft3FileName];
    f4 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft4FileName];
    f5 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft5FileName];
    _ratzKOFacingLeftTextures = @[f1,f2,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,
                                  f5,f5,f5,f5,f5,f5,f5,f3,f2,f3,f2,f3,f2,f1];
    
    //ratz, KO facing right
    f1 = [SKTexture textureWithImageNamed:kRatzKOfacingRight1FileName];
    f2 = [SKTexture textureWithImageNamed:kRatzKOfacingRight2FileName];
    f3 = [SKTexture textureWithImageNamed:kRatzKOfacingRight3FileName];
    f4 = [SKTexture textureWithImageNamed:kRatzKOfacingRight4FileName];
    f5 = [SKTexture textureWithImageNamed:kRatzKOfacingRight5FileName];
    _ratzKOFacingRightTextures = @[f1,f2,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,
      f5,f5,f5,f5,f5,f5,f5,f3,f2,f3,f2,f3,f2,f1];
    
    f1 = [SKTexture textureWithImageNamed:kCoin1FileName];
    f2 = [SKTexture textureWithImageNamed:kCoin2FileName];
    f3 = [SKTexture textureWithImageNamed:kCoin3FileName];
    _coinTextures = @[f1, f2, f3, f2];
}

@end
