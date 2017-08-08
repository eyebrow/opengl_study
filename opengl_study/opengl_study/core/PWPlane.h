//
//  PWPlane.h
//  opengl_study
//
//  Created by iprincewang on 2017/8/8.
//  Copyright © 2017年 com.tencent.prince. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWPlane : NSObject

-(void)uploadBufferWithPositionHandler:(int)positionHandler withTextureCoordHandler:(int)textureCoordHandler;

-(void)draw;

@end
