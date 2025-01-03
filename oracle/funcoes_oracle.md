
Funções de Manipulação de Strings
1. TO_CHAR: Converte números ou datas para uma string, com formato personalizado opcional. 
	Exemplo: SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS data_formatada;
2. SUBSTR: Extrai uma substring de uma string. 
	Exemplo: SELECT SUBSTR('CommunityLink', 1, 8) AS resultado;
3. INSTR: Retorna a posição de uma substring em uma string. 
	Exemplo: SELECT INSTR('CommunityLink', 'Link') AS posicao;
4. LENGTH: Retorna o tamanho (número de caracteres) de uma string. 
	Exemplo: SELECT LENGTH('CommunityLink') AS tamanho;
5. REPLACE: Substitui uma substring por outra dentro de uma string. 
	Exemplo: SELECT REPLACE('CommunityLink', 'Link', 'Hub') AS resultado;
6. CONCAT: Concatena (junta) duas strings. 
	Exemplo: SELECT CONCAT('Hello', ' World') AS resultado;
7. UPPER: Converte uma string para letras maiúsculas. 
	Exemplo: SELECT UPPER('sql') AS resultado;
8. LOWER: Converte uma string para letras minúsculas. 
	Exemplo: SELECT LOWER('SQL') AS resultado;
9. LTRIM: Remove espaços ou caracteres do início de uma string. 
	Exemplo: SELECT LTRIM('   Hello') AS resultado;
10. RTRIM: Remove espaços ou caracteres do final de uma string. 
	Exemplo: SELECT RTRIM('Hello   ') AS resultado;
11. TRIM: Remove espaços ou caracteres do início e do final de uma string. 
	Exemplo: SELECT TRIM('   Hello   ') AS resultado;

---
Funções Matemáticas
1. TO_NUMBER: Converte uma string para um número. 
	Exemplo: SELECT TO_NUMBER('123.45') AS numero;
2. ROUND: Arredonda um número para o número especificado de casas decimais. 
	Exemplo: SELECT ROUND(123.456, 2) AS resultado;
3. TRUNC: Trunca (corta) um número para o número especificado de casas decimais. 
	Exemplo: SELECT TRUNC(123.456, 2) AS resultado;
4. MOD: Retorna o resto de uma divisão. 
	Exemplo: SELECT MOD(10, 3) AS resultado;
5. CEIL: Retorna o menor número inteiro maior ou igual ao número fornecido. 
	Exemplo: SELECT CEIL(12.34) AS resultado;
6. FLOOR: Retorna o maior número inteiro menor ou igual ao número fornecido. 
	Exemplo: SELECT FLOOR(12.34) AS resultado;

---
Funções de Data e Hora
1. TO_DATE: Converte uma string para um formato de data. 
	Exemplo: SELECT TO_DATE('2025-01-01', 'YYYY-MM-DD') AS data;
2. SYSDATE: Retorna a data e a hora atuais. 
	Exemplo: SELECT SYSDATE AS data_atual;
3. CURRENT_DATE: Retorna a data atual no fuso horário do cliente. 
	Exemplo: SELECT CURRENT_DATE AS data_atual;
4. ADD_MONTHS: Adiciona ou subtrai meses a uma data. 
	Exemplo: SELECT ADD_MONTHS(SYSDATE, 2) AS nova_data;
5. MONTHS_BETWEEN: Calcula o número de meses entre duas datas. 
	Exemplo: SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2025-01-01', 'YYYY-MM-DD')) AS diferenca;
6. LAST_DAY: Retorna o último dia do mês de uma data específica. 
	Exemplo: SELECT LAST_DAY(SYSDATE) AS ultimo_dia;

---
Funções de Manipulação de Nulos
1. NVL: Substitui valores nulos por um valor padrão. 
	Exemplo: SELECT NVL(NULL, 'Valor padrão') AS resultado;

---
Funções de Agregação
1. SUM: Retorna a soma de um conjunto de valores. 
	Exemplo: SELECT SUM(salario) AS total_salario FROM empregado;
2. AVG: Retorna a média de um conjunto de valores. 
	Exemplo: SELECT AVG(salario) AS media_salario FROM empregado;
3. COUNT: Conta o número de linhas ou valores não nulos. 
	Exemplo: SELECT COUNT(*) AS total_linhas FROM empregado;
4. MIN: Retorna o menor valor de um conjunto de valores. 
	Exemplo: SELECT MIN(salario) AS menor_salario FROM empregado;
5. MAX: Retorna o maior valor de um conjunto de valores. 
	Exemplo: SELECT MAX(salario) AS maior_salario FROM empregado;
