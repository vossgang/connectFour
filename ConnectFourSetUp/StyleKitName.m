//
//  StyleKitName.m
//  ProjectName
//
//  Created by AuthorName on 5/6/14.
//  Copyright (c) 2014 CompanyName. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "StyleKitName.h"


@implementation StyleKitName

#pragma mark Cache

static PCGradient* _gradient = nil;
static PCGradient* _red = nil;

#pragma mark Initialization

+ (void)initialize
{
    // Gradients Initialization
    CGFloat gradientLocations[] = {0, 1};
    _gradient = [PCGradient gradientWithColors: @[UIColor.blackColor, UIColor.whiteColor] locations: gradientLocations];
    CGFloat redLocations[] = {0, 0.38, 1};
    _red = [PCGradient gradientWithColors: @[UIColor.whiteColor, [UIColor colorWithRed: 0.539 green: 0.539 blue: 0.539 alpha: 1], [UIColor redColor]] locations: redLocations];

}

#pragma mark Gradients

+ (PCGradient*)gradient { return _gradient; }
+ (PCGradient*)red { return _red; }

#pragma mark Drawing Methods

+ (void)drawCanvas1;
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.815 green: 0.813 blue: 0.813 alpha: 1];
    UIColor* color4 = [UIColor colorWithRed: 0.622 green: 0.622 blue: 0.622 alpha: 1];

    //// Shadow Declarations
    UIColor* shadow = UIColor.blackColor;
    CGSize shadowOffset = CGSizeMake(3.1, 3.1);
    CGFloat shadowBlurRadius = 5;

    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(14.41, 14.41)];
    [bezierPath addCurveToPoint: CGPointMake(14.41, 31.59) controlPoint1: CGPointMake(9.67, 19.16) controlPoint2: CGPointMake(9.67, 26.84)];
    [bezierPath addCurveToPoint: CGPointMake(31.59, 31.59) controlPoint1: CGPointMake(19.16, 36.33) controlPoint2: CGPointMake(26.84, 36.33)];
    [bezierPath addCurveToPoint: CGPointMake(31.59, 14.41) controlPoint1: CGPointMake(36.33, 26.84) controlPoint2: CGPointMake(36.33, 19.16)];
    [bezierPath addCurveToPoint: CGPointMake(14.41, 14.41) controlPoint1: CGPointMake(26.84, 9.67) controlPoint2: CGPointMake(19.16, 9.67)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(35.02, 10.98)];
    [bezierPath addCurveToPoint: CGPointMake(35.02, 35.02) controlPoint1: CGPointMake(41.66, 17.62) controlPoint2: CGPointMake(41.66, 28.38)];
    [bezierPath addCurveToPoint: CGPointMake(10.98, 35.02) controlPoint1: CGPointMake(28.38, 41.66) controlPoint2: CGPointMake(17.62, 41.66)];
    [bezierPath addCurveToPoint: CGPointMake(10.98, 10.98) controlPoint1: CGPointMake(4.34, 28.38) controlPoint2: CGPointMake(4.34, 17.62)];
    [bezierPath addCurveToPoint: CGPointMake(35.02, 10.98) controlPoint1: CGPointMake(17.62, 4.34) controlPoint2: CGPointMake(28.38, 4.34)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];

    ////// Bezier Inner Shadow
    CGContextSaveGState(context);
    UIRectClip(bezierPath.bounds);
    CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);

    CGContextSetAlpha(context, CGColorGetAlpha([shadow CGColor]));
    CGContextBeginTransparencyLayer(context, NULL);
    {
        UIColor* opaqueShadow = [shadow colorWithAlphaComponent: 1];
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [opaqueShadow CGColor]);
        CGContextSetBlendMode(context, kCGBlendModeSourceOut);
        CGContextBeginTransparencyLayer(context, NULL);

        [opaqueShadow setFill];
        [bezierPath fill];

        CGContextEndTransparencyLayer(context);
    }
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);

    [color4 setStroke];
    bezierPath.lineWidth = 0.5;
    [bezierPath stroke];
}

+ (void)drawCanvas2;
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();


    //// Shadow Declarations
    UIColor* shadow = UIColor.blackColor;
    CGSize shadowOffset = CGSizeMake(3.1, 3.1);
    CGFloat shadowBlurRadius = 5;

    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(6, 6, 34, 34)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
    CGContextBeginTransparencyLayer(context, NULL);
    [ovalPath addClip];
    CGContextDrawLinearGradient(context, StyleKitName.red.CGGradient, CGPointMake(23, 6), CGPointMake(23, 40), 0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);



    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(8, 8, 30, 30)];
    [UIColor.grayColor setFill];
    [oval2Path fill];
}

+ (void)drawCanvas3;
{
    //// Color Declarations
    UIColor* color6 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];

    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(67, 17, 128, 103)];
    [color6 setFill];
    [ovalPath fill];
}

@end



@interface PCGradient ()
{
    CGGradientRef _CGGradient;
}
@end

@implementation PCGradient

- (instancetype)initWithColors: (NSArray*)colors locations: (const CGFloat*)locations
{
    self = super.init;
    if (self)
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        NSMutableArray* cgColors = NSMutableArray.array;
        for (UIColor* color in colors)
            [cgColors addObject: (id)color.CGColor];

        _CGGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)cgColors, locations);
        CGColorSpaceRelease(colorSpace);
    }
    return self;
}

+ (instancetype)gradientWithColors: (NSArray*)colors locations: (const CGFloat*)locations
{
    return [self.alloc initWithColors: colors locations: locations];
}

+ (instancetype)gradientWithStartingColor: (UIColor*)startingColor endingColor: (UIColor*)endingColor
{
    CGFloat locations[] = {0, 1};
    return [self.alloc initWithColors: @[startingColor, endingColor] locations: locations];
}

- (void)dealloc
{
    CGGradientRelease(_CGGradient);
}

@end