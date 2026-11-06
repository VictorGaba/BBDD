SELECT 
    *
FROM
    alumnos
        JOIN
    matriculas USING (id_alumno)
        JOIN
    cursos USING (id_curso);
    
    
    
    SELECT 
    *
FROM
    alumnos a
        JOIN
    matriculas m ON a.id_alumno = m.id_alumno
        JOIN
    cursos c ON m.id_curso = c.id_curso;
    
    SELECT 
    *
FROM
    alumnos a
       left JOIN
    matriculas m ON a.id_alumno = m.id_alumno;
    
-- APUNTES

SELECT 
    *
FROM
    matriculas m
        LEFT JOIN
    alumnos a ON m.id_alumno = a.id_alumno
        LEFT JOIN
    cursos c ON c.id_curso = m.id_curso; 
    
    SELECT 
    *
FROM
    matriculas m
        LEFT JOIN
    alumnos a ON m.id_alumno = a.id_alumno
        RIGHT JOIN
    cursos c ON c.id_curso = m.id_curso; 
    
    -- Saca el listado de matriculas en cursos inexistentes
   
    SELECT 
*
FROM
    matriculas m
        left JOIN
    cursos c ON m.id_curso = c.id_curso
    where c.id_curso is null;
    
    -- Saca el listado de cursos sin matricula
    
    SELECT 
    *
FROM
    cursos c
        LEFT JOIN
    matriculas m ON m.id_curso = c.id_curso
WHERE
    m.id_matricula IS NULL;
    
    -- alumnos matriculados en cursos inexistentes
    
      SELECT 
    *
FROM
    alumnos a
        JOIN
    matriculas m ON a.id_alumno = m.id_alumno
        LEFT JOIN
    cursos c ON m.id_curso = c.id_curso
WHERE
    c.id_curso IS NULL;
    
    -- matriculas de alumnos inexistentes
    
    SELECT 
    *
FROM
    matriculas m
        left JOIN
    alumnos a ON m.id_alumno = a.id_alumno
    where a.id_alumno is null;