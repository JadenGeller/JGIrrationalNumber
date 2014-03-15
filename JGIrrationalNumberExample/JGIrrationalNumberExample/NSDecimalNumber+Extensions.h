//
//  NSDecimalNumber+Extensions.h
//  JGIrrationalNumberExample
//
//  Created by Jaden Geller on 3/15/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Extensions)

-(NSDecimalNumber*)decimalNumberByFlooring;
-(NSDecimalNumber*)decimalNumberByTakingTheAbsoluteValue;
-(NSDecimalNumber*)decimalNumberByIncrementing;
-(NSDecimalNumber*)decimalNumberByDecrementing;
-(NSDecimalNumber*)decimalNumberByNegating;
+(NSDecimalNumber*)negativeOne;
-(BOOL)isOdd;

@end