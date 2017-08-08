//
//  PWShaderTool.m
//  opengl_study
//
//  Created by iprincewang on 2017/8/8.
//  Copyright © 2017年 com.tencent.prince. All rights reserved.
//

#import "PWShaderTool.h"
#import "PWFileHander.h"

@implementation PWShaderTool

+(void)checkOpenGLError:(NSString *)op
{
    int error = glGetError();
    
    if (error != GL_NO_ERROR) {
        NSString *msg = [op stringByAppendingString:[NSString stringWithFormat:@":glError 0x%X",error]];
        
        NSLog(@"%@",msg);
    }
}

+(GLuint)createShaderWithVertexPath:(NSString *)vpath withFragPath:(NSString *)fPath
{
    // Load the vertex/fragment shaders
    GLuint vertexShader = [self createShaderWithType:GL_VERTEX_SHADER
                                        withFilepath:vpath];
    if (vertexShader == 0)
        return 0;
    
    GLuint fragmentShader = [self createShaderWithType:GL_FRAGMENT_SHADER
                                          withFilepath:fPath];
    if (fragmentShader == 0) {
        glDeleteShader(vertexShader);
        return 0;
    }
    
    // Create the program object
    GLuint programHandle = glCreateProgram();
    if (programHandle == 0)
        return 0;
    
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    
    // Link the program
    glLinkProgram(programHandle);
    
    // Check the link status
    GLint linked;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linked);
    
    if (!linked) {
        GLint infoLen = 0;
        glGetProgramiv(programHandle, GL_INFO_LOG_LENGTH, &infoLen);
        
        if (infoLen > 1){
            char * infoLog = malloc(sizeof(char) * infoLen);
            glGetProgramInfoLog(programHandle, infoLen, NULL, infoLog);
            
            NSLog(@"Error linking program:\n%s\n", infoLog);
            
            free(infoLog);
        }
        
        glDeleteProgram(programHandle );
        return 0;
    }
    
    // Free up no longer needed shader resources
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    
    return programHandle;

}

#pragma mark - private

+(GLuint)createShaderWithType:(GLenum)type withFilepath:(NSString *)shaderFilepath
{
    NSString *path = [PWFileHander getPathForResource:shaderFilepath];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:path
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    if (!shaderString) {
        NSLog(@"Error: loading shader file: %@ %@", shaderFilepath, error.localizedDescription);
        return 0;
    }
    
    return [self createShaderWithType:type withString:shaderString];
}

+(GLuint)createShaderWithType:(GLenum)type withString:(NSString *)shaderString
{
    // Create the shader object
    GLuint shader = glCreateShader(type);
    if (shader == 0) {
        NSLog(@"Error: failed to create shader.");
        return 0;
    }
    
    // Load the shader source
    const char * shaderStringUTF8 = [shaderString UTF8String];
    glShaderSource(shader, 1, &shaderStringUTF8, NULL);
    
    // Compile the shader
    glCompileShader(shader);
    
    // Check the compile status
    GLint compiled = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
    
    if (!compiled) {
        GLint infoLen = 0;
        glGetShaderiv ( shader, GL_INFO_LOG_LENGTH, &infoLen );
        
        if (infoLen > 1) {
            char * infoLog = malloc(sizeof(char) * infoLen);
            glGetShaderInfoLog (shader, infoLen, NULL, infoLog);
            NSLog(@"Error compiling shader:\n%s\n", infoLog );
            
            free(infoLog);
        }
        
        glDeleteShader(shader);
        return 0;
    }
    
    return shader;
}

@end
