//
//  MovieDetailedViewController.h
//  RottenMovies
//
//  Created by Sai Anudeep Machavarapu on 1/24/15.
//  Copyright (c) 2015 salome. All rights reserved.
//

#import <UIKit/UIKit.h>
# import "Movie.h"

@interface MovieDetailedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *criticScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *audienceScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (strong,nonatomic) Movie *selectedMovie;

@end
