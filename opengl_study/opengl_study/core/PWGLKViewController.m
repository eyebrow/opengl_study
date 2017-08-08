//
//  PWGLKViewController.m
//  opengl_study
//
//  Created by iprincewang on 2017/8/8.
//  Copyright © 2017年 com.tencent.prince. All rights reserved.
//

#import "PWGLKViewController.h"
#import "PWPlane.h"
#import "PWShaderTool.h"

@interface PWGLKViewController ()
{
    GLuint _programHandler;
    PWPlane *_drawPlane;
}
@end

@implementation PWGLKViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.title = @"opengl study";
    }
    
    return self;
}

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self openglInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private method
-(void)openglInit
{
    GLKView *view = (GLKView *)self.view;
    //使用NSAssert()函数的一个运行时检查会验证self.view是否为正确的类型
    NSAssert([view isKindOfClass:[GLKView class]], @"PWGLKViewController’s view is not a GLKView");
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];//分配一个新的EAGLContext的实例，并将它初始化为OpenGL ES 2.0
    [EAGLContext setCurrentContext:view.context];//在任何其他的OpenGL ES配置或者渲染之前，应用的GLKview实例的上下文属性都要设置为当前
    
    _drawPlane = [PWPlane new];
    
    [self loadShader];
    
}

-(void)loadShader
{
    _programHandler = [PWShaderTool createShaderWithVertexPath:@"vertex.shader" withFragPath:@"fragment.shader"];
    
    [PWShaderTool checkOpenGLError:@"progam load error"];
    
    glUseProgram(_programHandler);
    
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glViewport(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    glClearColor(0.0f, 0.0f, 0.4f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}


@end
