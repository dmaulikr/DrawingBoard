//
//  RunsBrushModel.m
//  DrawingBoard
//
//  Created by runs on 2017/8/15.
//  Copyright © 2017年 Olacio. All rights reserved.
//

#import "RunsBrushModel.h"
#import <objc/runtime.h>

@implementation RunsBrushModel

- (id)copyWithZone:(NSZone *)zone {
    RunsBrushModel *model = [[[self class] allocWithZone:zone] init];
    model.shape = self.shape;
    model.color = self.color;
    model.width = self.width;
    model.fillColor = self.fillColor;
    model.frames = self.frames;
    model.isFill = self.isFill;
    return model;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *ivarLists = class_copyIvarList([RunsBrushModel class], &count);
    for (int i = 0; i < count; i++) {
        const char* name = ivar_getName(ivarLists[i]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:strName] forKey:strName];
    }
    free(ivarLists);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivarLists = class_copyIvarList([RunsBrushModel class], &count);
        for (int i = 0; i < count; i++) {
            const char* name = ivar_getName(ivarLists[i]);
            NSString* strName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:strName];
            [self setValue:value forKey:strName];
        }
        free(ivarLists);
    }
    return self;
}

- (instancetype)initWithShape:(ShapeType)shape
                    lineColor:(UIColor *)color
                    lineWidth:(CGFloat)width
                    fillColor:(UIColor *)fillColor
                       frames:(NSArray<NSValue*> *)frames
                         fill:(BOOL)isFill {
    self = [super init];
    if (self) {
        _shape = shape;
        _color = color;
        _width = width;
        _fillColor = fillColor;
        _frames = [NSMutableArray arrayWithArray:frames];
        _isFill = isFill;
    }
    return self;
}

+ (instancetype)brushWithShape:(ShapeType)shape color:(UIColor *)color thickness:(CGFloat)width {
    RunsBrushModel *brush = [[RunsBrushModel alloc] initWithShape:shape
                                                        lineColor:color
                                                        lineWidth:width
                                                        fillColor:nil
                                                           frames:nil
                                                             fill:NO];
    return brush;
}

+ (instancetype)brushWithShape:(ShapeType)shape
                     lineColor:(UIColor *)color
                     lineWidth:(CGFloat)width
                     fillColor:(UIColor *)fillColor
                        frames:(NSArray<NSValue*> *)frames
                          fill:(BOOL)isFill {
    
    RunsBrushModel *brush = [[RunsBrushModel alloc] initWithShape:shape
                                                        lineColor:color
                                                        lineWidth:width
                                                        fillColor:fillColor
                                                           frames:frames
                                                             fill:isFill];
    return brush;
}

+ (instancetype)defaultWithShape:(ShapeType)shape
                       lineColor:(UIColor *)color
                       lineWidth:(CGFloat)width
                          frames:(NSArray<NSValue*> *)frames {
    
    RunsBrushModel *brush = [[RunsBrushModel alloc] initWithShape:shape
                                                        lineColor:color
                                                        lineWidth:width
                                                        fillColor:UIColor.clearColor
                                                           frames:frames
                                                             fill:NO];
    return brush;
}

@end
