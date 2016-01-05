//
//  AnswersHolder.m
//  SimpleChat
//
//  Created by TEst on 04/01/2016.
//  Copyright © 2016 Logan Wright. All rights reserved.
//

#import "AnswersHolder.h"

@implementation AnswersHolder

+ (id)sharedAnswers {
    static AnswersHolder *holder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        holder = [[self alloc] init];
    });
    return holder;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end
