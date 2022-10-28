//
//  ViewController.swift
//  LearningTask-5.4
//
//  Created by rafael.rollo on 09/03/2022.
//

import UIKit

class AutorFormViewController: UIViewController {
    
    typealias MensagemDeErro = String

    @IBOutlet weak var fotoTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var tecnologiasTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func botaoSalvarPressionado(_ sender: UIButton) {
        
        switch camposForamPreenchidos() {
            
        case (false, let mensagem):
            exibeAlerta(titulo: "Erro", mensagem: mensagem)
        
        default:
            cadastrarAutor()
        }
        
    }
    
    func nomeDeAutorValido(_ nome: String) -> Bool {
        let pattern = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: nome)
    }
    
    func formata(nomeDeAutor: String) -> (String, String) {
        let separador = " "
        let nomeCompleto = nomeDeAutor.components(separatedBy: separador)
        return (nomeCompleto.first!, nomeCompleto.dropFirst().joined(separator: separador))
    }
    
    func camposForamPreenchidos() -> (Bool, MensagemDeErro?) {
        guard let foto = fotoTextField.text, !foto.isEmpty else {
            return (false, "O campo Foto não pode estar em branco.")
        }
        
        guard let nome = nomeTextField.text, !nome.isEmpty else {
            return (false, "O campo Nome não pode estar em branco.")
        }
        
        guard nomeDeAutorValido(nome) else {
            return (false, "Digite um nome válido.")
        }
        
        guard let bio = bioTextField.text, !bio.isEmpty else {
            return (false, "O campo Bio não pode estar em branco.")
        }
        
        guard let tecnologias = tecnologiasTextField.text, !tecnologias.isEmpty else {
            return (false, "O campo Tecnologias não pode estar em branco.")
        }
        
        return (true, nil)
    }
    
    func cadastrarAutor() {
        let (nome, sobrenome) = formata(nomeDeAutor: nomeTextField.text!)
        
        let autor = Autor(fotoURL: fotoTextField.text!,
                          nome: nome,
                          sobrenome: sobrenome,
                          bio: bioTextField.text!,
                          tecnologias: tecnologiasTextField.text!)
        
        AutorRepository.salva(autor)
        
        exibeAlerta(titulo: "Concluído", mensagem: "Autor cadastrado com sucesso.")
    }
    
    func exibeAlerta(titulo: String, mensagem: MensagemDeErro?) {
        let alerta = UIAlertController(title: titulo, message: mensagem ?? "Algo deu errado, tente novamente.", preferredStyle: .alert)
        
        alerta.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        present(alerta, animated: true)
    }

}
