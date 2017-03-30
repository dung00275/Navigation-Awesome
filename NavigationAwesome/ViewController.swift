//
//  ViewController.swift
//  NavigationAwesome
//
//  Created by dungvh on 11/11/15.
//  Copyright © 2015 dungvh. All rights reserved.
//

import UIKit

let NAVBAR_CHANGE_POINT:CGFloat = 50
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
//        self.scrollViewDidScroll(self.tableView)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.lt_reset()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

extension ViewController{
    func setNavigationBarTransformProgress(_ progress:CGFloat){
        self.navigationController?.navigationBar.lt_setTranslationY(-44 * progress)
        self.navigationController?.navigationBar.lt_setElementsAlpha(1 - progress)
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else{
            let newCell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            newCell.textLabel?.text = "Cell at : \(indexPath.row)"
            return newCell
        }
        
        cell.textLabel?.text = "Cell at : \(indexPath.row)"
        return cell;

    }
}

extension ViewController:UIScrollViewDelegate{
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let color = UIColor(red: 0/255, green: 175/255, blue: 240/255, alpha: 1)
//        let offsetY = scrollView.contentOffset.y
//        
//        if offsetY > NAVBAR_CHANGE_POINT{
//            let alpha = min(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64))
//            self.navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(alpha))
//        }else{
//            self.navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(0))
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > 0{
            if offsetY >= 44{
                self.setNavigationBarTransformProgress(1)
            }else{
                self.setNavigationBarTransformProgress(offsetY/44)
            }
        }else{
            self.setNavigationBarTransformProgress(0)
            self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        }
    }
}

