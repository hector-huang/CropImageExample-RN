import UIKit
import CropViewController

class ImageEditor: UIViewController {
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var useButton: UIButton!
    @IBOutlet var buttonContainerWidthExpanded: NSLayoutConstraint!
    @IBOutlet var buttonContainerWidthCollapsed: NSLayoutConstraint!
    
    var image: UIImage!
    var cropImageViewController: CropViewController?
    var imageConfirmed: ((UIImage) -> Void)?
    
    internal static func instantiate(with image: UIImage, imageConfirmed: ((UIImage) -> Void)?) -> ImageEditor {
        let vc = ImageEditor(nibName: "ImageEditor", bundle: nil)
        vc.image = image
        vc.imageConfirmed = imageConfirmed
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cropImageVC = CropViewController(image: image)
        cropImageVC.hidesNavigationBar = false
        cropImageVC.toolBoxHidden = true
        self.cropImageViewController = cropImageVC
        
        self.addChild(cropImageVC)
        cropImageVC.view.frame = imageContainer.bounds
        self.imageContainer.addSubview(cropImageVC.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.buttonContainerWidthExpanded?.isActive = true
            self?.buttonContainerWidthCollapsed?.isActive = false
            self?.view.layoutIfNeeded()
        })
    }
    
    @IBAction func usePhoto() {
        cropImageViewController?.finishCroppingImageWithCompletion(completion: { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageConfirmed?(image)
                self.cancel()
            }
        })
    }
    
    @IBAction func cancel() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.buttonContainerWidthExpanded.isActive = false
            self?.buttonContainerWidthCollapsed.isActive = true
            
            self?.view.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseOut, animations: { [weak self] in
            self?.view.alpha = 0
            }, completion: { [weak self] _ in
                self?.view.removeFromSuperview()
                self?.removeFromParent()
        })
    }
}
