//
//  NSDecimalNumber+Extensions.m
//  JGIrrationalNumberExample
//
//  Created by Jaden Geller on 3/15/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "NSDecimalNumber+Extensions.h"

@implementation NSDecimalNumber (Extensions)

-(NSDecimalNumber*)decimalNumberByFlooring{
    return [NSDecimalNumber decimalNumberWithDecimal:@(self.integerValue).decimalValue];
}

-(NSDecimalNumber*)decimalNumberByTakingTheAbsoluteValue{
    if ([[NSDecimalNumber zero] compare:self] == NSOrderedDescending) {
        return [self decimalNumberByMultiplyingBy:[NSDecimalNumber negativeOne]];
    }
    else return self;
}

-(NSDecimalNumber*)decimalNumberByIncrementing{
    return [self decimalNumberByAdding:[NSDecimalNumber one]];
}

-(NSDecimalNumber*)decimalNumberByDecrementing{
    return [self decimalNumberBySubtracting:[NSDecimalNumber one]];
}

-(NSDecimalNumber*)decimalNumberByNegating{
    return [self decimalNumberByMultiplyingBy:[NSDecimalNumber negativeOne]];
}

+(NSDecimalNumber*)negativeOne{
    return [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:YES];
}

-(BOOL)isOdd{
    return (self.integerValue % 2 != 0);
}

@end
