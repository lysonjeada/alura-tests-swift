//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Amaryllis Baldrez on 19/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class AvaliadorTests: XCTestCase {
    
    var leiloeiro: Avaliador!
    private var joao: Usuario!
    private var maria: Usuario!
    private var jose: Usuario!

    override func setUpWithError() throws {
        leiloeiro = Avaliador()
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
    }

    override func tearDownWithError() throws {
        
    }
    
    func testDeveEntenderLancesEmOrdemCrescente() {
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))
        
        // Acao
        
        let leiloeiro = Avaliador()
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance() {
        let joao = Usuario(nome: "Joao")
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(joao, 1000.0))
        
        let leiloeiro = Avaliador()
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances() {
       let leilao = CriadorDeLeilao().para(descricao: "Playstation 5")
            .lance(joao, 300.0)
            .lance(maria, 400.0)
            .lance(joao, 500.0)
            .lance(maria, 600.0)
            .constroi()
        
        let leiloeiro = Avaliador()
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaDeLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaDeLances.count)
        XCTAssertEqual(600.0, listaDeLances[0].valor)
        XCTAssertEqual(500.0, listaDeLances[1].valor)
        XCTAssertEqual(400.0, listaDeLances[2].valor)
    }
    
    func testDeveIgnorarLeilaoSemNenhumLance() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 5")
            .constroi()
        
        XCTAssertThrowsError(try? leiloeiro.avalia(leilao: leilao), "Não é possível avaliar um leilão sem lances") { error in
            print(error.localizedDescription)
        }
    }
}
