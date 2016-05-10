//
//  ViewController.m
//  Z_PopView
//
//  Created by Lidear on 16/3/23.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "ViewController.h"
#import "Z_PopView.h"
#import "ZTextAttachment.h"
#import "UIView+LDExtention.h"
#import "UIButton+UIButtonImageWithLabel.h"

#define NSString(x) [NSString stringWithFormat:@"%ld",x]

@interface ViewController () <UITextFieldDelegate>
{
    UITextField *text;
    CGRect NaviRect;
    CGRect ViewRect;
    NSInteger index;
}
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) Z_PopView *popView;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIView *changeView; //改变大小的view
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    [self.btn.titleLabel addObserver:self forKeyPath:@"text" options:0 context:nil];
    [self.navigationController.navigationBar setTranslucent:NO];

    NaviRect = self.navigationController.navigationBar.frame;
    ViewRect = self.view.frame;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"1234567890" attributes:nil];
    ZTextAttachment *textAttachment = [[ZTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image = [UIImage imageNamed:@"good.jpg"];
    textAttachment.image = image;
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [string insertAttributedString:textAttachmentString atIndex:6];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 300, 100)];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor yellowColor];
    label.attributedText = string;
    label.layer.shadowColor = [UIColor grayColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(1, 1);
    label.layer.shadowOpacity = 1;
    label.layer.shadowRadius = 5;
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setFrame:CGRectMake(100, 100, 200, 50)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setText:@"测试"];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
//    [button.titleLabel setBackgroundColor:[UIColor redColor]];
//    [button setTitle:@"再测试" forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
    [button.imageView setImage:[UIImage imageNamed:@"person"]];
    [button setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    UITextField *textFD = [[UITextField alloc] initWithFrame:CGRectMake(100, 50, 120, 30)];
    textFD.placeholder = @"Input";
    textFD.delegate = self;
    textFD.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textFD];
    [self init_toolbar];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changeFrame:)];
    [self.view addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeToOriginalFrame:)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setImage:[UIImage imageNamed:@"person"] withTitle:@"person" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeViewFrame:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(100, 300, 200, 50)];
    [self.view addSubview:btn];
    
    _changeView = [[UIView alloc] initWithFrame:CGRectMake(10, 400, 100, 0)];
    _changeView.backgroundColor = [UIColor redColor];
    _changeView.alpha = 0.0;
    [self.view addSubview:_changeView];
    
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog(@"%@",currentLanguage);
    NSString *str = NSString(index);
    NSLog(@"%@",str);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"aaa" forKey:@1];
    NSLog(@"%@",dic);
    NSLog(@"%@",[dic objectForKey:@1]);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)changeViewFrame:(id)sender
{
    if (_changeView.frame.size.height == 0) { //展开
        CGRect rect = _changeView.frame;
        rect.size.height = 100;
        [UIView animateWithDuration:.5f animations:^{
            _changeView.frame = rect;
            _changeView.alpha = 1.0;
        }];
    } else { //收缩
        CGRect rect = _changeView.frame;
        rect.size.height = 0;
        [UIView animateWithDuration:.5f animations:^{
            _changeView.frame = rect;
            _changeView.alpha = .0;
        }];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
//    [self.btn setTitle:@"click" forState:UIControlStateNormal];
    
    return YES;
    
}

- (void)changeToOriginalFrame:(UITapGestureRecognizer *)tap
{
//    self.view.frame = ViewRect;
//    self.navigationController.navigationBar.frame = NaviRect;
}

- (void)changeFrame:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.view];
    self.view.frame = CGRectMake(self.view.viewX + point.x, self.view.viewY + point.y, self.view.viewWidth, self.view.viewHeight);
    [self.navigationController.navigationBar setFrame:CGRectMake(self.navigationController.navigationBar.viewX + point.x, self.navigationController.navigationBar.viewY + point.y, self.navigationController.navigationBar.viewWidth, self.navigationController.navigationBar.viewHeight)];
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)init_toolbar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(pushComment)];
    text = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = @"评论";
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:text];
    self.toolbarItems = @[item2,item];
}

- (void)pushComment
{
    [self.btn setTitle:text.text forState:UIControlStateNormal];
}

- (IBAction)btn:(id)sender {
    
    _isSelected = !_isSelected;
    __block typeof(self) weakSelf = self;
    if (!_popView) {
        _popView = [[Z_PopView alloc] initWithArray:@[@"男",@"女",@"儿童",@"老人"]];
        _popView.chooseBlock = ^(NSString *chooseItem) {
            _isSelected = NO;
            [weakSelf.btn setTitle:chooseItem forState:UIControlStateNormal];
        };
    }
    if (_isSelected) {
        [_popView showInView:self.view baseView:self.btn withPosition:ZShowRight];
    } else {
        [UIView animateWithDuration:.3 animations:^{
            [self.popView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.popView removeFromSuperview];
        }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"]) {
        NSLog(@"%@",[object text]);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    // 添加对键盘的监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setToolbarHidden:NO];
    [text becomeFirstResponder];
}

- (void)dealloc {
    
}

- (void)tapBackAction {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [text resignFirstResponder];
    [self tapBackAction];
}

- (void)keyBoardWillShow:(NSNotification *) note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self.navigationController setToolbarHidden:NO];
    text.text = @"";
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.navigationController.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyBoardHeight);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
}



- (void)keyBoardWillHide:(NSNotification *) note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.navigationController.toolbar.transform = CGAffineTransformIdentity;
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation completion:^(BOOL finished) {
            [self.navigationController setToolbarHidden:YES];
        }];
    } else {
        animation();
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
