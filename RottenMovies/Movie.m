//
//  Movie.m
//  RottenMovies
//
//  Created by Sai Anudeep Machavarapu on 1/24/15.
//  Copyright (c) 2015 salome. All rights reserved.
//

#import "Movie.h"

@interface Movie ()
-(instancetype) initWithDictionary:(NSDictionary *) movieDict;

@end

@implementation Movie

-(instancetype) initWithDictionary:(NSDictionary *) movieDict{

    self.title = [NSString stringWithFormat:@"%@",[movieDict valueForKey:@"title"]];
    self.year =  [NSString stringWithFormat:@"%@",[movieDict valueForKey:@"year"]];
    self.mpaaRating = [NSString stringWithFormat:@"%@",movieDict [@"mpaa_rating"]];
    self.runtime = [NSString stringWithFormat:@"%@",movieDict [@"runtime"]];
    self.criticScore = [NSString stringWithFormat:@"%@", movieDict[@"ratings"][@"critics_score"]];
    self.audienceScore = [NSString stringWithFormat:@"%@",movieDict[@"ratings"][@"audience_score"]];
    self.thumbnailURL = [NSURL URLWithString:movieDict[@"posters"][@"thumbnail"]];
    self.posterURL = [NSURL URLWithString:
                      [movieDict[@"posters"][@"original"] stringByReplacingOccurrencesOfString:@"tmb" withString:@"org"]
                      ];
    self.synopsis = [NSString stringWithFormat:@"%@",movieDict [@"synopsis"]];
    return self;
}

// returns an Array of Movie Objects from Movie Json Array
+(NSArray *) getMovieArray: (NSArray *) movieArray{

    NSMutableArray *movieList = [[NSMutableArray alloc] init];
    for (NSDictionary *movieDict in movieArray) {
        Movie *movie = [[Movie alloc]initWithDictionary:movieDict];
        [movieList addObject:movie];
    }
    
    return movieList;
}


@end
