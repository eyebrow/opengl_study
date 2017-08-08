//
//  fragment.c
//  opengl_study
//
//  Created by iprincewang on 2017/8/8.
//  Copyright © 2017年 com.tencent.prince. All rights reserved.
//


precision mediump float;
varying vec2 vTextureCoord;
uniform sampler2D sTexture;

void main() {
    gl_FragColor=texture2D(sTexture, vTextureCoord);
}
