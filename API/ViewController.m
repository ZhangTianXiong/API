//
//  ViewController.m
//  API
//
//  Created by DC017 on 15/12/17.
//  Copyright © 2015年 DC017. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UILabel * label;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *httpUrl = @"http://apis.baidu.com/apistore/qunaerticket/querydetail";
    NSString *httpArg = @"id=1361653183";
    [self request: httpUrl withHttpArg: httpArg];
    [self layout];

}

-(void)layout{
    label=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 335, 300)];
    label.layer.borderWidth=2;
    label.layer.borderColor=[UIColor orangeColor].CGColor;
    label.textColor=[UIColor redColor];
    label.numberOfLines=20;
    label.font=[UIFont fontWithName:@"" size:12];
    
    [self.view addSubview:label];
}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"bcda946f771d8be61f41ef7fe383447f" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
     
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
                                   
                                   NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   
                                   NSLog(@"%@",dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"source"]);
                                   NSLog(@"%@",dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"][@"address"]);
                                   NSLog(@"%@",dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"][@"alias"]);
                                   
                                   NSLog(@"%@",dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"][@"description"]);
                                   

                                   NSLog(@"%@",dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"]);
                                   NSLog(@"+++++++++++++++++++++%@",dic);
                                   

                                   label.text=[NSString stringWithFormat:@"%@  =====  %@    ==========    %@  ======== %@    ",dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"source"],dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"][@"address"],dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"][@"description"],dic[@"retData"][@"ticketDetail"][@"data"][@"display"][@"ticket"]];

                                   
                                  //label.text=dic[@"retData"][];
                               }
                           }];
}- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
