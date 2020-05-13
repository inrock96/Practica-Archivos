
/* ¿CUANTOS PROYECTOS INICIARON EN 2011 */
SELECT COUNT(*) FROM PROJECT p
WHERE p.transaction_start_year=2011;

/*CUAL FUE EL PROYECTO DE MAYOR DURACION*/
SELECT p.project_id,p.project_title,p.start_actual_isodate,p.end_actual_isodate, datediff(p.end_actual_isodate,p.start_actual_isodate ) as Tiempo 
FROM PROJECT p 
order by Tiempo desc
limit 1
;


/*CUAL FUE EL PROYECTO DE MENOR DURACION*/
	SELECT p.project_id,p.project_title,p.start_actual_isodate,p.end_actual_isodate, datediff(p.end_actual_isodate,p.start_actual_isodate ) as Tiempo FROM PROJECT p 
	where datediff(p.end_actual_isodate,p.start_actual_isodate )>0
	order by Tiempo ASC
	LIMIT 1
	;

/*Top 5 de países con más proyectos*/
SELECT c.name_ as Pais, count(p.project_id) as No_Proyectos
FROM COUNTRY_CODE c, PROJECT p
WHERE c.country_id = p.country_id
GROUP BY c.name_
order by No_Proyectos desc
LIMIT 5
;

/*Top 5 de países con menos proye*/
SELECT c.name_ as Pais, count(p.project_id) as No_Proyectos
FROM COUNTRY_CODE c, PROJECT p
WHERE c.country_id = p.country_id
GROUP BY c.name_
order by No_Proyectos ASC
LIMIT 5
;
/*CUAL FUE EL PROYECTO  CON MAS COSTO*/
SELECT p.project_title, sum(t.transaction_value)as Costo_total
FROM PROJECT p, TRANSACCION t
WHERE p.project_id=t.project_id
GROUP BY p.project_title
ORDER BY Costo_total DESC
LIMIT 1
;

/*CUAL FUE EL PROYECTO  MENOS COSTOSO*/
SELECT p.project_title, sum(t.transaction_value)as Costo_total
FROM PROJECT p, TRANSACCION t
WHERE p.project_id=t.project_id
GROUP BY p.project_title
ORDER BY Costo_total ASC
LIMIT 1
;


/*TOP 5 DE PROYECTOS MAS COSTOSOS*/
SELECT p.project_title, sum(t.transaction_value)as Costo_total
FROM PROJECT p, TRANSACCION t
WHERE p.project_id=t.project_id
GROUP BY p.project_title
ORDER BY Costo_total DESC
LIMIT 5
;
/*COSTO TOTAL DE TODOS LOS PROYECTOS*/
SELECT sum(t.transaction_value)as Costo_total_proyectos_USD
FROM TRANSACCION t
ORDER BY Costo_total_proyectos_USD DESC;

/*	TOP 3 DE LAS TRANSACCIONES MAS COSTOSAS RI_EAST AFRICA 
	PUBLIC HEALTH LABORATORY NETWORKING PROJECT
*/
SELECT p.project_title,t.transaction_value as TRANSACCIONES_MAS_COSTOSAS 
FROM PROJECT p, TRANSACCION t
WHERE p.project_id = t.project_id
AND project_title LIKE '%RI_EAST AFRICA PUBLIC HEALTH LABORATORY NETWORKING PROJECT%'
LIMIT 3
;