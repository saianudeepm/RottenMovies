//
//  Movie.h
//  RottenMovies
//
//  Created by Sai Anudeep Machavarapu on 1/24/15.
//  Copyright (c) 2015 salome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject


@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSString *mpaaRating;
@property (nonatomic,strong) NSString *runtime;
@property (nonatomic,strong ) NSString *criticScore;
@property (nonatomic,strong) NSString *audienceScore;
@property (nonatomic,strong) NSURL *thumbnailURL;
@property (nonatomic,strong) NSURL *posterURL;
@property (nonatomic,strong) NSString *synopsis;

+(NSArray *) getMovieArray: (NSArray *) movieArray;

@end
