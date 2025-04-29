# assignment2



#assignment11 neo4j queries


this is for the files
 LOAD CSV WITH HEADERS FROM 'file:///papers.csv' AS row
MERGE (p:Paper {paper_id: row.paper_id})
SET p.filename = row.filename,
    p.title = row.title,
    p.booktitle = row.booktitle,
    p.authors = row.authors


    
 LOAD CSV WITH HEADERS FROM 'file:///authors.csv' AS row
WITH row WHERE trim(row.author) IS NOT NULL AND trim(row.author) <> ""
MERGE (a:Author {name: row.author})
MERGE (p:Paper {paper_id: row.paper_id})
MERGE (a)-[:WROTE]->(p)



 MATCH (p:Paper {paper_id: "100"})
OPTIONAL MATCH (a:Author)-[:WROTE]->(p)
OPTIONAL MATCH (p)-[:CITES]->(cited:Paper)
RETURN p, a, cited



and this are queries

List All AuthorsMATCH (a:Author)
RETURN a.name AS Author;


MATCH (p:Paper)
RETURN p.paper_id, p.title, p.filename, p.booktitle;


 MATCH (a:Author)-[:WROTE]->(p:Paper)
RETURN a.name AS Author, p.title AS PaperTitle
ORDER BY a.name;


 MATCH (a:Author {name: "Author Name"})-[:WROTE]->(p:Paper)
RETURN p.title, p.paper_id, p.filename;


 MATCH (a:Author)-[:WROTE]->(p:Paper)
RETURN a.name AS Author, count(p) AS NumberOfPapers
ORDER BY NumberOfPapers DESC;



 MATCH (a:Author)
RETURN a.name AS Author;




#assignment 12


 CREATE (:TrainStation {
  city: 'Copenhagen',
  lat: 55.672874,
  lon: 12.56459
});


 CREATE (:Office {
  city: 'Malmo',
  lat: 55.611784,
  lon: 12.994341
});


 UNWIND range(1, 10000) AS id
CREATE (:Location {
  name: 'Location_' + id,
  lat: 55.5 + rand() * 0.5,
  lon: 12.5 + rand() * 0.5
});


 MATCH (t:TrainStation), (l:Location)
WHERE point.distance(
  point({latitude: t.lat, longitude: t.lon}),
  point({latitude: l.lat, longitude: l.lon})
) < 10000
MERGE (t)-[:TRAVEL_ROUTE]->(l);


 MATCH (o:Office), (l:Location)
WHERE point.distance(
  point({latitude: o.lat, longitude: o.lon}),
  point({latitude: l.lat, longitude: l.lon})
) < 10000
MERGE (o)-[:TRAVEL_ROUTE]->(l);

 MATCH (t:TrainStation), (l:Location)
RETURN l.name,
       round(point.distance(point({latitude: t.lat, longitude: t.lon}), point({latitude: l.lat, longitude: l.lon}))) AS distance_meters
ORDER BY distance_meters ASC
LIMIT 5;


 MATCH (a)-[r:TRAVEL_ROUTE]->(b)
RETURN a, r, b LIMIT 100;
