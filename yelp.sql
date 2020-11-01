CREATE TABLE restaurants (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    price_range INT NOT NULL check(price_range >= 1 and price_range <=5)
);

INSERT INTO restaurants (name, location, price_range)
VALUES (
    'McDonalds', 'New York', 3
);

CREATE TABLE reviews (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(id) on delete cascade,
    name VARCHAR(50) NOT NULL,
    review TEXT NOT NULL,
    rating INT NOT NULL check(rating  >= 1 and rating <= 5)
);

INSERT INTO reviews (name, review, rating, restaurant_id) values ('Joey', 'Excellent burgers', 5, 1 );

select trunc(AVG(rating), 2) as avg_rating from reviews where restaurant_id = 2;

select count(rating) from reviews where restaurant_id = 2;

select location, count(location) from restaurants group by location;

select restaurant_id, count(restaurant_id) from reviews group by restaurant_id;

select * from restaurants left join reviews on restaurants.id = reviews.restaurant_id;

//get number of reviews and average rating for each restaurant:
select * from restaurants left join (select restaurant_id, count(*), trunc(avg(rating),1) as average_rating from reviews group 
by restaurant_id) reviews on restaurants.id = reviews.restaurant_id;