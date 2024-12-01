/// Common.metal

/// This file contains some basic helpers.

//  Created by Lingheng Tony Tao on 11/20/24.


#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

#ifndef COMMON_METAL
#define COMMON_METAL
using namespace metal;

// MARK: Rotate Matrix
///  Return the rotation matrix of angle `a` (in radian)
// MARK: Params(Polar Coordinates)
/// `a`:  the rotation angle in radian
inline float2x2 rotateMatrix(float theta) {
    float sinTheta = sin(theta);
    float cosTheta = cos(theta);
    return float2x2(cosTheta, -sinTheta, sinTheta, cosTheta);
}

// MARK: Hash 21
///  Return the hash value for an input 2d vector; used for PRNG generated by float2
// MARK: Params(Polar Coordinates)
/// `p`: the seed used for generating pseudorandom number
inline float hash21(float2 p) {
    p = fract(p * float2(424.34, 342.21));
    p += dot(p, p + 34.32);
    return fract(p.x * p.y);
}

// MARK: Polar Coordinates
///  Return the polar coordinates value converted from the input position and UI frame size
// MARK: Params(Polar Coordinates)
/// `position`: the current user-space coordinate
/// `size`: the logic size in pt of the current UI view
/// `center`: the UV space center where you want the polar coordinates to radiate from
inline float2 polarCoordinates (float2 position, float2 size, float2 center) {
    float2 uv = position / size;
    float2 delta = uv - center;
    
    float radius = length(delta);
    float theta = atan2(delta.x, delta.y) / (2 * M_PI_F);
    
    return float2(radius, theta);
}

#endif