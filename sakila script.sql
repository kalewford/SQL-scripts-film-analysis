use sakila;
select * from actor

select upper(concat(first_name, ' ', last_name)) as name from actor;

select actor_id, first_name, last_name from actor where first_name = 'JOE';

select * from actor where last_name like '%GEN%';

select * from actor where last_name like '%LI%' order by last_name, first_name;

select
	country_id, country
from
	country
where
	country in ('Afghanistan' , 'Bangladesh', 'China');
    
alter table actor
add column middle_name varchar(45) null after first_name;

alter table actor
change column middle_name middle_name blob null default null ;

alter table actor
drop column middle_name;

select distinct
	last_name, count(last_name) as 'name_count'
from
	actor
group by last_name;

select distinct
	last_name, count(last_name) as 'name_count'
from
	actor
group by last_name
having name_count >= 2;

select * from actor
where last_name = 'williams'

update actor
set
	first_name = 'harpo'
where
	first_name = 'groucho'
		and last_name = 'williams';
        
select actor_id from actor where first_name = 'harpo' and last_name = 'williams';
select first_name from actor where actor_id = 172;

update actor
set
	first_name = 
				case
		when first_name = 'harpo'
        then 'groucho'
        else 'mucho groucho'
	end
where
	actor_id = 172;
    
select * from address
show create table address;
create table if not exists
'address' (
'address_id' smallint(5) unsigned not null auto_increment,
'address' varchar(50) not null,
'address2' varchar(50) defualt null,
'district' varchar(20)
'city_id' smallint(5)
'postal_code' varchar(10) default null,
'phone' varchar(20) not null;
'location' geometry not null;
'last_update' timestamp not null default current_timestamp on update current_timestamp,
primary key ('address_id')
key 'idx_fk_city_id' ('city_id')
spatial key 'idx_location' ('location'),
contraint 'fk_address_city' foreign key ('city_id') references 'city' ('city_id') on update cascade
) engine=InnoDB auto_increment=606 default charset=utf8;

select
	staff.first_name, staff.last_name, address.address, city.city, country.country
from
	staff
		inner join
	address on staff.address_id = address.address_id
			inner join
		city on address.city_id = city.city_id
			inner join
    country on city.country_id = country.country_id;
    
select
	staff.first_name, staff.last_name, sum(payment.amount) as revenue_recieved
from
	staff
		inner join
	payment on staff.staff_id = payment.staff_id
where
	payment.payment_date like '2005-08%'
group by payment.staff_id;

select
	title, count(actor_id) as number_of_actors
from
	film
		inner join
	film_actor on film.film_id = film_actor.film_id
group by title;

select
	title, count(inventory_id) as number_of_copies
from
	film
		inner join
	inventory on film.film_id = inventory.film_id
where
	title = 'Hunchback Impossible';

select
	last_name, first_name, sum(amount) as total_paid
from
	customer
		inner join
	payment on payment.customer_id = customer.customer_id
group by payment.customer_id
order by last_name asc;

select title from film
where language_id in
	(select language_id
    from language
    where name = "english" )
and (title like "K%") or (title like "Q%");

select last_name, first_name
from actor
where actor_id in
	(select actor_id from film_actor
    where film_id in
			(select film_id from film
            where title = "Alone Trip"));
            
select
	customer.last_name, customer.first_name, customer.email
from
	customer
		inner join
	customer_list on customer.customer_id = customer_list.ID
where
	customer_list.country = 'Canada';

select
	title
from
	film
where
	film_id in(select
			film_id
		from
			film_category
		where
			category_id in (select
					category_id
				from
					category
				where
					name = 'Family'));
                    
select
	film.title, count(*) as 'rent_count'
from
	film,
    inventory,
    rental
where
	film.film_id = inventory.film_id
		and rental.inventory_id = inventory.inventory_id
group by inventory.film_id
order by count(*) desc, film.title asc;

select
	store.store_id, sum(amount) as revenue
from
	store
		inner join
	staff on store.store_id = staff.store_id
		inner join
	payment on payment.staff_id = staff.staff_id
group by store.store_id;

select
	store.store_id, city.city, country.country
from
	store
		inner join
	address on store.address_id = address.address_id
		inner join
	city on address.city_id = city.city_id
		inner join
	country on city.country_id = country.country_id;
    
select
	name, sum(p.amount) as gross_revenue
from
	category c
		inner join
	film_category fc on fc.category_id = c.category_id
		inner join
	inventory i on i.film_id = fc.film_id
		inner join
	rental r on r.inventory_id = i.inventory_id
		right join
	payment p on p.rental_id = r.rental_id
group by name
order by gross_revenue desc
limit 5;

drop view if exists top_five_genres;
create view top_five_genres as

select
	name, sum(p.amount) as gross_revenue
from
	category c
		inner join
	film_category fc on fc.category_id = c.category_id
		inner join
	inventory i on i.film_id = fc.film_id
		inner join
	rental r on r.inventory_id = i.inventory_id
		right join
	payment p on p.rental_id = r.rental_id
group by name
order by gross_revenue desc
limit 5;

select * from top_five_genres;

drop view top_five_genres;




                    

    









    
    

    








