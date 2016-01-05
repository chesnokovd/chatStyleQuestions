//
//  AnswersHolder.h
//  SimpleChat
//
//  Created by TEst on 04/01/2016.
//  Copyright © 2016 Logan Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswersHolder : NSObject

@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSString * surname;

+ (id)sharedAnswers;

@end
