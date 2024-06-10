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

	insert into posts (texto, id_autor, id_grupo) values ('Bom dia pessoal, tudo bem? Eu atualizei todos os ambientes e agora todos precisam de autenticação para funcionar corretamente, ok? Se precisarem de credenciais acessem a WIKI do projeto.', 7, 3);

	insert into comentarios (id_autor, id_post, texto) values (1, 3, 'Bom dia gurizão, ótimo dia pra todos nós! Abraço');
	insert into comentarios (id_autor, id_post, texto) values (1, 5, 'Bom dia piá, vamooss!! Cola discord!');
	insert into comentarios (id_autor, id_post, texto) values (1, 6, 'Oi, sim sim o .env.example está atualizado. Basta duplicá-lo alterando o nome para .env e rodar a aplicação que estará tudo funcionando! Abraço');
	insert into comentarios (id_autor, id_post, texto) values (1, 7, 'Bom dia, tudo jóia e contigo?');
	insert into comentarios (id_autor, id_post, texto) values (1, 8, 'Rapaz estou achando muito bom também. Acho que deveriamos usar em algum projeto');
	insert into comentarios (id_autor, id_post, texto) values (1, 9, 'Opaaa, claro que sim. Eu e o Pedro estamos numa sala do discord já. Vem com a gente!');
	insert into comentarios (id_autor, id_post, texto) values (1, 10, 'Nossa muito legal isso cara. Compartilha com a gente o que você fez.');
	insert into comentarios (id_autor, id_post, texto) values (1, 11, 'Opa, bom dia tudo certo?!');
	insert into comentarios (id_autor, id_post, texto) values (1, 13, 'Beleza, e contigo Everson?');
	insert into comentarios (id_autor, id_post, texto) values (1, 15, 'Tranquilo, vamos atualizar o Front aqui para conectarmos aos ambientes autenticados. Valeu!');

	insert into comentarios (id_autor, id_post, texto) values (2, 1, 'Bom dia guri!');
	insert into comentarios (id_autor, id_post, texto) values (2, 5, 'Bom dia, vamo!!');
	insert into comentarios (id_autor, id_post, texto) values (2, 7, 'Bom dia, tudo ótimo!!');
	insert into comentarios (id_autor, id_post, texto) values (2, 9, 'Vamoss!!');
	insert into comentarios (id_autor, id_post, texto) values (2, 11, 'Opa bom diaa!!');
	insert into comentarios (id_autor, id_post, texto) values (2, 12, 'Show! Quando finalizar a gente pode fazer aquele alinhamento, bele?!');
	insert into comentarios (id_autor, id_post, texto) values (2, 13, 'Beleeza');
	insert into comentarios (id_autor, id_post, texto) values (2, 14, 'Os usuários de testes estão na WIKI? Consegue me passar o link da WIKI por favor?');
	insert into comentarios (id_autor, id_post, texto) values (2, 15, 'Beleza!');

	insert into comentarios (id_autor, id_post, texto) values (3, 1, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (3, 2, 'Opa eu tenho sim cara, vou te mandar o link no chat, só 1 minuto');
	insert into comentarios (id_autor, id_post, texto) values (3, 3, 'Ótimo dia');
	insert into comentarios (id_autor, id_post, texto) values (3, 7, 'Tudo certo e contigo?');
	insert into comentarios (id_autor, id_post, texto) values (3, 8, 'Sim sim, é muito interessante. Usei em um projeto pessoal e essa lib é realmente muito boa. Uma mão na roda');
	insert into comentarios (id_autor, id_post, texto) values (3, 9, 'Boraa!');
	insert into comentarios (id_autor, id_post, texto) values (3, 10, 'Cara mostra pra gente. Fiquei curioso');
	insert into comentarios (id_autor, id_post, texto) values (3, 11, 'Bom dia');
	insert into comentarios (id_autor, id_post, texto) values (3, 13, 'Beleza');
	insert into comentarios (id_autor, id_post, texto) values (3, 15, 'Beleza!');

	insert into comentarios (id_autor, id_post, texto) values (4, 1, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (4, 2, 'Pior que estou precisando também. Se alguém puder me enviar ficaria agradecido!');
	insert into comentarios (id_autor, id_post, texto) values (4, 3, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (4, 5, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (4, 6, 'Está atualizado sim. Inclusive a última modificação fui eu que fiz e está rodando aqui!');
	insert into comentarios (id_autor, id_post, texto) values (4, 9, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (4, 10, 'Legall');
	insert into comentarios (id_autor, id_post, texto) values (4, 11, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (4, 13, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (4, 15, 'Beleza!');

	insert into comentarios (id_autor, id_post, texto) values (5, 1, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (5, 2, 'Se puder colocar o link dos assets em algum lugar para todos nós seria ótimo pois eu também não tenho não rsrsrs!');
	insert into comentarios (id_autor, id_post, texto) values (5, 3, 'Bom diaaa!');
	insert into comentarios (id_autor, id_post, texto) values (5, 5, 'Bom diaaa, vamos!');
	insert into comentarios (id_autor, id_post, texto) values (5, 6, 'Está atualizado!');
	insert into comentarios (id_autor, id_post, texto) values (5, 7, 'Bom dia tudo jóia!');
	insert into comentarios (id_autor, id_post, texto) values (5, 8, 'Muito legal deveriamos usar mesmo!');
	insert into comentarios (id_autor, id_post, texto) values (5, 11, 'Bom diaa');
	insert into comentarios (id_autor, id_post, texto) values (5, 13, 'Bom diaa');
	insert into comentarios (id_autor, id_post, texto) values (5, 15, 'Beleza!');

	insert into comentarios (id_autor, id_post, texto) values (6, 1, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (6, 3, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (6, 4, 'Já estão sendo feitas sim!');
	insert into comentarios (id_autor, id_post, texto) values (6, 5, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (6, 7, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (6, 9, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (6, 13, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (6, 14, 'Você consegue me passar as credenciais?');
	insert into comentarios (id_autor, id_post, texto) values (6, 15, 'Beleza!');


	insert into comentarios (id_autor, id_post, texto) values (7, 1, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (7, 3, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (7, 4, 'Já puxei uma aqui já. Estamos fazendo!');
	insert into comentarios (id_autor, id_post, texto) values (7, 5, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (7, 7, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (7, 9, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (7, 11, 'Bom dia!!');
	insert into comentarios (id_autor, id_post, texto) values (7, 12, 'Legal.');

	insert into likes (id_autor, id_post) values (1, 4);
	insert into likes (id_autor, id_post) values (1, 6);
	insert into likes (id_autor, id_post) values (1, 8);
	insert into likes (id_autor, id_post) values (1, 9);
	insert into likes (id_autor, id_post) values (1, 10);
	insert into likes (id_autor, id_post) values (1, 15);

	insert into likes (id_autor, id_post) values (2, 12);
	insert into likes (id_autor, id_post) values (2, 14);
	insert into likes (id_autor, id_post) values (2, 15);

	insert into likes (id_autor, id_post) values (3, 1);
	insert into likes (id_autor, id_post) values (3, 2);
	insert into likes (id_autor, id_post) values (3, 3);
	insert into likes (id_autor, id_post) values (3, 7);
	insert into likes (id_autor, id_post) values (3, 8);
	insert into likes (id_autor, id_post) values (3, 9);
	insert into likes (id_autor, id_post) values (3, 10);
	insert into likes (id_autor, id_post) values (3, 11);
	insert into likes (id_autor, id_post) values (3, 13);
	insert into likes (id_autor, id_post) values (3, 15);

	insert into likes (id_autor, id_post) values (4, 1);
	insert into likes (id_autor, id_post) values (4, 3);
	insert into likes (id_autor, id_post) values (4, 5);
	insert into likes (id_autor, id_post) values (4, 7);
	insert into likes (id_autor, id_post) values (4, 9);
	insert into likes (id_autor, id_post) values (4, 11);
	insert into likes (id_autor, id_post) values (4, 13);
	insert into likes (id_autor, id_post) values (4, 15);

	insert into likes (id_autor, id_post) values (5, 1);
	insert into likes (id_autor, id_post) values (5, 2);
	insert into likes (id_autor, id_post) values (5, 3);
	insert into likes (id_autor, id_post) values (5, 5);
	insert into likes (id_autor, id_post) values (5, 6);
	insert into likes (id_autor, id_post) values (5, 7);
	insert into likes (id_autor, id_post) values (5, 8);
	insert into likes (id_autor, id_post) values (5, 11);
	insert into likes (id_autor, id_post) values (5, 13);
	insert into likes (id_autor, id_post) values (5, 15);

	insert into likes (id_autor, id_post) values (6, 2);
	insert into likes (id_autor, id_post) values (6, 14);
	insert into likes (id_autor, id_post) values (6, 15);

	insert into likes (id_autor, id_post) values (7, 2);
	insert into likes (id_autor, id_post) values (7, 12);

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (1, 3, 'Oi, sobre o env... você conseguiu resolver?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (3, 1, 'Consegui sim, obrigado!');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (1, 3, 'Tranquilo. Hey, bora fazer pair programming hoje?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (3, 1, 'Vamos sim, só eu rodar a aplicação aqui!');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (1, 3, 'Beleza. Me manda o link dos assets por favor?!');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (3, 1, 'assets.zip');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (3, 1, 'Ta na mão');

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (1, 2, 'Opa, nós vamos fazer a diária hoje?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (2, 1, 'Sim sim, está marcado para 10:00');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (1, 2, 'Perfeito');

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (1, 4, 'Muito legal a lib que você comentou hoje');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (4, 1, 'Massa né?! Vamos colocar em algum projeto, vai ser muito bom!');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (1, 4, 'Com certeza vamos');

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (1, 5, 'Opa, cola comigo e com o Pedro aqui, vai ser legal');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (5, 1, 'Estou indo, só vou pegar um café');

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (2, 6, 'Sobre os dumps... consegue me passar os arquivos?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (6, 2, 'Claro, só 1 minuto');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (6, 2, 'dumps.zip');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (2, 6, 'Obrigado!');

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (2, 7, 'Rapaz e sobre aquelas credenciais lá, como ficou?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (7, 2, 'Coloquei na WIKI do projeto pra galera toda ver. Os ambientes foram todos atualizados');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (2, 7, 'Entendi, até DEV?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (7, 2, 'Sim, até DEV. Todos os ambientes agora precisam de autenticação pra funcionar');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (2, 7, 'Ok vou avisar o time');

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (3, 4, 'Viu, vai fazer o que hoje após o trabalho?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (4, 3, 'Nada, pq?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (3, 4, 'Vamos um garticzinho?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (4, 3, 'Claro!');

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (3, 5, 'Bora gartic após o trabalho?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (5, 3, 'Vamos!');

	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (6, 7, 'Rapaz, das autenticações lá, o ambiente está rodando?');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (7, 6, 'Está sim, acessa o ip 404 lá que vai estar online');
	insert into mensagens_privadas (id_remetente, id_destinatario, texto) values (6, 7, 'Beleza vlwww!');

end //
delimiter ;

call PopulandoBanco();

select * from usuarios u;
select * from posts p;
select * from comentarios c;
select * from likes l;
select * from mensagens_privadas mp;
select * from amizades a;
select * from grupos g;
select * from membros_grupo mg;


-- [x] - Usuários: ID, nome, email, senha, data de registro, etc.
-- [x] - Posts: ID, ID do autor, texto, data de publicação, ID do grupo (opcional), etc.
-- [x] - Comentários: ID, ID do post associado, ID do autor, texto, data de publicação, etc.
-- [x] - Likes: ID, ID do post associado, ID do autor do like, etc.
-- [x] - MensagensPrivadas: ID, ID do remetente, ID do destinatário, texto, data de envio, etc.
-- [x] - Amizades: ID do usuário1, ID do usuário2, data de início da amizade, etc.
-- [x] - Grupos: ID, nome do grupo, descrição, etc.
-- [x] - MembrosGrupo: ID do usuário, ID do grupo, data de entrada no grupo, etc.