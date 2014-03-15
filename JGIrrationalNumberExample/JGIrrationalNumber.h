//
//  JGIrrationalNumber.h
//  JGIrrationalNumberExample
//
//  Created by Jaden Geller on 3/15/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDecimalNumber+Extensions.h"

typedef NSDecimalNumber* (^seriesBlock)(NSDecimalNumber *term, NSMutableDictionary *storage);
typedef void (^iteratorBlock)(NSInteger index, NSString *digit);

@interface JGIrrationalNumber : NSObject

+(JGIrrationalNumber*)irrationalNumberWithConvergingSeries:(seriesBlock)series;
-(id)initWithConvergingSeries:(seriesBlock)series;

-(void)getDigitsInRange:(NSRange)range withBlock:(iteratorBlock)digitIterater;

@end
