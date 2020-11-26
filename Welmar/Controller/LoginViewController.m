//
//  ViewController.m
//  Welmar
//
//  Created by jliussuweno on 25/11/20.
//

#import "LoginViewController.h"
#import "CollectionViewCell.h"
#import "UIViewController+Alerts.h"
#import "ViewController.h"
@import Firebase;

#import <CommonCrypto/CommonDigest.h>
#import <GameKit/GameKit.h>

@import AuthenticationServices;

@interface LoginViewController ()

@end

@implementation LoginViewController {
    NSMutableArray *imagesArray;
    int currentIndex;
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    imagesArray = [[NSMutableArray alloc]init];
    NSData * imageData1 = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"https://picsum.photos/id/0/5616/3744"]];
    UIImage *img1 = [UIImage imageWithData: imageData1];
    NSData * imageData2 = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"https://picsum.photos/id/1/5616/3744"]];
    UIImage *img2 = [UIImage imageWithData: imageData2];
    NSData * imageData3 = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"https://picsum.photos/id/10/2500/1667"]];
    UIImage *img3 = [UIImage imageWithData: imageData3];
    
    [imagesArray addObject:img1];
    [imagesArray addObject:img2];
    [imagesArray addObject:img3];
    _slideImageCollectionView.delegate = self;
    _slideImageCollectionView.dataSource = self;
    _pageIndicator.numberOfPages = imagesArray.count;
    [self startTimerThread];
    
    _loginButton.layer.cornerRadius = 10;
    
    [_registerButton.layer setBorderWidth:1.0];
    [_registerButton.layer setBorderColor:[[UIColor systemTealColor] CGColor]];
    _registerButton.layer.cornerRadius = 10;
    
}
- (IBAction)loginButtonPressed:(id)sender {
    [self showSpinner:^{
        // [START headless_email_auth]
        [[FIRAuth auth] signInWithEmail:self->_emailTextField.text
                               password:self->_passwordTextField.text
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
            // [START_EXCLUDE]
            [self hideSpinner:^{
                if (error && error.code == FIRAuthErrorCodeSecondFactorRequired) {
                    FIRMultiFactorResolver *resolver = error.userInfo[FIRAuthErrorUserInfoMultiFactorResolverKey];
                    NSMutableString *displayNameString = [NSMutableString string];
                    for (FIRMultiFactorInfo *tmpFactorInfo in resolver.hints) {
                        [displayNameString appendString:tmpFactorInfo.displayName];
                        [displayNameString appendString:@" "];
                    }
                    [self showTextInputPromptWithMessage:[NSString stringWithFormat:@"Select factor to sign in\n%@", displayNameString]
                                         completionBlock:^(BOOL userPressedOK, NSString *_Nullable displayName) {
                        FIRPhoneMultiFactorInfo* selectedHint;
                        for (FIRMultiFactorInfo *tmpFactorInfo in resolver.hints) {
                            if ([displayName isEqualToString:tmpFactorInfo.displayName]) {
                                selectedHint = (FIRPhoneMultiFactorInfo *)tmpFactorInfo;
                            }
                        }
                        [FIRPhoneAuthProvider.provider
                         verifyPhoneNumberWithMultiFactorInfo:selectedHint
                         UIDelegate:nil
                         multiFactorSession:resolver.session
                         completion:^(NSString * _Nullable verificationID, NSError * _Nullable error) {
                            if (error) {
                                NSLog(@"Multi factor start sign in failed. Error: %@", error.description);
                            } else {
                                [self showTextInputPromptWithMessage:[NSString stringWithFormat:@"Verification code for %@", selectedHint.displayName]
                                                     completionBlock:^(BOOL userPressedOK, NSString *_Nullable verificationCode) {
                                    FIRPhoneAuthCredential *credential =
                                    [[FIRPhoneAuthProvider provider] credentialWithVerificationID:verificationID
                                                                                 verificationCode:verificationCode];
                                    FIRMultiFactorAssertion *assertion = [FIRPhoneMultiFactorGenerator assertionWithCredential:credential];
                                    [resolver resolveSignInWithAssertion:assertion completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                                        if (error) {
                                            NSLog(@"Multi factor finanlize sign in failed. Error: %@", error.description);
                                        }
//                                        else {
//                                            NSLog(@"Masuk sini");
//                                            PortofolioViewController *portVC = [[PortofolioViewController alloc]init];
//                                            portVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
//                                            [self.navigationController presentViewController:portVC animated:YES completion:nil];
//                                        }
                                    }];
                                }];
                            }
                        }];
                    }];
                } else if (error) {
                    [self showMessagePrompt:error.localizedDescription];
                    return;
                } else {
                    [self showMessagePromptLogin:@"Success"];
                }
                //          [self.navigationController popViewControllerAnimated:YES];
            }];
            
            // [END_EXCLUDE]
        }];
        // [END headless_email_auth]
    }];
}


- (void)showMessagePromptLogin:(NSString *)message {
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:nil
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:
       ^(UIAlertAction * action) {
          
          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
          UITabBarController *tabObj = (ViewController*) [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
          
//          self.window.rootViewController = tabObj;
          
          ViewController *tabBarVC = [[ViewController alloc]init];
          tabObj.modalPresentationStyle = UIModalPresentationOverFullScreen;
          [self.navigationController presentViewController:tabObj animated:YES completion:nil];
               }
           ];
  [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion: nil];
}

- (void)startTimerThread {
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction {
    int desiredScrollPosition = (currentIndex < imagesArray.count - 1) ? currentIndex + 1 : 0;
    [_slideImageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:desiredScrollPosition inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:TRUE];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"slideShowCell" forIndexPath:indexPath];
    cell.slideImage.image = imagesArray[indexPath.row];
    cell.slideImage.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imagesArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    currentIndex = scrollView.contentOffset.x / _slideImageCollectionView.frame.size.width;
    _pageIndicator.currentPage = currentIndex;
}




@end
