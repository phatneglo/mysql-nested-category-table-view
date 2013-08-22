A Very Smart MYSQL VIEW for Nested Multilevel Category Structure
================================

This query allows you to have a good view on your nested category structure this is a good solution 
if you are trying to display a good list for your website it can give you something like this 

<b>EXAMPLE<b>
<pre>
  Asia
  --| Korea
  --| Philippines
  ------| Manila
  ------| Pampanga
  ---------| Angeles City
  ---------| San Fernando
  --| Singapore
  North America
  --| Mexico
  --| United States
  ------| Colorado
  ------| New York
  ---------| Kingston
  ---------| Poughkeepsie-Newburgh
</pre>
<br>
A good solution for breadcrumbs or if you want to create a category tree
or a good listing for your backend.


<b>ORIGNAL TABLE DATA</b><br>
<pre>
SELECT * FROM categories

+-------------+-----------------------+-------------+-----------+
| category_id | category              | description | parent_id |
+-------------+-----------------------+-------------+-----------+
|           1 | Asia                  | NULL        |         0 |
|           2 | North America         | NULL        |         0 |
|           3 | Philippines           | NULL        |         1 |
|           4 | Singapore             | NULL        |         1 |
|           5 | Korea                 | NULL        |         1 |
|           6 | United States         | NULL        |         2 |
|           7 | Mexico                | NULL        |         2 |
|           8 | New York              | NULL        |         6 |
|           9 | Colorado              | NULL        |         6 |
|          10 | Manila                | NULL        |         3 |
|          11 | Pampanga              | NULL        |         3 |
|          12 | Angeles City          | NULL        |        11 |
|          13 | San Fernando          | NULL        |        11 |
|          14 | Kingston              | NULL        |         8 |
|          15 | Poughkeepsie-Newburgh | NULL        |         8 |
+-------------+-----------------------+-------------+-----------+
15 rows in set (0.07 sec)
</pre>

<b>VIEW QUERY Examples</b>
<pre>
SELECT 
  other_cat_view.CatID,
  other_cat_view.CatName,
  other_cat_view.ParentID,
  other_cat_view.CatLevel
FROM
  other_cat_view

+-------+-----------------------+----------+----------+
| CatID | CatName               | ParentID | CatLevel |
+-------+-----------------------+----------+----------+
|     1 | Asia                  |        0 |        1 |
|     5 | Korea                 |        1 |        2 |
|     3 | Philippines           |        1 |        2 |
|    10 | Manila                |        3 |        3 |
|    11 | Pampanga              |        3 |        3 |
|    12 | Angeles City          |       11 |        4 |
|    13 | San Fernando          |       11 |        4 |
|     4 | Singapore             |        1 |        2 |
|     2 | North America         |        0 |        1 |
|     7 | Mexico                |        2 |        2 |
|     6 | United States         |        2 |        2 |
|     9 | Colorado              |        6 |        3 |
|    14 | Kingston              |        6 |        3 |
|     8 | New York              |        8 |        3 |
|    15 | Poughkeepsie-Newburgh |        8 |        3 |
+-------+-----------------------+----------+----------+
15 rows in set (0.01 sec)
</pre>

<pre>
SELECT 
  other_cat_view.CatID,
  other_cat_view.ParentID,
  other_cat_view.CatCaption
FROM
  other_cat_view

+-------+----------+------------------------------------------------------------------+
| CatID | ParentID | CatCaption                                                       |
+-------+----------+------------------------------------------------------------------+
|     1 |        0 | Asia                                                             |
|     5 |        1 | Asia > Korea                                                     |
|     3 |        1 | Asia > Philippines                                               |
|    10 |        3 | Asia > Philippines > Manila                                      |
|    11 |        3 | Asia > Philippines > Pampanga                                    |
|    12 |       11 | Asia > Philippines > Pampanga > Angeles City                     |
|    13 |       11 | Asia > Philippines > Pampanga > San Fernando                     |
|     4 |        1 | Asia > Singapore                                                 |
|     2 |        0 | North America                                                    |
|     7 |        2 | North America > Mexico                                           |
|     6 |        2 | North America > United States                                    |
|     9 |        6 | North America > United States > Colorado                         |
|     8 |        6 | North America > United States > New York                         |
|    14 |        8 | North America > United States > New York > Kingston              |
|    15 |        8 | North America > United States > New York > Poughkeepsie-Newburgh |
+-------+----------+------------------------------------------------------------------+
15 rows in set (0.01 sec)
</pre>

