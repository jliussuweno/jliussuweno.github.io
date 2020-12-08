//
//  ViewController.m
//  Welmar
//
//  Created by jliussuweno on 26/11/20.
//

#import "ViewController.h"
#import "PortofolioViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    PortofolioViewController *portVC = [[PortofolioViewController alloc]init];
//    [self.tabBarController presentViewController:portVC animated:YES completion:nil];
    self.tabBarController.moreNavigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.moreNavigationController.navigationBar.tintColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated {
    self.tabBarController.moreNavigationController.navigationBar.tintColor = [UIColor yellowColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
