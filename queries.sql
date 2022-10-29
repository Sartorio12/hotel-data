select distinct
	country,
	count(0) as bookings
from base
group by country
order by bookings desc
limit 10;
'''
Podemos perceber que a maioria das reservas acontece em
território Europeu, com Portugal liderando.
Isso pode ocorrer por Portugal ser parte da União Europeia,
facilitando o turismo por toda a Europa a partir desse ponto.
'''
 
select country,count(0) as bookings from base
where arrival_date_month ~ 'February'
group by country
order by bookings desc
limit 1;

'''
O local mais procurado no carnaval foi também Portugal,
visto que o lugar é um ponto turístico popular em qualquer
época do ano, não seria diferente em fevereiro. Apesar dos
motivos citados acima, Portugal está em 14º lugar no 
ranking de países com mais Hotéis de toda a Europa, o 
que realmente pode indicar ocorrer Overbooking nesses
locais.
'''
select hotel,count(is_canceled) from base 
group by hotel;

'''
Podemos perceber que a maior porcentagem
de cancelamentos ocorre em hotéis da cidade.
Porém, isso pode ser porque temos mais
amostras desse tipo de hotel. Para um resultado
mais preciso, precisamos verificar as porcentagens
em uma amostra igual de ambos os tipos.
Além disso, nota-se que existe um número
elevado de hospedagens em hotéis urbanos,
o que nos leva a concluir que possivelmente
acontece "overbooking" nesses hotéis.
'''

select
	avg(all_sum_column)
from base
where country = 'DEU'
and arrival_date_year = '2017';

'''
Notamos que a média de todas as idades foi 42,
o que indica pouca hospedagem de crianças e bebês.
Baseado nisso, percebemos que falta algum atrativo
familiar para atrair mais hóspedes do tipo.
'''