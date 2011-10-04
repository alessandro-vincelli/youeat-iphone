//
//  YouEatViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YouEatViewController.h"

@implementation YouEatViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

//- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
//	[self searchRisto:theSearchBar.text];
//	self.navigationItem.rightBarButtonItem = nil;
//	[searchBar resignFirstResponder];
//	[self.tableViewRisto reloadData];
//}

//- (void) searchRisto:(NSString *)searchText{
//	
//	NSString *urlString = @"";
//	
//	if([searchText length] > 2) {
//		[listOfRisto retain];
//		[listOfRisto removeAllObjects];
//		NSString *text = [searchText stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
//		urlString = [NSString stringWithFormat:@"/findRistoranti/%@", text]; 
//		//performs the search
//		NSDictionary *statuses = [restUtil sendRestRequest:urlString];
//		
//		NSDictionary *ristoranteList = [statuses objectForKey:@"ristoranteList"];
//		
//		NSEnumerator *ristoranteEnum = [ristoranteList objectEnumerator];
//		
//		NSDictionary *risto;
//		while ((risto = [ristoranteEnum nextObject])) {
//			[listOfRisto addObject:risto];
//		}
//		[listOfRisto release];
//	}
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *background = [[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]] autorelease];
    [self.view setBackgroundColor:background];

    // SEARCH button
    UIButton *searchBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] autorelease];
    [searchBtn setFrame:CGRectMake(80.0f, 220.0f, 160.0f, 30.0f)];
    [searchBtn setTitle:@"Cerca" forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
    
    // SEARCH title label
    UILabel *searchTitle = [[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 100.0f, 15.0f)] autorelease];
    [searchTitle setText:@"Search risto"];
    [searchTitle setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [searchTitle setTextColor:[UIColor grayColor]];
    
    // SEARCH INPUT
    UITextField *searchInput = [[[UITextField alloc] init] autorelease];
    [searchInput setFrame:CGRectMake(10.0f, 40.0f, 260.0f, 30.0f)];
    [searchInput setPlaceholder:@"Search by name, city, tag"];
    [searchInput setDelegate: self];
    [searchInput setBorderStyle:UITextBorderStyleRoundedRect];
    
    // SEARCH Background label
    UIView* v = [[[UIView alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 280.0f, 100.0f)] autorelease];
    CAGradientLayer* lay = [CAGradientLayer layer];
    lay.colors = [NSArray arrayWithObjects:
                  (id)[UIColor colorWithWhite:1 alpha:1].CGColor,
                  [UIColor colorWithRed:0.9 green:0.3 blue:0.0 alpha:0].CGColor, nil];
    lay.frame = v.layer.bounds;
    [v.layer addSublayer:lay];
    lay.borderWidth = 0.5;
    lay.borderColor = [UIColor grayColor].CGColor;
    lay.cornerRadius = 8;
    
    [v addSubview:searchInput];
    [v addSubview:searchTitle];
    
    [self.view addSubview:v];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
