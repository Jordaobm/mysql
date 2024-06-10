-- CRIANDO BANCO DE DADOS
drop database if exists rede_social;

create database if not exists rede_social;

use rede_social;

-- CRIANDO UMA PROCEDURE PARA CRIAR ESTRUTURA DE TABELAS DO BANCO
delimiter //

create procedure RecriandoEstrutura ()
begin

	drop table if exists usuarios;

	create table usuarios (
	  id mediumint auto_increment not null primary key,
	  nome varchar(255) not null,
	  email varchar(255) not null,
	  senha varchar(255) not null,
	  data_de_registro timestamp default current_timestamp
	);

	drop table if exists grupos;

	create table grupos (
	  id mediumint auto_increment not null primary key,
	  nome varchar(255) not null,
	  descricao varchar(255)
	);

	drop table if exists posts;

	create table posts (
	  id mediumint auto_increment not null primary key,
	  texto varchar(255) not null,
	  data_publicacao timestamp default current_timestamp,
	  id_autor mediumint not null,
	  id_grupo mediumint,
	  foreign key (id_autor) references usuarios (id),
	  foreign key (id_grupo) references grupos (id)
	);

	drop table if exists comentarios;

	create table comentarios (
	  id mediumint auto_increment not null primary key,
	  id_autor mediumint not null,
	  id_post mediumint not null,
	  texto varchar(255) not null,
	  data_publicacao timestamp default current_timestamp,
	  foreign key (id_autor) references usuarios (id),
	  foreign key (id_post) references posts (id)
	);

	drop table if exists likes;

	create table likes (
	  id mediumint auto_increment not null primary key,
	  id_post mediumint not null,
	  id_autor mediumint not null,
	  foreign key (id_post) references posts (id),
	  foreign key (id_autor) references usuarios (id)
	);

	drop table if exists mensagens_privadas;

	create table mensagens_privadas (
	  id mediumint auto_increment not null primary key,
	  id_remetente mediumint not null,
	  id_destinatario mediumint not null,
	  texto varchar(255) not null,
	  data_envio timestamp default current_timestamp,
	  foreign key (id_remetente) references usuarios (id),
	  foreign key (id_destinatario) references usuarios (id)
	);

	drop table if exists amizades;

	create table amizades (
	  id mediumint auto_increment not null primary key,
	  id_usuario_1 mediumint not null,
	  id_usuario_2 mediumint not null,
	  data_inicio_amizade timestamp default current_timestamp,
	  foreign key (id_usuario_1) references usuarios (id),
	  foreign key (id_usuario_2) references usuarios (id)
	);

	drop table if exists membros_grupo;

	create table membros_grupo (
	  id mediumint auto_increment not null primary key,
	  id_usuario mediumint not null,
	  id_grupo mediumint not null,
	  data_entrada_grupo timestamp default current_timestamp,
	  foreign key (id_usuario) references usuarios (id),
	  foreign key (id_grupo) references grupos (id)
	);

end //

delimiter ;

-- EXECUTANDO PROCEDURE DE CRIAÇÃO DE TABELA DO BANCO
call RecriandoEstrutura();

-- CRIANDO UMA PROCEDURE
delimiter //

create procedure PopulandoBanco ()
begin
	insert into
	  usuarios (nome, email, senha)
	values
	  ('Jordão', 'jordao@example.com', '12345'),
	  ('Gabriel', 'gabriel@example.com', '12345'),
	  ('Pedro', 'pedro@example.com', '12345'),
	  ('Eduardo', 'eduardo@example.com', '12345'),
	  ('Vitor', 'vitor@example.com', '12345'),
	  ('Caick', 'caick@example.com', '12345'),
	  ('Everson', 'everson@example.com', '12345');

	insert into
	  grupos (nome, descricao)
	values
	  (
	    'Desenvolvedores FrontEnd',
	    'Grupo dos desenvolvedores FrontEnd'
	  ),
	  (
	    'Desenvolvedores BackEnd',
	    'Grupo dos desenvolvedores BackEnd'
	  ),
	  (
	    'Desenvolvedores da Equipe A',
	    'Grupo dos desenvolvedores da Equipe A'
	  ),
	  (
	    'Desenvolvedores da Equipe B',
	    'Grupo dos desenvolvedores da Equipe B'
	  );

	insert into
	  membros_grupo (id_usuario, id_grupo)
	values
	  (1, 1),
	  (2, 1),
	  (3, 1),
	  (4, 1),
	  (5, 1),
	  (6, 2),
	  (7, 2),
	  (1, 3),
	  (2, 3),
	  (3, 3),
	  (4, 3),
	  (5, 3),
	  (6, 3),
	  (7, 3);

	insert into
	  amizades (id_usuario_1, id_usuario_2)
	values
	  (1, 2),
	  (1, 3),
	  (1, 4),
	  (1, 5);

	insert into
	  amizades (id_usuario_1, id_usuario_2)
	values
	  (2, 6),
	  (2, 7);

	insert into
	  amizades (id_usuario_1, id_usuario_2)
	values
	  (3, 4),
	  (3, 5);

	insert into
	  amizades (id_usuario_1, id_usuario_2)
	values
	  (4, 5);

	insert into posts (texto, id_autor)	values ('Bom dia gurizada!', 1);
	insert into posts (texto, id_autor, id_grupo) values ('Olá pessoal, tudo bem? Alguém ai tem aqueles assets que vamos utilizar no projeto? Poderia me mandar o link de download do zip por favor?', 1, 1);

	insert into posts (texto, id_autor) values ('Ótimo dia à todos', 2);
	insert into posts (texto, id_autor, id_grupo) values ('Fala galera, beleza? Daqueles métodos JAVA que fizemos estimativa ontem, alguém ai já pegou tarefa deles?', 2, 2);

	insert into posts (texto, id_autor)	values ('Bom dia pessoal, vamos codar!!!', 3);
	insert into posts (texto, id_autor, id_grupo) values ('Oi pessoal, alguém sabe dizer se aquele .env.example está atualizado?', 3, 1);

	insert into posts (texto, id_autor)	values ('Bom dia pessoal, tudo ótimo com vocês?', 4);
	insert into posts (texto, id_autor, id_grupo) values ('Fala galera, beleza? E aquela nova biblioteca JavaScript que lançou integração com o REACT... o que vocês estão achando dela? Eu achei show de bola!', 4, 1);

	insert into posts (texto, id_autor) values ('Oi pessoal, vamos escrever código hoje?!', 5);
	insert into posts (texto, id_autor, id_grupo) values ('Bom dia pessoal, estou impressionado com o que fiz ontem utilizando somente JavaScript. Desenvolvi um web scraping muito doido!!!', 5, 1);

	insert into posts (texto, id_autor)	values ('Bom dia pessoal!', 6);
	insert into posts (texto, id_autor, id_grupo) values ('Bom dia pessoal, fiz o dump do banco de dados para os meninos do frontend e agora vou prosseguir no auxilio deles para restauração dos bancos.', 6, 2);

	insert into posts (texto, id_autor) values ('Fala pessoal, beleza?', 7);
	insert into posts (texto, id_autor, id_grupo) values ('Bom dia pessoal. Ontem fiz uma atualização em massa dos servidores e agora todos eles possuem autenticação, beleza? Lembrem de logar na aplicação para acessar os endpoints!', 7, 2);
end //

delimiter ;

call PopulandoBanco();

select
  *
from
  usuarios u;

select
  *
from
  amizades a;

select
  *
from
  grupos g;

select
  *
from
  posts p;

-- [x] - Usuários: ID, nome, email, senha, data de registro, etc.
-- [x] - Posts: ID, ID do autor, texto, data de publicação, ID do grupo (opcional), etc.
-- [ ] - Comentários: ID, ID do post associado, ID do autor, texto, data de publicação, etc.
-- [ ] - Likes: ID, ID do post associado, ID do autor do like, etc.
-- [ ] - MensagensPrivadas: ID, ID do remetente, ID do destinatário, texto, data de envio, etc.
-- [x] - Amizades: ID do usuário1, ID do usuário2, data de início da amizade, etc.
-- [x] - Grupos: ID, nome do grupo, descrição, etc.
-- [x] - MembrosGrupo: ID do usuário, ID do grupo, data de entrada no grupo, etc.