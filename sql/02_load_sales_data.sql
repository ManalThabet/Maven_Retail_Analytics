select * into Sales from [Sales 2017]
where 1=0;

insert into Sales
select * from [Sales 2017];


insert into Sales
select * from [Sales 2018];

select 'Total Rows' as label,count(*) as Row_count from Sales;
