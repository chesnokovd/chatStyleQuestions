//
//  ViewController.m
//  SimpleChat
//
//  Created by Logan Wright on 3/17/14.
//  Copyright (c) 2014 Logan Wright. All rights reserved.
//

#import "ViewController.h"
#import "Question.h"
#import "AnswersHolder.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *chatViewContainer;
@property (strong,nonatomic) NSMutableArray *questions;
@property (strong,nonatomic) AnswersHolder *answers;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!_chatController) _chatController = [ChatController new];
    _chatController.delegate = self;
    
    _chatController.isNavigationControllerVersion = YES;
    [self.navigationController pushViewController:_chatController animated:YES];
    
    _answers=[AnswersHolder sharedAnswers];
    
    _questions=[[NSMutableArray alloc]init];
    
    Question *q=[[Question alloc]init];
    q.questionString=@"Hello there. Provide us with your details now and we can get started on your conveyancing case.";
    q.questionField=@"";
    [_questions addObject:q];

    q=[[Question alloc]init];
    q.questionString=@"You can click on your answers to edit them.";
    q.questionField=@"";
    [_questions addObject:q];
    
    q=[[Question alloc]init];
    q.questionString=@"Let's get started. What's your name?";
    q.questionField=@"name";
    [_questions addObject:q];
    
    q=[[Question alloc]init];
    q.questionString=@"Nice to meet you ";
    q.questionString=[q.questionString stringByAppendingString:@"<name>"];
    q.questionString=[q.questionString stringByAppendingString:@". What's your surname?"];
    q.questionField=@"surname";
    [_questions addObject:q];
    
    q=[[Question alloc]init];
    q.questionString=@"Great. Well this is the end of this demo";
    q.questionField=@"third";
    [_questions addObject:q];
    
    self.navigationController.navigationBar.hidden = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    float time=arc4random_uniform(2)+1;
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(sendNextQuestion)
                                   userInfo:nil
                                    repeats:NO];
    time=time+arc4random_uniform(2)+2;
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(sendNextQuestion)
                                   userInfo:nil
                                    repeats:NO];
    time=time+arc4random_uniform(2)+2;
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(sendNextQuestion)
                                   userInfo:nil
                                    repeats:NO];
}


-(void)sendNextQuestion{
    
    Question *q=[_questions objectAtIndex:0];
    
    if ([q.questionField isEqualToString:@"surname"])
        q.questionString=[q.questionString stringByReplacingOccurrencesOfString:@"<name>" withString:_answers.name];
    
    NSMutableDictionary *message=[[NSMutableDictionary alloc]init];
    
    message[@"content"]=q.questionString;
    message[@"timestamp"]=@"12414";
    message[@"messageType"] = @"question";
    
    [_chatController addNewMessage:message];
    
    [_questions removeObject:q];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


int c=0;
- (void) chatController:(ChatController *)chatController didSendMessage:(NSMutableDictionary *)message {
    // Messages come prepackaged with the contents of the message and a timestamp in milliseconds
    
    if (c==0)
        _answers.name=message[kMessageContent];
    
    NSLog(@"Message Contents: %@", message[kMessageContent]);
    NSLog(@"Timestamp: %@", message[kMessageTimestamp]);
    
    // Evaluate or add to the message here for example, if we wanted to assign the current userId:
    
    message[@"messageType"] = @"response";
    
    // Must add message to controller for it to show
    [_chatController addNewMessage:message];
    
    float time=arc4random_uniform(1.5)+1;
    
    if([_questions count]>0)
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(sendNextQuestion)
                                   userInfo:nil
                                    repeats:NO];
    else [self.navigationController popViewControllerAnimated:YES];
    c++;
}



/* Optional
- (void) closeChatController {
    [chatController dismissViewControllerAnimated:YES completion:^{
        [chatController removeFromParentViewController];
        chatController = nil;
    }];
}
*/

@end
