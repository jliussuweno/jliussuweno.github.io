//
//  PortofolioViewController.m
//  Welmar
//
//  Created by jliussuweno on 26/11/20.
//

#import "PortofolioViewController.h"
#import "InboxViewController.h"
#import "AccountTableViewCell.h"

@interface PortofolioViewController ()
@property (weak, nonatomic) IBOutlet UITableView *accountTableView;
@end

@implementation PortofolioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountTableView.delegate = self;
    self.accountTableView.dataSource = self;
    self.accountTableView.scrollEnabled = NO;
    [self buildUrlRequestDeezer:@"Tulus"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
}

- (IBAction)inboxButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"InboxSegue" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    [NSArray arrayWithObjects: @"Reksa Dana", @"Reksa Dana", nil];
    NSArray *titleArray = @[@"Reksa Dana", @"Obligasi"];
    static NSString *CellIdentifier = @"cell";
    NSArray *arrData = [[NSBundle mainBundle]loadNibNamed:@"AccountTableViewCell" owner:nil options:nil];
    AccountTableViewCell *cell = [[AccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell = [arrData objectAtIndex:0];
    cell.titleLabel.text = titleArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

//func buildUrlRequestDeezer(artist: String?) -> URLRequest {
//    var urlString : String = "https://deezerdevs-deezer.p.rapidapi.com/search"
//    if artist != nil {
//        urlString = urlString + "?q=" + artist!
//    }
//
//    urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//    let url = URL.init(string: urlString)
//    var urlRequest : URLRequest = URLRequest(url: url!)
//    urlRequest.httpMethod = "GET"
//    urlRequest.addValue("deezerdevs-deezer.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
//    urlRequest.addValue("1aaf44486dmshce55c5a82a7edc9p188e0ajsn181bded96bb9", forHTTPHeaderField: "x-rapidapi-key")
//    urlRequest.timeoutInterval = 30
//    return urlRequest
//}

- (void)buildUrlRequestDeezer:(NSString *)artist {
    NSMutableString *urlString = @"https://deezerdevs-deezer.p.rapidapi.com/search";
    if (artist != nil) {
        urlString = [urlString stringByAppendingFormat:@"%@%@", @"?q=", artist];
        NSLog(@"%@", urlString);
    }
}


- (void) getDataFrom:(NSString *)url {
    NSString *targetUrl = [NSString stringWithFormat:@"%@/init", url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {

          NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"Data received: %@", myString);
    }] resume];
}

@end
