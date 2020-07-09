import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    var catCount = 0
    var dogCount = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonCat: UIButton!
    @IBOutlet weak var buttonDog: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var inputText: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(ViewController.tapped_window(_:)))
            
            // デリゲートをセット
            tapGesture.delegate = self
            
            self.view.addGestureRecognizer(tapGesture)
        
            textView.text = "あああああ"
            label.text = "どっち?"
            buttonCat.setTitle("🐱", for: .normal)
            buttonDog.setTitle("🐶", for: .normal)
            let buttonSize = UIFont.systemFont(ofSize: 60)
            label.font = buttonSize
            buttonCat.titleLabel?.font = buttonSize
            buttonDog.titleLabel?.font = buttonSize
        }

    @IBAction func closeTextField(_ sender: UITextField) {
        textView.text = sender.text
    }
    
    @objc func tapped_window(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            print("タップ")
            textView.text = inputText.text
            inputText.endEditing(true)
        }
    }
    
    
    func tapped(model: Optional<String>, count: inout Int){
        guard let unwrapped = model else { return }
        count += 1
        label.text = "\(unwrapped)+\(count)"
    }
    @IBAction func tapCat(_ sender: Any) {
        tapped(model: buttonCat.currentTitle, count: &catCount)
        let realm = try! Realm()
        let human = Human()
        human.name = "田中"
        human.age  = 23
        human.sex  = "MALE"
        try! realm.write() {
            realm.add(human)
        }
        for num in realm.objects(Human.self){
            print(num)
        }
    }
    @IBAction func tapDog(_ sender: Any) {
        tapped(model: buttonDog.currentTitle, count: &dogCount)
        
        let realm = try! Realm()
        let results = realm.objects(Human.self).filter("name == '田中'")
        try! realm.write {
            realm.delete(results)
        }
        for num in realm.objects(Human.self){
            print(num)
        }
    }
}
