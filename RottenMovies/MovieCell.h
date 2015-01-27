//
//  MovieCell.h
//  RottenMovies
//
//  Created by Sai Anudeep Machavarapu on 1/24/15.
//  Copyright (c) 2015 salome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *posterThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *mpaRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *criticScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tomatoImageView;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;

@end
