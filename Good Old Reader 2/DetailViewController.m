//
//  DetailViewController.m
//  Good Old Reader 2
//
//  Created by András Somogyi on 2015. 02. 04..
//  Copyright (c) 2015. András Somogyi. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayArticle];
}

- (void)displayArticle {
    NSString *articleUpdateDateString;
    NSString *articleTitle;
    NSString *articleAuthor;
    NSString *articleOrigin;
    NSString *articleSummary;
    
    // Query article title if exists
    if ([self.articleContainer objectForKey:@"title"] == [NSNull null] || [[self.articleContainer objectForKey:@"title"]  isEqual: @""]) {
        articleTitle = @"No title";
    }
    else articleTitle = [self.articleContainer objectForKey:@"title"];
    
    
    // Query article author if exists
    if ([self.articleContainer objectForKey:@"author"] == [NSNull null] || [[self.articleContainer objectForKey:@"author"]  isEqual: @""]) {
        articleAuthor = @"Anonymus";
    }
    else articleAuthor = [self.articleContainer objectForKey:@"author"];
    
    
    // Query article update date if exists
    if ([self.articleContainer objectForKey:@"updated"] == [NSNull null]) {
        articleUpdateDateString = @"";
    }
    else {
        NSDate *articleUpdateDate = [NSDate dateWithTimeIntervalSince1970:[[self.articleContainer objectForKey:@"updated"] doubleValue]];
        NSDateFormatter *articleUpdateDateFormatter = [[NSDateFormatter alloc] init];
        [articleUpdateDateFormatter setDateStyle:NSDateFormatterShortStyle];
        [articleUpdateDateFormatter setTimeStyle:NSDateFormatterShortStyle];
        articleUpdateDateString = [articleUpdateDateFormatter stringFromDate:articleUpdateDate];}
    
    
    // Query origin site if exists
    if ([[self.articleContainer objectForKey:@"origin"] objectForKey:@"title"] == nil || [[[self.articleContainer objectForKey:@"origin"] objectForKey:@"title"]  isEqual: @""]) {
        articleOrigin = @"No site";
        
    }
    else articleOrigin = [[self.articleContainer objectForKey:@"origin"] objectForKey:@"title"];
    
    // Query article text if exists
    if ([[self.articleContainer objectForKey:@"summary"] objectForKey:@"content"] == [NSNull null] || [[[self.articleContainer objectForKey:@"summary"] objectForKey:@"content"]  isEqual: @""]) {
        articleSummary = @"";
    }
    else articleSummary = [[self.articleContainer objectForKey:@"summary"] objectForKey:@"content"];
    
    NSMutableString *preparedArticle = [NSMutableString stringWithString:@"<style type='text/css'>img { max-width: 100%; width: auto; height: auto;}body{font-family:helvetica; font-size:12px;}</style>"];
    [preparedArticle appendString:@"<h1>"];
    [preparedArticle appendString:articleTitle];
    [preparedArticle appendString:@"</h1>"];
    [preparedArticle appendString:@"<p><i>"];
    [preparedArticle appendString:articleAuthor];
    [preparedArticle appendString:@", "];
    [preparedArticle appendString:articleOrigin];
    [preparedArticle appendString:@", "];
    [preparedArticle appendString:articleUpdateDateString];
    [preparedArticle appendString:@"</i></p>"];
    [preparedArticle appendString:articleSummary];
    
    [self.articleDisplay loadHTMLString:preparedArticle baseURL:nil];
    [self markArticleRead];
}

-(void) markArticleRead {
    AFHTTPRequestOperationManager *markAsReadManager = [AFHTTPRequestOperationManager manager];
    [markAsReadManager POST:@"https://theoldreader.com/reader/api/0/edit-tag"
            parameters:@{@"i": [self.articleContainer objectForKey:@"id"],
                         @"a": @"user/-/state/com.google/read",
                         @"output": @"json"}
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   // TODO
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   // TODO
               }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

