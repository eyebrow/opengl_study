//
//  PWShaderTool.h
//  opengl_study
//
//  Created by iprincewang on 2017/8/8.
//  Copyright © 2017年 com.tencent.prince. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLKit/GLkit.h"

@interface PWShaderTool : NSObject

+(void)checkOpenGLError:(NSString *)op;

+(GLuint)createShaderWithVertexPath:(NSString *)vpath withFragPath:(NSString *)fPath;

@end
