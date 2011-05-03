//
//  RKObjectMapping.m
//  RestKit
//
//  Created by Blake Watters on 4/30/11.
//  Copyright 2011 Two Toasters. All rights reserved.
//

#import "RKObjectMapping.h"

@implementation RKObjectMapping

@synthesize objectClass = _objectClass;
@synthesize mappings = _mappings;

+ (RKObjectMapping*)mappingForClass:(Class)objectClass {
    RKObjectMapping* mapping = [RKObjectMapping new];
    mapping.objectClass = objectClass;    
    return [mapping autorelease];
}

- (id)init {
    self = [super init];
    if (self) {
        _mappings = [NSMutableArray new];
    }
    
    return self;
}

- (void)dealloc {
    [_mappings release];
    [super dealloc];
}

- (NSArray*)mappedKeyPaths {
    return [_mappings valueForKey:@"destinationKeyPath"];
}

- (void)addAttributeMapping:(RKObjectAttributeMapping*)mapping {
    NSAssert1([[self mappedKeyPaths] containsObject:mapping.destinationKeyPath] == NO, @"Unable to add mapping for keyPath %@, one already exists...", mapping.destinationKeyPath);
    [_mappings addObject:mapping];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"RKObjectMapping class => %@: keyPath mappings => %@", NSStringFromClass(self.objectClass), _mappings];
}

- (RKObjectAttributeMapping*)mappingForKeyPath:(NSString*)keyPath {
    for (RKObjectAttributeMapping* mapping in _mappings) {
        if ([mapping.sourceKeyPath isEqualToString:keyPath]) {
            return mapping;
        }
    }
    
    return nil;
}

@end
