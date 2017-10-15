//
//  ViewController.swift
//  Todo
//
//  Created by Legendary Wicho on 10/15/17.
//  Copyright © 2017 Luis Santiago. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId";
    var task:[String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white;
        navigationItem.title = "My todo list";
        tableView.register(TaskCell.self, forCellReuseIdentifier: cellId);
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target:self,action: #selector(handleAdd));
        
        navigationItem.rightBarButtonItem = button;
        
        self.task.append("Wash the dishes");
        self.task.append("Clean the bathroom");
        self.task.append("Clean your room");
    }
    
    @objc func handleAdd(){
        let alertControler = UIAlertController(title: "Add new Task", message: "", preferredStyle: UIAlertControllerStyle.alert);
        
        let saveAction = UIAlertAction(title : "Add", style : UIAlertActionStyle.default,
           handler:{action ->Void in
            let taskNameTextField = (alertControler.textFields?[0])! as UITextField;
            self.task.append(taskNameTextField.text!);
            self.tableView.reloadData();
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default){
            (action)->Void in
            
        }
        
        alertControler.addTextField { (textfield: UITextField) in
            textfield.placeholder = "Task name";
        }
        
        alertControler.addAction(saveAction);
        alertControler.addAction(cancelAction);
        present(alertControler, animated: true, completion: nil);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.task.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TaskCell;
        
        cell.label.text = self.task[indexPath.item];
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            self.task.remove(at: indexPath.item);
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left);
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Done and delete";
    }
    
}

class TaskCell : UITableViewCell{
    let label : UILabel = {
        let label = UILabel();
        label.text = "My task";
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setUpViews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        addSubview(label);
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":label]));
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":label]));
    }
}

