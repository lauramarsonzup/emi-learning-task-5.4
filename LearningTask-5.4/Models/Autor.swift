//
//  Autor.swift
//  LearningTask-5.4
//
//  Created by Laura Pinheiro Marson on 28/10/22.
//

import Foundation

struct Autor {
    let fotoURL: String
    let nome: String
    let sobrenome: String
    let bio: String
    let tecnologias: String
    
    var nomeCompleto: String {
        return nome + " " + sobrenome
    }
    
    init(fotoURL: String, nome: String, sobrenome: String, bio: String, tecnologias: String) {
        self.fotoURL = fotoURL
        self.nome = nome
        self.sobrenome = sobrenome
        self.bio = bio
        self.tecnologias = tecnologias
    }
}
