# <center>  Análise Exploratória - Dados de Hotéis

<center><img src='https://i.imgur.com/CVogXrs.png'>

# Introdução

Você já se perguntou qual é a melhor época do ano para reservar um quarto de hotel? Ou a duração ideal da estadia para obter a melhor diária? E se quisesse prever se um hotel provavelmente receberia um número desproporcionalmente alto de solicitações especiais?
Bem, essa análise tem como propósito te ajudar, apesar de existirem infinitas possibilidades para essa análise.

A base de dados a ser utilizada será a "[Hotel Booking Demand](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)". Este conjunto de dados contém informações de reserva para um hotel urbano e um hotel resort e inclui informações como quando a reserva foi feita, duração da estadia, número de adultos, crianças e/ou bebês e o número de vagas de estacionamento disponíveis, entre outras coisas.

Todas as informações de identificação pessoal foram removidas dos dados. 

Para começar nossa análise, criaremos uma base de dados para inserção do Dataset e consulta do mesmo. Utilizando o banco de dados PostgreSQL, o versionador de base DBeaver e a biblioteca Pandas do Python, para a limpeza e tratamento de dados faltantes. Caso você queira conferir os dados pessoalmente, é fundamental que você possua os mesmos instalados e configurados.

Abaixo, você poderá notar o banco de dados conectado, e o nosso dataset importado com o nome de "base", nele contemos todas as informações necessárias para a análise. 

<center><img src ='https://i.imgur.com/axxBBM6.png' width='300'>

# Limpeza e Tratamento dos Dados

A primeira parte consiste na limpeza e tratamento dos dados, para este, foi utilizada a lib Pandas, do Python. Uma das coisas que notei, foi a ausência de uma coluna correspondente a idade dos hóspedes, a fim de estudo, incluí uma, com números gerados aleatoriamente dentro do intervalo mencionado. 

Dentro deste mesmo repositório, você pode encontrar o notebook utilizado para tal fim.

# Query #1

Para início de análise, contaremos quais os países com os maiores números de reserva:

```
select distinct
	country,
	count(0) as bookings
from base
group by country
order by bookings desc
limit 5;
```
<center><img src='https://i.imgur.com/mDE15mx.png' width='400'>

Podemos perceber que a maioria das reservas acontece em
território Europeu, com Portugal liderando.
Isso pode ocorrer por Portugal ser parte da União Europeia,
facilitando o turismo por toda a Europa a partir desse ponto, uma vez que a viagem entre esses países é livre de burocracias de migração.

# Query #2

Agora veremos qual país se destacou nessa questão no período de Carnaval, que compreende o mês de Fevereiro:

```
select
	country,
	count(0) as bookings
from base
where arrival_date_month ~ 'February'
group by country
order by bookings desc
limit 1;

```

<center><img src='https://i.imgur.com/usyVdYa.png' width='400'>

O local mais procurado no carnaval foi também Portugal,
visto que o lugar é um ponto turístico popular em qualquer
época do ano, não seria diferente em Fevereiro. Apesar dos
motivos citados acima, Portugal está em 14º lugar no 
ranking de países com mais Hotéis de toda a Europa (como relatado na [fonte](https://www.nationmaster.com/nmx/ranking/number-of-hotels-establishments) abaixo) o 
que realmente pode indicar ocorrer Overbooking nesses
locais.

<center><img src='https://i.imgur.com/dkS3YHu.png'>

# Query #3

Vejamos agora quantos cancelamentos foram obtidos por cada tipo de hotel disponível na base:

```
select
	hotel,
	count(is_canceled) 
from base 
group by hotel;
```

<center><img src='https://i.imgur.com/jwggHly.png' width='300'>

Podemos perceber que a maior porcentagem
de cancelamentos ocorre em hotéis urbanos.


Porém, isso pode ser porque temos mais
amostras desse tipo de hotel. Para um resultado
mais preciso, precisamos verificar as porcentagens
em uma amostra igual de ambos os tipos.
Além disso, nota-se que existe um número
elevado de hospedagens nesse tipo de hotel,
o que nos leva a concluir que possivelmente
acontece "overbooking" nesses hotéis.

# Query #4

Para esta consulta, na limpeza foram criadas as colunas referente as idades dos hóspedes, e, junto a ela, foi criada também uma coluna que remete a soma de todas as idades, a fim de facilitar as consultas e análises posteriores.

Aqui iremos verificar qual a média de idades dos hóspedes da Alemanha, no último ano:

```
select
	avg(all_sum_column)
from base
where country = 'DEU'
and arrival_date_year = '2017';
```

<center><img src='https://i.imgur.com/CfHCP4t.png' width='150'>

Notamos que a média de todas as idades foi 42, o que indica pouca hospedagem de crianças e bebês. Baseado nisso, percebemos que falta algum atrativo familiar para atrair mais hóspedes do tipo.

# Conclusão

- Apesar do case não indicar o uso de Python como fundamental, no final das contas vimos que se faz necessário, uma vez que dados podem conter falhas, e para não enviesar a pesquisa, é necessário tratá-los.
- Conseguimos analisar os dados de forma quase que precisa, dadas as informações disponibilizadas.
- De uma perspectiva de negócios, caso um booking seja sinalizado como "cancelado", deveríamos mandar um e-mail pro cliente para confirmar o cancelamento. Isso iria garantir que o número de agendamentos falsos diminua, e passaria mais credibilidade para o cliente.
- Já que estamos trabalhando com uma quantidade limitada de dados, existe uma grande chance dessas análises decaírem no futuro. Em contraparte, o remodelamento desses dados e a configuração de um novo modelo pode ser exigida.
- Na questão de produção, a ingestão desse tipo de dado pode ser automatizado pelo hotel, para agilizar o setor de dados da empresa, e garantir maior precisão nas análises. 
