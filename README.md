JGIrrationalNumber
==================

Allows developer to define irrational numbers as infinite summations and iterate over the digits

Example
==================

We will calculate the natural number e with the infinite series 1/0! + 1/1! + 1/2! + 1/3! + 1/4! + ...

```objective-c
JGIrrationalNumber *e = [JGIrrationalNumber irrationalNumberWithConvergingSeries:^NSDecimalNumber *(NSDecimalNumber *term, NSMutableDictionary *storage) {
        
        NSDecimalNumber *factorial = storage[@"factorial"]?: [NSDecimalNumber one];
        if ([term compare:[NSDecimalNumber zero]] != NSOrderedSame) factorial = [factorial decimalNumberByMultiplyingBy:term];
        
        storage[@"factorial"] = factorial;
        
        return [[NSDecimalNumber one] decimalNumberByDividingBy:factorial];
        
    }];
    
    
    // Iterate over the digits of the number
    [e getDigitsInRange:NSMakeRange(0, 40) withBlock:^void(NSInteger index, NSString *digit) {
        // Do stuff with each digit
    }];

```
