//
//  CCWFixPWDViewController.m
//  CocosBCXWallet
//
//  Created by 邵银岭 on 2019/2/19.
//  Copyright © 2019年 邵银岭. All rights reserved.
//

#import "CCWFixPWDViewController.h"

@interface CCWFixPWDViewController ()

@property (weak, nonatomic) IBOutlet UILabel *pwdTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *currentPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *nowPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
@property (weak, nonatomic) IBOutlet UIButton *comlpleButton;

@end

@implementation CCWFixPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = CCWLocalizable(@"修改密码");
    
    self.comlpleButton.backgroundColor = CCWButtonBgColor;
    [self.nowPwdTextField addTarget:self action:@selector(textPwdChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textPwdChange:(UITextField *)textField
{
    self.pwdTipLabel.hidden = NO;
    if ([textField.text ys_regexValidate:@"^(?!^\\d+$)(?!^[A-Za-z]+$)(?!^[^A-Za-z0-9]+$)(?!^.*[\\u4E00-\\u9FA5].*$)^\\S{8,12}$"]) {
        self.pwdTipLabel.hidden = YES;
    }
}

- (IBAction)compleBtnClick:(UIButton *)sender {
    
    NSString *currentPwdStr = self.currentPwdTextField.text;
    NSString *nowPwdStr = self.nowPwdTextField.text;
    NSString *confirmPwdStr = self.confirmTextField.text;
    if (IsStrEmpty(currentPwdStr) || IsStrEmpty(nowPwdStr) || IsStrEmpty(confirmPwdStr)) {
        [self.view makeToast:CCWLocalizable(@"密码错误，请重新输入")];
        return;
    }
    
    if (![nowPwdStr isEqualToString:confirmPwdStr]) {
        [self.view makeToast:CCWLocalizable(@"密码前后输入不一致，请重新输入")];
        return;
    }
    
    if (![nowPwdStr ys_regexValidate:@"^(?!^\\d+$)(?!^[A-Za-z]+$)(?!^[^A-Za-z0-9]+$)(?!^.*[\\u4E00-\\u9FA5].*$)^\\S{8,12}$"]) {
        [self.view makeToast:CCWLocalizable(@"密码设置不符合规则，请重新输入")];
        return;
    }
    CCWWeakSelf
    [CCWSDKRequest CCW_ChangePassword:currentPwdStr newPassword:nowPwdStr Success:^(id  _Nonnull responseObject) {
        
        [weakSelf.view makeToast:CCWLocalizable(@"密码修改成功")];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } Error:^(NSString * _Nonnull errorAlert, id  _Nonnull responseObject) {
        NSString *code =  responseObject[@"code"];
        if ([code integerValue] == 113){
            [weakSelf.view makeToast:CCWLocalizable(@"密码错误，请重新输入")];
        }else{
            [weakSelf.view makeToast:CCWLocalizable(@"网络繁忙，请检查您的网络连接")];
        }
    }];
}


@end
