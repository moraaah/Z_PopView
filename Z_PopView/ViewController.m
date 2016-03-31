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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) Z_PopView *popView;
@property (nonatomic, assign) BOOL isSelected;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn.titleLabel addObserver:self forKeyPath:@"text" options:0 context:nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"1234567890" attributes:nil];
    ZTextAttachment *textAttachment = [[ZTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image = [UIImage imageNamed:@"good.jpg"];
    textAttachment.image = image;
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [string insertAttributedString:textAttachmentString atIndex:6];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 300, 100)];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor yellowColor];
    label.attributedText = string;
    [self.view addSubview:label];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
