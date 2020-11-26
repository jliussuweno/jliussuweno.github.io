//
//  RegisterViewController.m
//  Welmar
//
//  Created by jliussuweno on 25/11/20.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "UIViewController+Alerts.h"
@import Firebase;

@interface RegisterViewController ()
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)registerButtonPressed:(id)sender {
    NSString *name = _nameTextField.text;
    NSString *email = _emailTextField.text;
    NSString *userID = _userIDTextField.text;
    NSString *password = _passwordTextField.text;
    NSString *confirmPassword = _confirmPasswordTextField.text;
    
    if ([name length] == 0) {
        [self showMessagePrompt:@"Nama harus diisi."];
    } else if ([email length] == 0){
        [self showMessagePrompt:@"Email harus diisi."];
    } else if ([userID length] == 0){
        [self showMessagePrompt:@"BCA ID harus diisi."];
    } else if ([password length] == 0){
        [self showMessagePrompt:@"Password harus diisi."];
    } else if ([confirmPassword length] == 0) {
        [self showMessagePrompt:@"Ulangi Password harus diisi."];
    } else if (![password isEqualToString:confirmPassword]) {
        [self showMessagePrompt:@"Password dan Ulangi Password harus sama."];
    } else {
        [self showSpinner:^{
            [[FIRAuth auth] createUserWithEmail:email
                                       password:password
                                     completion:^(FIRAuthDataResult * _Nullable authResult,
                                                  NSError * _Nullable error) {
                // [START_EXCLUDE]
                [self hideSpinner:^{
                    if (error) {
                        [self showMessagePrompt: error.localizedDescription];
                        return;
                    }
                    [self showMessagePromptRegister:@"Berhasil, Silahkan Login!"];
                }];
                // [END_EXCLUDE]
            }];
            // [END create_user]
        }];
    }
    
}

- (void)showMessagePromptRegister:(NSString *)message {
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:nil
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:
       ^(UIAlertAction * action) {
          [self.navigationController popViewControllerAnimated:YES];
               }
           ];
  [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion: nil];
}


- (IBAction)loginButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
