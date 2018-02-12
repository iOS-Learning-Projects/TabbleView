//
//  ViewController.swift
//  TabbleView
//
//  Created by Eduardo Vital Alencar Cunha on 15/05/17.
//  Copyright © 2017 Vital. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!

    var numbers: NSMutableArray = ["um", "dois", "três", "quatro", "cinco", "seis", "sete", "oito", "nove", "dez"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Adicionando um botão ao lado esquerdo para edição
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let newButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(ViewController.adicionar))

        self.navigationItem.rightBarButtonItem = newButton
    }

    func adicionar() {
        let alertController = UIAlertController(title: "Adicionar novo valor", message: "", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { alert -> Void in
            let texto = alertController.textFields![0] as UITextField

            if !(texto.text?.isEmpty)! {
                self.numbers.insert(texto.text!, at: 0)

                let indexPath: NSIndexPath = NSIndexPath.init(row: 0, section: 0)
                self.myTableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
            }

        }))

        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        alertController.addTextField(configurationHandler: {(textFiled: UITextField!) -> Void in
            textFiled.placeholder = "Digite um novo valor"
        })

        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// Implementing protocols of TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = numbers[indexPath.row] as? String

        return cell
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        self.myTableView.setEditing(editing, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            self.numbers.removeObject(at: indexPath.row)

            self.myTableView.deleteRows(at: [indexPath], with: .fade)

            self.myTableView.reloadData()

        }
    }

}
