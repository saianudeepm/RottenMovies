//
//  MovieDetailedViewController.m
//  RottenMovies
//
//  Created by Sai Anudeep Machavarapu on 1/24/15.
//  Copyright (c) 2015 salome. All rights reserved.
//

#import "MovieDetailedViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailedViewController ()

@end

@implementation MovieDetailedViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self    = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self loadView];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = YES;

    //setting the scrollview
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.pagingEnabled = YES;
   
    //to make the synopsis label height set depending on the content
    /*
     CGSize maxSize = CGSizeMake(296.f, FLT_MAX);
    CGRect labRect = [self.selectedMovie.synopsis boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.synopsisLabel.font} context:nil];
    
    self.synopsisLabel.frame = CGRectMake(0, 0, maxSize.width, labRect.size.height);
    self.synopsisLabel.text = self.selectedMovie.synopsis;
     */
    

    
    //set the movie detailed view data.
    Movie *selectedMovie = self.selectedMovie;
    [self setMovieDetailedView:selectedMovie];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setMovieDetailedView:(Movie*)selectedMovie{

    //set the current views data
    self.titleLabel.text = selectedMovie.title;
    self.criticScoreLabel.text =  [NSString stringWithFormat:@"Critic Score: %@%%",selectedMovie.criticScore] ;
    self.audienceScoreLabel.text= [NSString stringWithFormat:@"Audience Score: %@%%",selectedMovie.audienceScore];
    self.ratingLabel.text = selectedMovie.mpaaRating;
    self.synopsisLabel.text = selectedMovie.synopsis;
    //[self.posterImageView setImageWithURL:selectedMovie.thumbnailURL ];
    UIImage *placeHolderImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:selectedMovie.thumbnailURL]];
    [self.posterImageView setImageWithURL:selectedMovie.posterURL placeholderImage:placeHolderImage ];

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.x != 0) {
        [scrollView setContentOffset:CGPointMake(0, offset.y)];
    }
}

@end
