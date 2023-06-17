--1. Select users whose id is either 3,2 or 4
--- Please return at least: all user fields

select * from users where id in (2,3,4) 

--2. Count how many basic and premium listings each active user has
--- Please return at least: first_name, last_name, basic, premium

 -- Let say status 1 means active and 2 meaans Inactive
-- Let say status in listing 2-- for basic and 3 for premium

 --Answer ---

select distinct u.first_name, u.last_name,
case when l.status = 2 then Count(l.status)
end  as Basic,
case when l.status = 3 then Count(l.status) 
end  as Premium
from dbo.listings l LEFT join dbo.Users u on l.user_id =u.id 
where u.status=1 
group by u.first_name, u.last_name, l.status


--3. Show the same count as before but only if they have at least ONE premium listing
--- Please return at least: first_name, last_name, basic, premium

---Answer---
select distinct u.first_name, u.last_name,
case when l.status = 2 then Count(l.status)
end  as Basic,
case when l.status = 3 then Count(l.status) 
end  as Premium
from dbo.listings l LEFT join dbo.Users u on l.user_id =u.id 
where  u.status=1 --and Count(l.status) > 0
group by u.first_name, u.last_name, l.status
having count(l.status)>1

--4. How much revenue has each active vendor made in 2013
--- Please return at least: first_name, last_name, currency, revenue


---Answer
select  distinct u.first_name, u.last_name, c.currency,
sum (c.price) as Revenue 
from dbo.Users u inner join dbo.listings l on u.id = l.user_id inner join dbo.Clicks c on l.id=c.listing_id 
where u.status =1 and year(c.created)='2013' 
group by u.first_name, u.last_name, c.currency

--5. Insert a new click for listing id 3, at $4.00
--- Find out the id of this new click. Please return at least: id

---Answer
insert into dbo.Clicks values(3,4.00,'USD',GETDATE())
select MAX(id) as Id from dbo.Clicks a

--6. Show listings that have not received a click in 2013
--- Please return at least: listing_name

--ANswer--
select l.name
from dbo.listings l 
left join dbo.clicks c
on l.id =c.listing_id
where year(c.created) != '2013' 
group by l.name


--7. For each year show number of listings clicked and number of vendors who owned these listings
--- Please return at least: date, total_listings_clicked, total_vendors_affected

--answer
select year(c.created), count(distinct(c.listing_id)) as Total_listing_clicked , count(distinct l.user_id) as total_vendors_affected
from dbo.Clicks c inner join dbo.listings l on c.listing_id = l.id   group by year(created)


--8. Return a comma separated string of listing names for all active vendors
--- Please return at least: first_name, last_name, listing_names

---answer
DECLARE @listNames VARCHAR(MAX)
select All @listNames=COALESCE(@listNames+', ' ,'') + l.Name
from dbo.Users u inner join dbo.listings l on u.id = l.user_id  where u.status=1
select u.first_name, u.last_name, @listNames as Listing from dbo.Users u where u.status=1










