//
//  TKLabelFieldCell.m
//  Created by Devin Ross on 7/2/09.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "TKLabelFieldCell.h"


@implementation TKLabelFieldCell
@synthesize field;



- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		field = [[UILabel alloc] initWithFrame:CGRectZero];
		[self addSubview:field];
		field.font = [UIFont boldSystemFontOfSize:16.0];
        field.clipsToBounds = YES;
        field.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
	
	CGRect r = CGRectInset(self.bounds, 16, 8);
	r.origin.x += 80;
	r.size.width -= 80;
	
	if(self.editing){
		r.origin.x += 30;
		r.size.width -= 30;
	}
	
	field.frame = r;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
	if(selected){
		field.textColor = [UIColor whiteColor];
	}else{
		field.textColor = [UIColor blackColor];
	}
	
}
- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
	[super setHighlighted:highlighted animated:animated];
	if(highlighted){
		field.textColor = [UIColor whiteColor];
	}else{
		field.textColor = [UIColor blackColor];
	}
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {

    if (action == @selector(copy:))
        return YES;
    
    if (action == @selector(append:))
        return YES;
    
    return NO;
}

- (void)showMenu {
    
    [self becomeFirstResponder];
    if ([[UIPasteboard generalPasteboard] string] != nil) {
        UIMenuItem *append = [[UIMenuItem alloc] initWithTitle:@"Append" action:@selector(append:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:append, nil]];
        [append release];
    }
    [[UIMenuController sharedMenuController] setTargetRect:CGRectZero inView:self];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

- (void)copy:(id)sender {
    
    [[UIPasteboard generalPasteboard] setString:field.text];
}

- (void)append:(id)sender {
    
    [[UIPasteboard generalPasteboard] setString:[[[UIPasteboard generalPasteboard] string] stringByAppendingFormat:@", %@", field.text]];
}

- (void)dealloc {
	[field release];
    [super dealloc];
}


@end
