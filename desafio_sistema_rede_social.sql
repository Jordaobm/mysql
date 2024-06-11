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
	  id_autor mediumint,
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
	  ('Everson', 'everson@example.com', '12345'),
	  ('Usuario Anônimo', 'usuarioanonimo@example.com', '12345');

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

	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Bom dia gurizada!', 1, null, '2024-06-10 10:00:00');
	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Olá pessoal, tudo bem? Alguém ai tem aqueles assets que vamos utilizar no projeto? Poderia me mandar o link de download do zip por favor?', 1, 1, '2024-06-10 10:10:00');

	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Ótimo dia à todos', 2, null, '2024-06-10 10:20:00');
	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Fala galera, beleza? Daqueles métodos JAVA que fizemos estimativa ontem, alguém ai já pegou tarefa deles?', 2, 2, '2024-06-10 10:30:00');

	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Bom dia pessoal, vamos codar!!!', 3, null, '2024-06-10 10:40:00');
	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Oi pessoal, alguém sabe dizer se aquele .env.example está atualizado?', 3, 1, '2024-06-10 10:50:00');

	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Bom dia pessoal, tudo ótimo com vocês?', 4, null, '2024-06-10 11:00:00');
	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Fala galera, beleza? E aquela nova biblioteca JavaScript que lançou integração com o REACT... o que vocês estão achando dela? Eu achei show de bola!', 4, 1, '2024-06-10 11:10:00');

	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Oi pessoal, vamos escrever código hoje?!', 5, null, '2024-06-10 11:20:00');
	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Bom dia pessoal, estou impressionado com o que fiz ontem utilizando somente JavaScript. Desenvolvi um web scraping muito doido!!!', 5, 1, '2024-06-10 11:30:00');

	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Bom dia pessoal!', 6, null, '2024-06-10 11:40:00');
	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Bom dia pessoal, fiz o dump do banco de dados para os meninos do frontend e agora vou prosseguir no auxilio deles para restauração dos bancos.', 6, 2, '2024-06-10 11:50:00');

	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Fala pessoal, beleza?', 7, null, '2024-06-10 12:00:00');
	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Bom dia pessoal. Ontem fiz uma atualização em massa dos servidores e agora todos eles possuem autenticação, beleza? Lembrem de logar na aplicação para acessar os endpoints!', 7, 2, '2024-06-10 12:10:00');

	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Bom dia pessoal, tudo bem? Eu atualizei todos os ambientes e agora todos precisam de autenticação para funcionar corretamente, ok? Se precisarem de credenciais acessem a WIKI do projeto.', 7, 3, '2024-06-10 13:00:00');
	insert into posts (texto, id_autor, id_grupo, data_publicacao) values ('Post fantasma', null, null, '2024-06-10 18:00:00');

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
	insert into likes (id_autor, id_post) values (7, 15);
	insert into likes (id_autor, id_post) values (8, 15);

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


-- REALIZANDO O DUMP / RESTORE DE UM BANCO DE DADOS VIA TERMINAL
mysqldump -u root -p --databases rede_social > rede_social.sql

mysql -u root -p rede_social < rede_social.sql

-- LISTANDO TODOS OS USUÁRIOS QUE TEM ACESSO AO BANCO DE DADOS
select * from mysql.user;

-- CRIANDO UM USUÁRIO APENAS COM PERMISSÃO DE VISUALIZAR TODO MEU BANCO DE DADOS
create user 'johndoe1' identified by 'johndoe1';
grant select on rede_social.* to 'johndoe1';
flush privileges;

-- CRIANDO UM USUÁRIO APENAS COM PERMISSÃO DE VISUALIZAR A TABELA DE POSTS DO MEU BANCO DE DADOS
create user 'johndoe2' identified by 'johndoe2';
grant select on rede_social.posts to 'johndoe2';
flush privileges;

-- MINI-DESAFIOS

-- 1. MySQL SELECT:
select u.nome, u.email from usuarios u;

-- 2. MySQL WHERE:
select * from posts p where p.id_autor = 1;

-- 3. MySQL AND, OR, NOT:
select * from posts p where (p.texto like '%dia%' and p.data_publicacao > '2024-06-10 11:00:00') or (p.id_autor = 1);
select * from posts p where (NOT p.id_grupo = 2 ) or (p.id_grupo is null);

-- 4. MySQL ORDER BY:
select * from posts p order by p.data_publicacao desc;

-- 5. MySQL INSERT INTO:
insert into usuarios (nome, email, senha) values ('John Doe', 'johndoe@example.com', '123');
insert into posts  (texto, id_autor) values ('Esse post será apagado', 9);
-- 6. MySQL NULL Values:
select * from posts p where p.id_grupo is null;

-- 7. MySQL UPDATE:
update usuarios u set u.nome = 'John Doe (updated)', u.senha = '12345' where u.nome = 'John Doe';

-- 8. MySQL DELETE:
delete from posts p where p.texto = 'Esse post será apagado';
delete from usuarios u where u.nome = 'John Doe (updated)';

-- 9. MySQL LIMIT:
select * from posts p order by p.data_publicacao desc limit 0,10;

-- 10. MySQL MIN and MAX:
select MIN(p.data_publicacao) as primeiro_post, MAX(p.data_publicacao) as ultimo_post, p.id_autor from posts p where p.id_autor = 1;

-- 11. MySQL COUNT, AVG, SUM:
select COUNT(*) from likes l where l.id_post = 1;

select
	l.id_post,
	p.texto as post,
	u.nome as autor,
	COUNT(*) as likes
from
	likes l
inner join posts p on
	p.id = l.id_post
inner join usuarios u on
	u.id = p.id_autor
group by
	l.id_post
order by
	likes desc;

select
	avg(likes)
from
	(
	select
		count(*) as likes
	from
		likes l
	group by
		l.id_post) as likes;

-- 12. MySQL LIKE:
select * from usuarios u where u.nome like 'a%';
select * from usuarios u where u.nome like 'j%';

-- 13. MySQL Wildcards:
select * from usuarios u where u.nome like '%dev%';
select * from usuarios u where u.nome like '%a%';

-- 14. MySQL IN:
select * from posts p where p.id_autor in (1, 2, 3);

-- 15. MySQL BETWEEN:
select * from posts p where p.data_publicacao BETWEEN '2024-06-10 12:00:00' AND '2024-06-10 13:00:00'

-- 16. MySQL Aliases:
select u.nome as 'Autor', p.texto as 'Conteúdo' from posts p inner join usuarios u where u.id = p.id_autor;

-- 17. MySQL Joins:
select u.nome as 'Autor', p.texto as 'Conteúdo' from posts p inner join usuarios u where u.id = p.id_autor;

-- 18. MySQL INNER JOIN:
select u.nome as 'Autor', p.texto as 'Conteúdo' from posts p inner join usuarios u where u.id = p.id_autor;

-- 19. MySQL LEFT JOIN:
select * from usuarios u left join posts p on p.id_autor = u.id

-- 20. MySQL RIGHT JOIN:
select * from posts p right join usuarios u on u.id = p.id_autor;

-- 21. MySQL CROSS JOIN:
select  u.id as id_usuario, u.nome, g.id as id_grupo, g.nome from usuarios u cross join grupos g;

-- 22. MySQL Self Join:
select * from amizades a where a.id_usuario_1 <> a.id_usuario_2;

-- 23. MySQL UNION:
select p.texto from posts p
union
select c.texto from comentarios c;

-- 24. MySQL GROUP BY:
select p.id_autor, count(p.id) as quantidade_de_posts from posts p group by p.id_autor ;

-- 25. MySQL HAVING:
select
	g.nome,
	count(mg.id_grupo) as quantidade_membros
from
	membros_grupo mg
inner join grupos g on
	g.id = mg.id_grupo
group by
	mg.id_grupo
having
	quantidade_membros > 5;

-- 26. MySQL EXISTS:
select * from usuarios u where exists (select * from posts p where p.id_autor = u.id)

-- 27. MySQL ANY, ALL:
select
	*
from
	posts p
where
	p.id = any (
	select
		l.id_post
	from
		likes l
	group by
		l.id_post
	having
		count(l.id) = (
		select
			count(u.id)
		from
			usuarios u)

);

-- 28. MySQL INSERT SELECT:
create table PostsBackup (
	  id mediumint auto_increment not null primary key,
	  texto varchar(255) not null,
	  data_publicacao timestamp default current_timestamp,
	  id_autor mediumint,
	  id_grupo mediumint,
	  foreign key (id_autor) references usuarios (id),
	  foreign key (id_grupo) references grupos (id)
);

insert into PostsBackup select * from posts p where p.id_autor = 7;

select * from PostsBackup;

drop table PostsBackup;



-- 29. MySQL CASE

select
    case
        when u.nome is null then 'Usuário Anônimo'
        else u.nome
    end as 'autor',
    p.texto as 'conteúdo'
from
    posts p
left join
    usuarios u on u.id = p.id_autor;



-- 30. MySQL Operators:
select
    p.*
from
    posts p
where
    p.data_publicacao > '2024-06-10 12:00:00'
    and (
        select count(*)
        from likes l
        where l.id_post = p.id
    ) > 5;

-- 31. MySQL Views:
create or replace view PopularPosts as
select
	p.id,
	p.texto,
	p.data_publicacao,
	p.id_autor,
	p.id_grupo,
	count(l.id) as total_likes
from
	posts p
inner join usuarios u on
	u.id = p.id_autor
inner join likes l on
	l.id_post = p.id
group by
	p.id
having
	count(l.id) > 5;

select * from PopularPosts;
