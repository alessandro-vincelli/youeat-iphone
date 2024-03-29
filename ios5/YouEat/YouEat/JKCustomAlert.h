//
//  JKCustomAlert.h
//  CustomAlert
//
//  Created by Joris Kluivers on 4/2/09.
//  Copyright 2009 Tarento Software Solutions & Projects. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKCustomAlertDelegate
- (void)stopRequestEvent;
@end

@interface JKCustomAlert : UIAlertView {
	UILabel *alertTextLabel;
	UIImage *backgroundImage;    	
    UIActivityIndicatorView *activityView;
}
@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property(readwrite, retain) UIImage *backgroundImage;
@property(readwrite, retain) NSString *alertText;

- (id) initWithImage:(UIImage *)backgroundImage text:(NSString *)text delegate:(id)delegate;

@end
