//
//  YouEatAppDelegate.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright Alessandro Vincelli 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouEatAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	//IBOutlet UINavigationBar *navigationBar;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
//@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;

@end
