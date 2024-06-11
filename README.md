# Desafio MySQL: Sistema de Rede Social Avançado com Grupos e Conceitos Adicionais

Você vai criar um sistema de rede social usando apenas o DBEAVER como IDE de desenvolvimento e um servidor MySQL. O sistema deve lidar com usuários, posts, comentários, likes, mensagens privadas etc.

**Tabelas necessárias:**
1. Usuários: ID, nome, email, senha, data de registro, etc.
2. Posts: ID, ID do autor, texto, data de publicação, ID do grupo (opcional), etc.
3. Comentários: ID, ID do post associado, ID do autor, texto, data de publicação, etc.
4. Likes: ID, ID do post associado, ID do autor do like, etc.
5. MensagensPrivadas: ID, ID do remetente, ID do destinatário, texto, data de envio, etc.
6. Amizades: ID do usuário1, ID do usuário2, data de início da amizade, etc.
7. Grupos: ID, nome do grupo, descrição, etc.
8. MembrosGrupo: ID do usuário, ID do grupo, data de entrada no grupo, etc.

**Relacionamentos:**
1. Um usuário pode pertencer a vários grupos.
2. Um grupo pode ter vários membros.
3. Um post, se estiver relacionado a um grupo, deverá ser exibido apenas para membros daquele grupo. Se o post não estiver relacionado a um grupo, então ele é um post público e pode ser exibido por qualquer pessoa.

**Stored Procedures:**
1. Crie alguns procedimentos armazenados simples para realizar operações comuns, como inserção de um novo usuário, exclusão de um post ou atualização de dados de um usuário.

**Backup:**
1. Crie um procedimento para realizar o backup dos dados do banco de dados em um arquivo de texto e outro procedimento para restaurar esses dados a partir do arquivo de backup.

**Otimização de Consultas:**
1. Adicione índices nas colunas relevantes das tabelas utilizadas.

**Segurança do Banco de Dados:**
1. Implemente um esquema de usuários que podem acessar seu banco de dados e realizar operações. Defina privilégios a esses usuários.

Este desafio aborda conceitos do MySQL, desde o básico até funcionalidades mais avançadas como Stored Procedures, Backup e Otimização de Consultas. Popule seu banco de dados pois abaixo segue uma lista de mini-desafios que você deverá executar utilizando sua base de dados construída para fortalecer seus conhecimentos em MySQL:

1. **MySQL SELECT**:
   - Escreva uma consulta para selecionar o nome e o email de todos os usuários da tabela "Usuários".

2. **MySQL WHERE**:
   - Escreva uma consulta para selecionar todos os posts feitos por um usuário específico, identificado pelo seu ID.

3. **MySQL AND, OR, NOT**:
   - Escreva uma consulta para selecionar todos os posts que contêm uma determinada palavra-chave no texto e que foram publicados depois de uma determinada data, ou que foram feitos por um usuário específico.

4. **MySQL ORDER BY**:
   - Escreva uma consulta para selecionar os posts mais recentes, ordenados pela data de publicação em ordem decrescente.

5. **MySQL INSERT INTO**:
   - Escreva uma instrução SQL para inserir um novo registro na tabela "Usuários" com informações de um novo usuário.

6. **MySQL NULL Values**:
   - Escreva uma consulta para selecionar todos os posts que não têm um grupo associado (NULL no campo ID do grupo).

7. **MySQL UPDATE**:
   - Escreva uma instrução SQL para atualizar o nome de um usuário específico na tabela "Usuários".

8. **MySQL DELETE**:
   - Escreva uma instrução SQL para excluir um post específico da tabela "Posts".

9. **MySQL LIMIT**:
   - Escreva uma consulta para selecionar os 10 posts mais recentes, limitando o número de resultados. (paginação)

10. **MySQL MIN and MAX**:
    - Escreva uma consulta para encontrar a data do primeiro e do último post feito por um usuário específico.

11. **MySQL COUNT, AVG, SUM**:
    - Escreva uma consulta para contar o número total de likes em um post específico e calcular a média de likes por post.

12. **MySQL LIKE**:
    - Escreva uma consulta para selecionar todos os usuários cujo nome começa com a letra "A".

13. **MySQL Wildcards**:
    - Escreva uma consulta para selecionar todos os usuários cujo nome contém a palavra "dev", independentemente da posição da palavra no nome.

14. **MySQL IN**:
    - Escreva uma consulta para selecionar todos os posts feitos por usuários específicos, identificados por seus IDs.

15. **MySQL BETWEEN**:
    - Escreva uma consulta para selecionar todos os posts feitos entre duas datas específicas.

16. **MySQL Aliases**:
    - Escreva uma consulta para selecionar o nome do autor e o texto do post, renomeando as colunas como "Autor" e "Conteúdo".

17. **MySQL Joins**:
    - Escreva uma consulta para selecionar o nome do autor e o texto do post, incluindo informações do usuário autor do post da tabela "Usuários".

18. **MySQL INNER JOIN**:
    - Escreva uma consulta para selecionar os posts e os respectivos autores, excluindo aqueles que não têm um autor associado.

19. **MySQL LEFT JOIN**:
    - Escreva uma consulta para selecionar todos os usuários e os posts que eles fizeram, incluindo os usuários que não têm posts.

20. **MySQL RIGHT JOIN**:
    - Escreva uma consulta para selecionar todos os posts e os respectivos autores, incluindo os posts que não têm um autor associado.

21. **MySQL CROSS JOIN**:
    - Escreva uma consulta para criar todas as combinações possíveis de usuários e grupos, sem aplicar uma condição de junção.

22. **MySQL Self Join**:
    - Escreva uma consulta para selecionar todos os pares de usuários que são amigos, utilizando a tabela "Amizades".

23. **MySQL UNION**:
    - Escreva uma consulta para combinar os resultados de duas consultas diferentes que selecionam posts e mensagens privadas, respectivamente.

24. **MySQL GROUP BY**:
    - Escreva uma consulta para contar o número de posts feitos por cada usuário, agrupando os resultados pelo ID do autor.

25. **MySQL HAVING**:
    - Escreva uma consulta para selecionar os grupos que têm mais de 10 membros, aplicando a condição após a cláusula GROUP BY.

26. **MySQL EXISTS**:
    - Escreva uma consulta para selecionar todos os usuários que têm pelo menos um post na tabela "Posts".

27. **MySQL ANY, ALL**:
    - Escreva uma consulta para selecionar todos os posts que receberam likes de todos os usuários que estão na tabela "Usuários".

28. **MySQL INSERT SELECT**:
    - Escreva uma instrução SQL para inserir uma cópia de todos os posts feitos por um usuário específico em outra tabela chamada "PostsBackup".

29. **MySQL CASE**:
    - Escreva uma consulta para selecionar o nome do autor e o texto do post, substituindo o nome do autor por "Usuário Anônimo" se o autor estiver ausente.

30. **MySQL Operators**:
    - Escreva uma consulta para selecionar os posts que foram publicados depois de uma determinada data e que receberam mais de 10 likes.

31. **MySQL Views**:
    - Crie uma view chamada "PopularPosts" que exiba os posts mais populares (com mais de 100 likes) com o nome do autor e o número de likes.

Ao final do desafio, disponibilize um DUMP do seu banco de dados juntamente com um arquivo contendo os scripts executados durante o desafio. De preferência separe os scripts utilizados durante o desafio (core) dos scripts utilizados para os mini-desafios. Nos scripts dos mini-desafios, separe-os utilizando o número do desafio. Utilize comentários para esclarecer seu código! Boa sorte!
