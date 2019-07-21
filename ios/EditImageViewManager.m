#import <UIKit/UIKit.h>
#import <React/RCTUIManager.h>
#import "photoCropExample-Swift.h"

@interface EditImageViewManager : RCTViewManager
@end

@implementation EditImageViewManager

RCT_EXPORT_MODULE()

- (UIView *)view {
  return [EditImageView new];
}

RCT_EXPORT_VIEW_PROPERTY(config, NSDictionary *)

@end
