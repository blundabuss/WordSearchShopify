import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var bottomLineOutlet: UIImageView!
    @IBOutlet weak var shopifyMobileChalllengeOutlet: UIImageView!
    @IBOutlet weak var texturedBackGroundOutlet: UIImageView!
    @IBOutlet weak var shoppingBagOutlet: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func startBtnPressed(_ sender: Any) {
        startButtonOutlet.isEnabled = false;
                        UIView.animate(withDuration: 1.2,
                                       delay: 0.07,
                                       options: [.curveEaseIn],
                                       animations: {
                                        //https://stackoverflow.com/questions/23911468/moving-uiview-off-the-screen-from-left-to-right-and-bring-it-in-again-from-left
                                        //credit to Salman Zaidi for easy off frame solution for mult device
                                        self.bottomLineOutlet.center.y -=  self.view.frame.size.height
                                        self.shopifyMobileChalllengeOutlet.frame.origin.y -=  self.view.frame.size.height
                                        
                                        self.texturedBackGroundOutlet.frame.origin.y -=  self.view.frame.size.height + 30
                                        self.shoppingBagOutlet.frame.origin.y -=  self.view.frame.size.height + 10
                                        self.startButtonOutlet.frame.origin.y -=  self.view.frame.size.height + 10

                                        
                        }, completion: { finished in
                            
                            self.bottomLineOutlet.isHidden = true;
                            self.shopifyMobileChalllengeOutlet.isHidden = true;
                            self.texturedBackGroundOutlet.isHidden = true;
                            self.shoppingBagOutlet.isHidden = true;
                            
                            self.performSegue(withIdentifier: "collectionViewSegue", sender: self)
                            
                        })
        
                }

}
