//
//  CustomAnnotationView.m
//  MKMapViewSample
//
//  Created by samayaaan on 12/09/16.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    self.image = [UIImage imageNamed:@"pin.png"];
    // 吹き出し有効
    self.canShowCallout = YES;
    return self;
}

@end
