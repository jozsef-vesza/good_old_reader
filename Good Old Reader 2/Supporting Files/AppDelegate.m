//
//  AppDelegate.m
//  Good Old Reader 2
//
//  Created by András Somogyi on 2015. 01. 25..
//  Copyright (c) 2015. András Somogyi. All rights reserved.
//

#import "AppDelegate.h"
#import "ApiManager.h"
#import "DataController.h"
#import "FeedTableViewController.h"
#import <PersistenceKit/PersistenceKit.h>


@interface AppDelegate ()

@property (strong, nonatomic) FeedTableViewController *rootVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Launched in background %d", UIApplicationStateBackground == application.applicationState);

    // Core Data
    CoreDataStack *coreDataStack = [[CoreDataStack alloc] initWithStoreURL:[self storeURL] modelURL:[self modelURL]];
    PersistenceManager *persistenceManager = [[PersistenceManager alloc] initWithCoreDataStack:coreDataStack];
    ApiManager *apiManager = [[ApiManager alloc] init];
    DataController *dataController = [[DataController alloc] initWithApiManager:apiManager persistenceManager:persistenceManager];
    dataController.managedObjectContext = coreDataStack.managedObjectContext;
    
    // Injecting DataController in root viewcontroller
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    self.rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FeedTableViewController"];
    self.rootVC.dataController = dataController;

    navController.viewControllers = @[self.rootVC];
    
    // Setting up background fetch
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    return YES;
}

- (NSURL*)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"GoodOldReader.sqlite"];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"Article" withExtension:@"momd"];
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    ApiManager *apiManager = [[ApiManager alloc] init];
//    DataController *dataController = [[DataController alloc] initWithApiManager:apiManager];
//    [dataController getUnreadWithCompletion:^(NSArray *unreadArticles) {
//        self.rootVC.articleArray = unreadArticles;
//        [self.rootVC  updateFeedFromBackgroundFetch:completionHandler];
//    }];
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler {
    self.backgroundSessionCompletionHandler = completionHandler;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
