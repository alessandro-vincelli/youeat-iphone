//
//  FriendActivitiesViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/12/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "FriendActivitiesViewController.h"
#import "RistoViewController.h"
#import "URLUtil.h"
#import "ASIHTTPRequest.h"
#import "LoggedUser.h"
#import "JSON/JSON.h"

@implementation FriendActivitiesViewController

@synthesize restUtil, listOfActivities, request, tableViewActivities;

- (void) startsGetActivities {
	[listOfActivities removeAllObjects];
	
	NSString *urlString = @"/security/friendActivitiesByLoggedUser"; 
	NSString *baseUrl = [URLUtil getConnectionUrl];
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:urlString]]]];
	[request setDelegate:self];
	[request setShouldPresentAuthenticationDialog:FALSE];
	[request setDidFinishSelector:@selector(activitiesFetchComplete:)];
	[request setDidFailSelector:@selector(activitiesFetchFailed:)];
	[request startAsynchronous];
	
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My friend activities";
	listOfActivities = [[[NSMutableArray alloc] init] retain ];
	restUtil = [[[RestUtil alloc] init] retain ];
	[self startsGetActivities];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfActivities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	// Configure the cell.
	NSDictionary *activityItem = [listOfActivities objectAtIndex:indexPath.row];
	NSDictionary *ristoItem = [activityItem objectForKey:@"ristorante"];
	cell.textLabel.text = [ristoItem objectForKey:@"name"];
	NSString *city = [[ristoItem objectForKey:@"city"] objectForKey:@"name"];
	NSString *address = [ristoItem objectForKey:@"address"];
	
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", city, address]; ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *selectedRisto = [[listOfActivities objectAtIndex:indexPath.row] objectForKey:@"ristorante"];
    [self showRisto:selectedRisto animated:YES];
}

- (void)showRisto:(NSDictionary *)risto animated:(BOOL)animated {
	RistoViewController *detailViewController = [[RistoViewController alloc] initWithNibName:@"RistoView" bundle:[NSBundle mainBundle]];
	detailViewController.selectedRisto = risto;    
    [self.navigationController pushViewController:detailViewController animated:animated];
    [detailViewController release];
}

- (IBAction)activitiesFetchFailed:(ASIHTTPRequest *)theRequest
{
	//responseField.hidden = NO;
	//[responseField setText:@"Username and password not correct\nPlease retry."];
}

- (IBAction)activitiesFetchComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([request responseStatusCode] == 200);
	if(success){
		//retry the user info
		SBJSON *parser = [[SBJSON alloc] init];
		NSString *json_string = [[NSString alloc] initWithData:[theRequest responseData] encoding:NSUTF8StringEncoding];
		NSDictionary *statuses = [parser objectWithString:json_string error:nil];
		
		NSDictionary *ristoranteList = [statuses objectForKey:@"activityRistoranteList"];
		
		NSEnumerator *ristoranteEnum = [ristoranteList objectEnumerator];
		
		id object;
		while ((object = [ristoranteEnum nextObject])) {
			[listOfActivities addObject:object];
		}
		
		[self.tableView reloadData];
	}
	else{
		//todo
	}	
}	


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[tableViewActivities release];
	[restUtil release];
	[listOfActivities release];
	[request release];
    [super dealloc];
}

@end