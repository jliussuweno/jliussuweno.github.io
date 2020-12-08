//
//  InboxViewController.m
//  Welmar
//
//  Created by jliussuweno on 30/11/20.
//

#import "InboxViewController.h"

@interface InboxViewController ()

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage
        imageNamed:@"Back"] style:UIBarButtonItemStylePlain target:nil
                                                                    action:nil];
    self.navigationController.navigationItem.backBarButtonItem = myBackButton;
//    [self hideTheTabBarWithAnimation:NO];
    [self.tabBarController.tabBar setHidden:YES];
    
//    self.hidesBottomBarWhenPushed = YES;
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    NSLog(@"Sampe sini");
}

- (void)viewDidDisappear:(BOOL)animated {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void) hideTheTabBarWithAnimation:(BOOL) withAnimation {
    if (NO == withAnimation) {
        [self.tabBarController.tabBar setHidden:YES];
    } else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:0.75];

        [self.tabBarController.tabBar  setAlpha:0.0];

        [UIView commitAnimations];
    }
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
