//
//  ViewController.h
//  Welmar
//
//  Created by jliussuweno on 25/11/20.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *slideImageCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIStackView *userIDStackView;
@property (weak, nonatomic) IBOutlet UIStackView *passwordStackVIew;
@property (weak, nonatomic) IBOutlet UIStackView *stack1;
@property (weak, nonatomic) IBOutlet UIStackView *stack2;


@end

