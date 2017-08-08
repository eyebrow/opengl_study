//
//  vertex.c
//  opengl_study
//
//  Created by iprincewang on 2017/8/8.
//  Copyright © 2017年 com.tencent.prince. All rights reserved.
//

attribute vec4 aPosition;
attribute vec4 aTextureCoord;
varying vec2 vTextureCoord;
uniform mat4 uMVPMatrix;

void main() {
    gl_Position = uMVPMatrix * aPosition;
    vTextureCoord = aTextureCoord.xy;
}
