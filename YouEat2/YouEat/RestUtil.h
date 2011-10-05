//
//  RestUtil.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON/SBJSON.h"

@protocol YRestUtilDelegate

/**
 @brief Called when a JSON object is received and parsed
 
 This method is called when a JSON object is received and parsed
 */
- (void)responseParsed: (NSArray*)array;

@end


@interface RestUtil : NSObject <SBJsonStreamParserAdapterDelegate>{
	
	NSString *connectionURL;

@private
    SBJsonParser *_parser;
    SBJsonWriter *_writer;
    SBJsonStreamParser *_streamParser;
    SBJsonStreamParserAdapter *_adapter;
    id<YRestUtilDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet NSString *connectionURL;
@property (nonatomic, assign) id<YRestUtilDelegate> delegate;

- (void) sendRestRequest:(NSString*)url;

@end
