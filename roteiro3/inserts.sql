-- deve ser executado com sucesso
INSERT INTO farmacias VALUES(1, 'sede', 'bodocongo', 'campina grande', 'PB');

-- deve ser executado com sucesso
INSERT INTO farmacias VALUES(2, 'filial', 'alto branco', 'campina grande', 'PB');

-- deve falhar por so uma farmacia poder ser sede
INSERT INTO farmacias VALUES(3, 'sede', 'mangabeira', 'joao pessoa', 'PB');


-- devem ser executados com sucesso
INSERT INTO funcionarios VALUES('01234567890', 'farmaceutico', 1, false);
INSERT INTO funcionarios VALUES('01234567891', 'vendedor', 1, false);
INSERT INTO funcionarios VALUES('01234567892', 'entregador', 1, false);
INSERT INTO funcionarios VALUES('01234567893', 'caixa', 1, false);
INSERT INTO funcionarios VALUES('01234567894', 'administrador', 1, true);

-- deve falhar por um gerente ter que ser administrador ou farmaceutico
INSERT INTO funcionarios VALUES('01234567895', 'caixa', 2, true);

-- deve falhar por cada farmacia so poder ter um gerente
INSERT INTO funcionarios VALUES('01234567895', 'administrador', 1, true);

-- deve falhar por cpf de tamanho invalido
INSERT INTO funcionarios VALUES('0123456789', 'administrador', 1, false);

-- deve falhar por cpf ser repetido
INSERT INTO funcionarios VALUES('01234567893', 'caixa', 1, false);


-- devem ser executados com sucesso
INSERT INTO medicamentos VALUES(1, 'sem receita', 'dipirona', 'di-pi-ro-na', 20.57777);
INSERT INTO medicamentos VALUES(2, 'sem receita', 'dipirona2', 'di-pi-ro-na-2', 30.6);
INSERT INTO medicamentos VALUES(3, 'venda exclusiva', 'dipirona3', 'di-pi-ro-na-3', 30.8);

-- devem ser executados com sucesso
INSERT INTO clientes VALUES('00000000001', '1-1-1991');
INSERT INTO clientes VALUES('00000000002', '2-2-1992');
INSERT INTO clientes VALUES('00000000003', '3-3-1993');

-- devem falhar por cliente nao ter 18 anos
INSERT INTO clientes VALUES('00000000004', '3-3-2010');

-- devem ser executados com sucesso
INSERT INTO enderecos_do_cliente VALUES('a', 1, 'b', 'c', 'PB', '00000000', 'trabalho', '00000000001');
INSERT INTO enderecos_do_cliente VALUES('a', 1, 'b', 'c', 'PB', '00000001', 'residencia', '00000000002');
INSERT INTO enderecos_do_cliente VALUES('a', 1, 'b', 'c', 'PB', '00000002', 'residencia', '00000000003');
