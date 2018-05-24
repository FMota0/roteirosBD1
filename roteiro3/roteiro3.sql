CREATE TYPE tipo_farmacia AS ENUM ('filial', 'sede');

CREATE TYPE tipo_funcionario AS ENUM
('farmaceutico', 'vendedor', 'entregador', 'caixa', 'administrador');

CREATE TYPE tipo_endereco AS ENUM
('residencia', 'trabalho', 'outro');

CREATE TYPE estado_nordeste AS ENUM
('AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE');

CREATE TYPE caracteristica_medicamento AS ENUM
('venda exclusiva', 'sem receita');

CREATE TABLE farmacias (

    identificador serial,

    tipo tipo_farmacia,

    bairro text,

    cidade text,

    estado estado_nordeste,

    CONSTRAINT farmacia_pkey
    PRIMARY KEY (identificador),

    CONSTRAINT tipo_excl
    EXCLUDE USING gist (
        identificador WITH !=
    ) WHERE(tipo = 'sede'),

    CONSTRAINT bairro_uniq
    UNIQUE(bairro)
);

CREATE TABLE funcionarios (

    cpf varchar(11),

    tipo tipo_funcionario,

    farmacia_onde_trabalha integer,

    eh_gerente boolean,

    CONSTRAINT farmacia_fkey
    FOREIGN KEY (farmacia_onde_trabalha)
    REFERENCES farmacias(identificador),

    CONSTRAINT gerent_excl
    EXCLUDE USING gist (
        farmacia_onde_trabalha WITH =
    ) WHERE (eh_gerente = true),

    CONSTRAINT gerente_valido_chk
    CHECK((not eh_gerente) or (eh_gerente and (tipo = 'farmaceutico' or tipo = 'administrador'))),

    CONSTRAINT funcionario_pkey
    PRIMARY KEY (cpf),

    CONSTRAINT cpf_sz_chk
    CHECK(LENGTH(cpf) = 11),

    CONSTRAINT cpf_tipo_uniq
    UNIQUE(cpf, tipo)
);

CREATE TABLE medicamentos (

    identificador serial,

    caracteristica caracteristica_medicamento,

    nome text,

    descricao text,

    preco real,

    CONSTRAINT medicamentos_pkey
    PRIMARY KEY (identificador),

    CONSTRAINT identificador_caracteristica_uniq
    UNIQUE(identificador, caracteristica)
);

-- O cliente nao tem nome ????

CREATE TABLE clientes (

    cpf varchar(11),

    data_nasc timestamp,

    CONSTRAINT cpf_sz_chk
    CHECK(LENGTH(cpf) = 11),

    CONSTRAINT cliente_pkey
    PRIMARY KEY (cpf),

    CONSTRAINT idade_chk
    CHECK(age(data_nasc) >= '18 years')
);

CREATE TABLE enderecos_do_cliente (

    rua text,

    numero integer,

    bairro text,

    cidade text,

    estado varchar(2),

    cep varchar(8),

    tipo_da_residencia tipo_endereco,

    cpf_do_cliente varchar(11),

    CONSTRAINT estado_sz_chk
    CHECK(LENGTH(estado) = 2),

    CONSTRAINT cliente_fkey
    FOREIGN KEY (cpf_do_cliente)
    REFERENCES clientes(cpf),

    CONSTRAINT endereco_pkey
    PRIMARY KEY (cep, numero),

    CONSTRAINT cep_sz_chk
    CHECK(LENGTH(cep) = 8),

    CONSTRAINT cep_num_cpfCliente_uniq
    UNIQUE(cep, numero, cpf_do_cliente)
);

CREATE TABLE vendas (

    identificador serial,

    cpf_funcionario varchar(11),

    tipo_do_funcionario tipo_funcionario,

    identificador_medicamento integer,

    caracteristica_do_medicamento caracteristica_medicamento,

    cpf_cliente varchar(11),

    CONSTRAINT cliente_fkey
    FOREIGN KEY (cpf_cliente)
    REFERENCES clientes(cpf),

    CONSTRAINT funcionarios_fkey
    FOREIGN KEY (cpf_funcionario, tipo_do_funcionario)
    REFERENCES funcionarios(cpf, tipo)
    ON DELETE RESTRICT,

    CONSTRAINT medicamento_fkey
    FOREIGN KEY (identificador_medicamento, caracteristica_do_medicamento)
    REFERENCES medicamentos(identificador, caracteristica)
    ON DELETE RESTRICT,

    CONSTRAINT tipo_funcionario_chk
    CHECK (tipo_do_funcionario = 'vendedor'),

    CONSTRAINT vendas_pkey
    PRIMARY KEY (identificador),

    CONSTRAINT venda_exclusiva_chk
    CHECK(caracteristica_do_medicamento != 'venda exclusiva' or (caracteristica_do_medicamento = 'venda exclusiva' and identificador_medicamento IS NOT NULL)),

    CONSTRAINT identificador_cpf_uniq
    UNIQUE(identificador, cpf_cliente)

);

CREATE TABLE entregas (

    identificador_venda integer,
    cpf_cliente_venda varchar(11),
    cep_endereco varchar(8),
    numero_endereco integer,
    cpf_cliente_endereco varchar(11),

    CONSTRAINT venda_fkey
    FOREIGN KEY (identificador_venda, cpf_cliente_venda)
    REFERENCES vendas(identificador, cpf_cliente),

    CONSTRAINT endereco_fkey
    FOREIGN KEY (cep_endereco, numero_endereco, cpf_cliente_endereco)
    REFERENCES enderecos_do_cliente(cep, numero, cpf_do_cliente),

    CONSTRAINT cpf_chk
    CHECK(cpf_cliente_venda = cpf_cliente_endereco)

);
