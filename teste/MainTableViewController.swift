//
//  MainTableViewController.swift
//  teste
//
//  Created by Guilherme Farias on 22/04/17.
//  Copyright © 2017 Guilherme Farias. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    struct Tarefas {
        var listaFeitos : [(String, String)] = []
        var listaPorFazer: [(String, String)] = []
    }
    
    var minhasTarefas = Tarefas()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Minhas Tarefas"
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(MainTableViewController.addTarefa))
    }

  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
          return self.minhasTarefas.listaPorFazer.count
        } else {
            return self.minhasTarefas.listaFeitos.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Por fazer"
        } else {
            return "Feitos"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTarefa", for: indexPath)

        if indexPath.section == 0 {
            cell.textLabel?.text = self.minhasTarefas.listaPorFazer[indexPath.row].0
            cell.detailTextLabel?.text = self.minhasTarefas.listaPorFazer[indexPath.row].1
        } else {
            cell.textLabel?.text = self.minhasTarefas.listaFeitos[indexPath.row].0
            cell.detailTextLabel?.text = self.minhasTarefas.listaFeitos[indexPath.row].1
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let removido = self.minhasTarefas.listaPorFazer.remove(at: indexPath.row)
            self.minhasTarefas.listaFeitos.append(removido)
        } else {
            let removido = self.minhasTarefas.listaFeitos.remove(at: indexPath.row)
            self.minhasTarefas.listaPorFazer.append(removido)
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            if indexPath.section == 0 {
                self.minhasTarefas.listaPorFazer.remove(at: indexPath.row)
            } else {
               self.minhasTarefas.listaFeitos.remove(at: indexPath.row)
            }
        }

        self.tableView.reloadData()
    }

    func addTarefa(){
        let meuAlerta = UIAlertController(title: "Nova Tarefa", message: "Insira um título e uma descrição nos campos abaixo.", preferredStyle: UIAlertControllerStyle.alert)
        let confirmaAction = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.default) { (alert) in
            if let titulo = (meuAlerta.textFields![0] as UITextField).text {
                let desc = (meuAlerta.textFields![1] as UITextField).text ?? ""
                
                self.minhasTarefas.listaPorFazer.append(titulo, desc)
                self.tableView.reloadData()            }
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: nil)
        
        
        meuAlerta.addTextField { (textField) in
            textField.placeholder = "Digite o titulo aqui"
        }
        meuAlerta.addTextField { (textField) in
            textField.placeholder = "Digite a descrição aqui"
        }
        meuAlerta.addAction(confirmaAction)
        meuAlerta.addAction(cancelAction)
        self.present(meuAlerta, animated: true, completion: nil)
    }

}
