//
//  JGIrrationalNumber.m
//  JGIrrationalNumberExample
//
//  Created by Jaden Geller on 3/15/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGIrrationalNumber.h"

@interface JGIrrationalNumber ()
{
    NSUInteger currentIndex;
    NSMutableDictionary *storage;
}

// guarenteed to fire in ascending order from i = 0 to i -> infinity
@property (nonatomic, copy, readonly) seriesBlock ithTermInSeries;

@property (nonatomic) NSDecimalNumber *currentTermValue;
@property (nonatomic) NSDecimalNumber *currentTermIndex;
@property (nonatomic) NSDecimalNumber *buffer;

@end

@implementation JGIrrationalNumber

+(JGIrrationalNumber*)irrationalNumberWithConvergingSeries:(seriesBlock)series{
    return [[JGIrrationalNumber alloc]initWithConvergingSeries:series];
}

-(id)initWithConvergingSeries:(seriesBlock)series{
    if (self = [super init]) {
        _ithTermInSeries = series;
        storage = [[NSMutableDictionary alloc]init];
        [self reset];
    }
    return self;
}

-(id)init{
    return [self initWithConvergingSeries:nil];
}

-(void)getDigitsInRange:(NSRange)range withBlock:(iteratorBlock)digitIterater{
    
    NSInteger end = range.location + range.length;
    for (NSInteger i = range.location; i < end; i++) {
        digitIterater(i, [self digitAtIndex:i]);
    }
}

-(void)setCurrentTermValue:(NSDecimalNumber*)currentTermValue{
    // If you want to implement convergence checks, you need to check the deltas
    //if ([_currentTermValue compare:currentTermValue] == NSOrderedAscending) [NSException raise:@"Invalid irrational series" format:@"The series does not converge"];
    _currentTermValue = currentTermValue;
}

// only fast when iterating in ascending order
-(NSString*)digitAtIndex:(NSInteger)index{
    if (currentIndex > index + 1) {
        [self reset];
    }
    
    while (currentIndex <= index || ([self.currentTermIndex compare:[NSDecimalNumber zero]] == NSOrderedSame)) {

        // shift buffer
        self.buffer = [self.buffer decimalNumberBySubtracting:[self.buffer decimalNumberByFlooring]];
        self.buffer = [self.buffer decimalNumberByMultiplyingByPowerOf10:1];
        
        while (![self currentTermIsSufficientlyAccurate]) {
            self.currentTermValue = self.ithTermInSeries(self.currentTermIndex, storage);
            NSDecimalNumber *adjustedTermValueForBuffer = [self.currentTermValue decimalNumberByMultiplyingByPowerOf10:currentIndex];
            self.buffer = [self.buffer decimalNumberByAdding:adjustedTermValueForBuffer];
            
            self.currentTermIndex = [self.currentTermIndex decimalNumberByIncrementing];
        }
        currentIndex++;

    }
    
    return [NSString stringWithFormat:@"%i",self.buffer.intValue];
}

-(BOOL)currentTermIsSufficientlyAccurate{
    // returns if the term is small enough that it cannot affect the relevant digits
    if ([self.currentTermValue compare:[NSDecimalNumber maximumDecimalNumber]] == NSOrderedSame) return NO;
    
    NSDecimalNumber *larger = [self.currentTermValue decimalNumberByMultiplyingByPowerOf10:currentIndex + 1];
    return ([[larger decimalNumberByTakingTheAbsoluteValue]decimalNumberByFlooring].integerValue == 0);
}

-(void)reset{
    _currentTermValue = [NSDecimalNumber maximumDecimalNumber];
    _currentTermIndex = [NSDecimalNumber zero];
    _buffer = [NSDecimalNumber zero];
    
    currentIndex = 0;
    [storage removeAllObjects];
}

@end
