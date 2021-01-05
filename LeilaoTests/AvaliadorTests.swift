//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Artur Rodrigues Fortunato on 04/01/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class AvaliadorTests: XCTestCase {
    
    var leiloeiro:Avaliador!
    private var joao:Usuario!
    private var maria:Usuario!
    private var jose:Usuario!

    override func setUpWithError() throws {
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        leiloeiro = Avaliador()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeveEntederLancesEmOrdemCrescente(){
        // Cenario
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))
        
        // Acao
        
 
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        XCTAssertEqual(250.00, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance(){
        
        let leilao = Leilao(descricao: "PlayStation 4")
        leilao.propoe(lance: Lance(joao, 1000.0))
        

        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances(){

        let leilao = CriadorDeLeilao().para(descricao: "Plasystation 4")
            .lance(joao, 300)
            .lance(maria, 400)
            .lance(joao, 500)
            .lance(maria, 600).constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        let listaLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaLances.count)
        XCTAssertEqual(600, listaLances[0].valor)
        XCTAssertEqual(500, listaLances[1].valor)
        XCTAssertEqual(400, listaLances[2].valor)
    }
    
    func testDeveIgnorarLeilaoSemNenhumLance(){
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4").constroi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possível avaliar leilão sem lances") { (error) in
            print(error.localizedDescription)
        }
    }
    
}
