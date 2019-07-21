import UIKit
import CropViewController

@objc class EditImageView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  weak var editImageViewController: ImageEditor?
  
  var config: NSDictionary = [:] {
    didSet {
      setNeedsLayout()
    }
  }
  
  var imageURL: URL? {
    if let url = config["imageURL"] as? String {
      return URL(fileURLWithPath: url)
    }
    return nil
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if editImageViewController == nil {
      embed()
    } else {
      editImageViewController?.view.frame = bounds
    }
  }
  
  private func embed() {
    guard
      let parentVC = parentViewController,
      let imageURL = imageURL else { return }
    
    do {
      if let image = try UIImage(data: Data(contentsOf: imageURL)) {
        let vc = ImageEditor.instantiate(with: image, imageConfirmed: nil)
        parentVC.addChild(vc)
        addSubview(vc.view)
        vc.view.frame = bounds
        vc.didMove(toParent: parentVC)
        self.editImageViewController = vc
      }
    } catch {
      print("image data not exists.")
    }
    
  }
}
