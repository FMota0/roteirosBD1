CREATE TYPE tipo_farmacia AS ENUM ('filial', 'sede');

CREATE TYPE tipo_funcionario AS ENUM
('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador');

CREATE TYPE tipo_endereco AS ENUM
('residencia', 'trabalho', 'outro');

CREATE TYPE estado_nordeste AS ENUM
('AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE');

CREATE TYPE caracteristica_medicamento AS ENUM
('venda exlusiva', 'receita');

CREATE TABLE farmacias (

    identificador serial,

    tipo tipo_farmacia,

    bairro text,

    cidade text,

    estado estado_nordeste,

    -- definindo primary key
    CONSTRAINT farmacia_pkey
    PRIMARY KEY (identificador),

    -- garantindo que so haja uma sede
    CONSTRAINT tipo_excl
    EXCLUDE USING gist (
        identificador WITH =
    ) WHERE(tipo = 'sede'),

    -- garantindo que so haja uma farmacia por bairro
    CONSTRAINT bairro_uniq
    UNIQUE(bairro)
);

CREATE TABLE funcionarios (

    cpf varchar(11),

    tipo tipo_funcionario,

    farmacia_onde_trabalha integer,

    eh_gerente boolean,

    -- referenciando farmacia
    CONSTRAINT farmacia_fkey
    FOREIGN KEY (farmacia_onde_trabalha)
    REFERENCES farmacias(identificador),

    -- garantindo que so haja um gerente por farmacia
    CONSTRAINT gerent_excl
    EXCLUDE USING gist (
        farmacia_onde_trabalha WITH =
    ) WHERE (eh_gerente = true),

    -- garantindo que gerente seja farmaceutico ou administrador
    CONSTRAINT gerente_valido_chk
    CHECK((not eh_gerente) or (eh_gerente and (tipo = 'farmaceutico' or tipo = 'administrador'))),

    -- definindo primary key
    CONSTRAINT funcionario_pkey
    PRIMARY KEY (cpf),

    -- verificando o tamanho correto do cpf
    CONSTRAINT cpf_sz_chk
    CHECK(LENGTH(cpf) = 11),

    -- definindo tupla (cpf, tipo) como uma chave unica ja que contem cpf
    CONSTRAINT cpf_tipo_uniq
    UNIQUE(cpf, tipo)
);

CREATE TABLE medicamentos (

    identificador serial,

    caracteristica caracteristica_medicamento,

    nome text,

    descricao text,

    preco real,

    -- definindo primary key
    CONSTRAINT medicamentos_pkey
    PRIMARY KEY (identificador)

);

CREATE TABLE vendas (

    cpf_funcionario varchar(11),

    tipo_do_funcionario tipo_funcionario,

    -- referenciando funcionario
    CONSTRAINT funcionarios_fkey
    FOREIGN KEY (cpf_funcionario, tipo_do_funcionario)
    REFERENCES funcionarios(cpf, tipo),

    -- verificando validade do funcionario que fez a venda
    CONSTRAINT tipo_funcionario_chk
    CHECK (tipo_do_funcionario = 'vendedor')
);

CREATE TABLE entregas (

);

CREATE TABLE clientes (

    cpf varchar(11),

    data_nasc timestamp,

    -- verificando o tamanho correto do cpf
    CONSTRAINT cpf_sz_chk
    CHECK(LENGTH(cpf) = 11),

    -- definindo primary key
    CONSTRAINT cliente_pkey
    PRIMARY KEY (cpf),

    -- verificando validade de idade
    CONSTRAINT idade_chk
    CHECK(age(data_nasc) >= '18 years')
);

CREATE TABLE enderecos_do_cliente (

    rua text,

    numero integer,

    bairro text,

    cidade text,

    estado varchar(2),

    tipo_da_residencia tipo_endereco,

    cpf_do_cliente varchar(11),

    -- verificando o tamanho correto de uma sigla
    CONSTRAINT estado_sz_chk
    CHECK(LENGTH(estado) = 2),

    -- referenciando o cliente
    CONSTRAINT cliente_fkey
    FOREIGN KEY (cpf_do_cliente)
    REFERENCES clientes(cpf)

);