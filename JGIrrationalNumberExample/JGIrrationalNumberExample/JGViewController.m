//
//  JGViewController.m
//  JGIrrationalNumberExample
//
//  Created by Jaden Geller on 3/15/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGViewController.h"
#import "JGIrrationalNumber.h"

@interface JGViewController ()

@end

@implementation JGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    JGIrrationalNumber *e = [JGIrrationalNumber irrationalNumberWithConvergingSeries:^NSDecimalNumber *(NSDecimalNumber *term, NSMutableDictionary *storage) {
        
        NSDecimalNumber *factorial = storage[@"factorial"]?: [NSDecimalNumber one];
        if ([term compare:[NSDecimalNumber zero]] != NSOrderedSame) factorial = [factorial decimalNumberByMultiplyingBy:term];
        
        storage[@"factorial"] = factorial;
        
        return [[NSDecimalNumber one] decimalNumberByDividingBy:factorial];
        
    }];
    
    NSMutableString *eStr = [NSMutableString string];
    [e getDigitsInRange:NSMakeRange(0, 40) withBlock:^void(NSInteger index, NSString *digit) {
        if (index == 1) [eStr appendString:@"."];
        [eStr appendString:digit];
    }];
    
    JGIrrationalNumber *pi = [JGIrrationalNumber irrationalNumberWithConvergingSeries:^NSDecimalNumber *(NSDecimalNumber *term, NSMutableDictionary *storage) {
        // Shitty algorithm converges VERY slowly so you can't calculate more than a few digits
        
        NSDecimalNumber *counter = storage[@"counter"]?: [NSDecimalNumber one];
        storage[@"counter"] = [counter decimalNumberByAdding:[NSDecimalNumber decimalNumberWithDecimal:@(2).decimalValue]];
        
        NSDecimalNumber *four = storage[@"four"];
        if (!four){
            four = [NSDecimalNumber decimalNumberWithDecimal:@(4).decimalValue];
            storage[@"four"] = four;
        }
        
        NSDecimalNumber *new = [four decimalNumberByDividingBy:counter];
        if ([term isOdd]) new = [new decimalNumberByNegating];
        
        return new;
    }];
    
    NSMutableString *piStr = [NSMutableString string];
    [pi getDigitsInRange:NSMakeRange(0, 4) withBlock:^void(NSInteger index, NSString *digit) {
        if (index == 1) [piStr appendString:@"."];
        [piStr appendString:digit];
    }];
    
    NSLog(@"e  = %@",eStr);
    NSLog(@"pi = %@",piStr);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
