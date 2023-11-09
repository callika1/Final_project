-- Create raw tables
CREATE TABLE raw_users (
user_id INT,
user_name VARCHAR(100),
country VARCHAR(50)
);
CREATE TABLE raw_posts (
post_id INT,
post_text VARCHAR(500),
post_date DATE,
user_id INT
);
CREATE TABLE raw_likes (
like_id INT,
user_id INT,
post_id INT,
like_date DATE
);

-- Membuat tabel fakta fact_post_performance
CREATE TABLE fact_post_performance (
  performance_id SERIAL PRIMARY KEY,
  post_id INT,
  date_id INT,
  post_views INT,
  post_likes INT
);
SELECT
  p.post_id,
  d.date_id,
  COUNT(DISTINCT pv.like_id) AS post_views,
  COUNT(l.like_id) AS post_likes
FROM raw_posts p
JOIN raw_likes l ON p.post_id = l.post_id
JOIN dim_date d ON p.post_date = d.full_date
LEFT JOIN raw_likes pv ON p.post_id = pv.post_id AND pv.like_date = d.full_date
GROUP BY p.post_id, d.date_id;

-- Membuat tabel fakta fact_daily_posts
CREATE TABLE fact_daily_posts (
  daily_posts_id SERIAL PRIMARY KEY,
  user_id INT,
  date_id INT,
  num_posts INT
);
SELECT
  p.user_id,
  d.date_id,
  COUNT(p.post_id) AS num_posts
FROM raw_posts p
JOIN dim_date d ON p.post_date = d.full_date
GROUP BY p.user_id, d.date_id;

-- Insert sample data
INSERT INTO raw_users
VALUES
(1, 'john_doe', 'Canada'),
(2, 'jane_smith', 'USA'),
(3, 'bob_johnson', 'UK');
INSERT INTO raw_posts
VALUES
(101, 'My first post!', '2020-01-01', 1),
(102, 'Having fun learning SQL', '2020-01-02', 2),
(103, 'Big data is cool', '2020-01-03', 1),
(104, 'Just joined this platform', '2020-01-04', 3),
(105, 'Whats everyone up to today?', '2020-01-05', 2),
(106, 'Data science is the future', '2020-01-06', 1),
(107, 'Practicing my SQL skills', '2020-01-07', 2),
(108, 'Hows the weather where you are?', '2020-01-08', 3),
(109, 'TGI Friday!', '2020-01-09', 1),
(110, 'Any big plans for the weekend?', '2020-01-10', 2);
INSERT INTO raw_likes
VALUES
(1001, 1, 101, '2020-01-01',),
(1002, 3, 101, '2020-01-02'),
(1003, 2, 102, '2020-01-03'),
(1004, 1, 103, '2020-01-04'),
(1005, 3, 104, '2020-01-05'),
(1006, 2, 104, '2020-01-06'),
(1007, 1, 105, '2020-01-07'),
(1008, 2, 106, '2020-01-08'),
(1009, 3, 107, '2020-01-09'),
(1010, 1, 108, '2020-01-10'),
(1011, 2, 109, '2020-01-11'),
(1012, 3, 110, '2020-01-12');

INSERT INTO fact_post_performance
(10, 101, '2020-01-01', 200, 201),
(10, 102, '2020-01-02', 300, 325),
(10, 103, '2020-01-03', 333, 299),
(09, 104, '2020-01-04', 299, 55),
(05, 105, '2020-01-05', 200, 33),
(03, 106  '2020-01-06', 100, 50),
(01, 107, '2020-01-07', 10, 05),
(10, 108, '2020-01-08', 300, 200),
(09, 109, '2020-01-09', 222, 222),
(08, 110, '2020-01-10', 100, 90);

CREATE TABLE fact_daily_posts
('My first post!', 1, '2020-01-01',1),
('Having fun learning SQL', 2, '2020-01-02', 2),
('Big data is cool', 1, '2020-01-03',3),
('Just joined this platform', 3, '2020-01-04', 4),
('Whats everyone up to today?', 2,'2020-01-05', 5 ),
('Data science is the future', 1, '2020-01-06', 6),
('Practicing my SQL skills', 2, '2020-01-07', 7),
('Hows the weather where you are?', 3, '2020-01-08', 8),
( 'TGI Friday!', 1, '2020-01-09',) 9,
('Any big plans for the weekend?', 2, '2020-01-10', 10);
