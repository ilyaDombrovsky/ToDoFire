//
//  TasksViewController.swift
//  ToDoFire
//
//  Created by Ilya Dombrovsky on 2.07.22.
//

import UIKit
import Firebase

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    var user: User!
    var ref: DatabaseReference!
    var tasks = [Task]()
    
    
    
@IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "This is cell number \(indexPath.row )"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "New task", message: "Add new task", preferredStyle: .alert)
        ac.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) {[weak self] _ in
            guard let textField = ac.textFields?.first, textField.text != "" else { return }
            let task = Task(title: textField.text!, userID: (self?.user.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(task.convertToDictionary())
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addAction(save)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func signOutTaped(_ sender: UIBarButtonItem) {
        do {
       try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
}
