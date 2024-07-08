CREATE EXTENSION POSTGIS;
CREATE EXTENSION POSTGIS_TOPOLOGY;

CREATE TABLE MAPS (name varchar, geom geometry);

INSERT INTO MAPS VALUES
('Home', 'POINT(-118.292509 34.032982)'),
('Doheny', 'POINT(-118.284189 34.020406)'),
('Hoose', 'POINT(-118.286768 34.018786)'),
('Leavy', 'POINT(-118.283086 34.021612)'),
('RTHCafe', 'POINT(-118.290032 34.020037)'),
('GouldCafe', 'POINT(-118.284370 34.018524)'),
('AnnenbergCafe', 'POINT(-118.287193 34.020968)'),
('CarolynFountain', 'POINT(-118.283478 34.020491)'),
('RTCCFountain', 'POINT(-118.286186 34.020292)'),
('GerontologyFnt', 'POINT(-118.290590 34.020237)'),
('SAL', 'POINT(-118.289295 34.019397)'),
('THH', 'POINT(-118.284626 34.022409)'),
('SGM', 'POINT(-118.289008 34.021643)');


--Convex Hull Query
SELECT ST_AsText(ST_ConvexHull(ST_Collect(geom))) FROM MAPS;

--4 Nearest Neighbours Query
SELECT name, ST_Astext(geom) as location, ST_Distance(geom,'POINT(-118.292509 34.032982)') as distance 
FROM MAPS
WHERE name <> 'Home'
ORDER BY ST_Distance(geom,'POINT(-118.292509 34.032982)') 
LIMIT 4;





