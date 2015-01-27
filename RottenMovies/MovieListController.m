//
//  MovieListController.m
//  RottenMovies
//
//  Created by Sai Anudeep Machavarapu on 1/24/15.
//  Copyright (c) 2015 salome. All rights reserved.
//

#import "MovieListController.h"
#import "MovieCell.h"
#import "MovieDetailedViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"
#import "SVProgressHUD.h"
#import "ErrorBarCell.h"

@interface MovieListController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) NSArray *movieList;
@property (nonatomic,strong) NSString *currentSelection;
@property (weak, nonatomic) IBOutlet UILabel *networkErrorLabel;

-(void) loadMoviesinfo: (NSString *) type;
@end

@implementation MovieListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** Additional setup after loading the view from its nib.
        
        We can assign the datasource and delegate here or we can do it in the .xib file
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    **/
    
    //Set up the refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

    
    //Register the movie cell nib
    UINib *nib = [UINib nibWithNibName:@"ErrorBarCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"ErrorBarCell"];
    
     nib = [UINib nibWithNibName:@"MovieCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"MovieCell"];

    //load the movies list
    self.currentSelection = @"box_office";
    [self loadMoviesinfo:self.currentSelection];
    
    //styling
    self.tableView.rowHeight=90;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadMoviesinfo:(NSString *) type {
    NSString *api_key=@"jfpxh9smg2rxw5k9vr2tezbw";
    NSInteger limit=50;
   
    [SVProgressHUD showWithStatus:@"Loading!"];
    //Async Request for the API
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=%@&limit=%ld",api_key,limit];
    NSURL *apiURL= [NSURL URLWithString:urlString];
    NSURLRequest *apiRequest  = [[NSURLRequest alloc] initWithURL:apiURL];
    
    [NSURLConnection sendAsynchronousRequest:apiRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError) {
            self.movieList=nil;
            NSLog(@"Reloading data into tableview");
            [self.tableView reloadData];
            //[self.networkErrorLabel setHidden:NO];
            [SVProgressHUD dismiss];
        }
        
        else {
            [SVProgressHUD dismiss];
            NSDictionary *apiResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *moviesArray = [apiResponse valueForKey:@"movies"];
            self.movieList = [Movie getMovieArray: moviesArray];
            [self.tableView reloadData];
            NSLog(@"Reloading data into tableview");
        }
        
    }];
    
}//loadMoviesinfo

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 * Methods needed to be implemented for being the data source
 **/


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"total rows found is : %ld",self.movieList.count);
    if(self.movieList==nil)
        return 1;
    else
        return self.movieList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellforRowAtIndexPath called for %ld",indexPath.row);
    
    if (self.movieList!=nil) {
        MovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
        Movie *currentMovie = [self.movieList objectAtIndex:indexPath.row];
        movieCell.movieTitle.text = currentMovie.title;
        [movieCell.posterThumbnail setImageWithURL:currentMovie.thumbnailURL];
        movieCell.mpaRatingLabel.text = currentMovie.mpaaRating;
        NSLog(@"critic score is -- %@",currentMovie.criticScore);
        movieCell.criticScoreLabel.text= [NSString stringWithFormat:@"%@%%",currentMovie.criticScore];
        [movieCell.tomatoImageView setImage:[UIImage imageNamed:@"tomatoImg"]];
        
        //formatting the run time
        int hours= [currentMovie.runtime intValue] / 60;
        int minutes = [currentMovie.runtime intValue] % 60;
        
        if(minutes!=0){
            movieCell.runtimeLabel.text = [NSString stringWithFormat:@"%dh %dm",hours,minutes];
        }
        else{
            movieCell.runtimeLabel.text = [NSString stringWithFormat:@"%dh ",hours];
        }
        return movieCell;
    }
    
    //return error bar cell if there is a network error
    else{
        
        ErrorBarCell *errorBarCell = [tableView dequeueReusableCellWithIdentifier:@"ErrorBarCell" forIndexPath:indexPath];
        return errorBarCell;
    }
    /*To set accessory type - its just an indicator for user that theres more content on click*/
    //UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //[movieCell setAccessoryType:accessoryType];
}

// takes to movie detailed view
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // go to detailed page view on touch of cell only when no network error
    if (self.movieList!=nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MovieDetailedViewController *mvc = [[MovieDetailedViewController alloc] init];
        Movie *selectedMovie = [self.movieList objectAtIndex:indexPath.row];
        [mvc setSelectedMovie:selectedMovie];
        [self.navigationController pushViewController:mvc animated:YES];
    }
    
}

// when the uirefresh control is used, this method gets invoked. we need to call endRefreshing to stop it
- (void)onRefresh {
    [self loadMoviesinfo:self.currentSelection];
    [self.refreshControl endRefreshing];
}

@end
