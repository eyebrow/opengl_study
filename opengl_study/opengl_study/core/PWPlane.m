//
//  PWPlane.m
//  opengl_study
//
//  Created by iprincewang on 2017/8/8.
//  Copyright © 2017年 com.tencent.prince. All rights reserved.
//

#import "PWPlane.h"
#import "GLKit/GLkit.h"
#import "PWShaderTool.h"

static  GLfloat QUAD_VERTEXS[] = {
    -1.0f,1.0f,0.0f,//Position 0
    0,1.0f,//TexCoord 0
    
    -1.0f,-1.0f,0.0f,//Position 1
    0,0.0f,//TexCoord 1
    
    1.0f,-1.0f,0.0f,//Position 2
    1.0f,0.0f,//TexCoord 2
    
    1.0f,1.0f,0.0f,//Position 3
    1.0f,1.0f,//TexCoord 3
};

static  GLshort QUAD_INDEXS[] = {
    0,//Position 0
    1,//Position 1
    2,//Position 2
    
    2,//Position 2
    3,//Position 3
    0,//Position 0
};

@interface PWPlane ()
{
    GLfloat *_mVertexBuffer;
    GLshort *_mIndexBuffer;
}

@end

@implementation PWPlane

-(instancetype)init
{
    if (self = [super init]) {
        
        _mVertexBuffer = (GLfloat *)malloc(sizeof(QUAD_VERTEXS));
        memcpy(_mVertexBuffer, QUAD_VERTEXS, sizeof(QUAD_VERTEXS));
        
        _mIndexBuffer = (GLshort *)malloc(sizeof(QUAD_INDEXS));
        memcpy(_mIndexBuffer, QUAD_INDEXS, sizeof(QUAD_INDEXS));
    }
    
    return self;
}

-(void)uploadBufferWithPositionHandler:(int)positionHandler withTextureCoordHandler:(int)textureCoordHandler
{
    glEnableVertexAttribArray(positionHandler);
    [PWShaderTool checkOpenGLError:@"glEnableVertexAttribArray aPositionHandler"];
    glEnableVertexAttribArray(textureCoordHandler);
    [PWShaderTool checkOpenGLError:@"glEnableVertexAttribArray aTextureCoordHandler"];
    
    glVertexAttribPointer(positionHandler, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), _mVertexBuffer);
    
    glVertexAttribPointer(textureCoordHandler, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), _mVertexBuffer + 3);
}

-(void)draw
{
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, _mIndexBuffer);
}

@end
