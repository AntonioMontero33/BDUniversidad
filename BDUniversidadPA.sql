-- Procedimientos almacenados
-- Anton Montero
-- 8 Agosto 2022

--PA para TEscuela
use BDUniversidad
go

if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go
create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go


if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go
create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	-- CodEscuela no puede ser duplicado:
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		if not exists (select Escuela from TEscuela where Escuela=@Escuela)
			begin
				insert into TEscuela values(@CodEscuela, @Escuela, @Facultad)
				select CodError = 0, Mensaje = 'Se Inserto correctamente la nueva escuela'
			end
		else select CodError = 1, Mensaje = 'Error: Escuela Duplicada'
	else select CodError=1, Mensaje = 'Error: Codigo de Escuela duplicado'
	-- Escuela no puede ser duplicado

end
go





-- Actividad: Implementar Eliminar, Actualizar y Buscar
--Presentado para el dia miercoles 10 de agosto a traves de aula virtual



-- Eliminar Escuela
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create proc spEliminarEscuela
@CodEscuela char(3)
as
begin
	-- CodEscuela no puede ser duplicado:
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
	begin
		delete from TEscuela where CodEscuela=@CodEscuela
		select CodError=0, Mensaje = 'Escuela Borrada'
	end
	else select CodError=1, Mensaje = 'Error: Codigo de Escuela no encontrado'

end
go



--Actualizar Escuela

if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go
create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	-- CodEscuela no puede ser duplicado:
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
	begin
		update TEscuela
		set Escuela = @Escuela, Facultad= @Facultad
		where CodEscuela = @CodEscuela;
		select CodError=0, Mensaje = 'Datos Actualizados'
		select CodEscuela, Escuela, Facultad from TEscuela where CodEscuela=@CodEscuela
	end
	else select CodError=1, Mensaje = 'Error: Codigo de Escuela no encontrado'
end
go


if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create proc spBuscarEscuela
@CodEscuela char(3)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
	begin
		select CodEscuela, Escuela, Facultad from TEscuela where CodEscuela=@CodEscuela
	end
end
go


exec spListarEscuela
exec spAgregarEscuela @CodEscuela = 'E01', @Escuela = 'Sistemas', @Facultad = 'Ingenieria'
exec spBuscarEscuela @CodEscuela = 'E01'
exec spActualizarEscuela @CodEscuela = 'E01', @Escuela = 'Psico', @Facultad = 'ciencias humanas'
exec spEliminarEscuela @CodEscuela = 'E01'




-- Tabla Alumno
if OBJECT_ID('spListarAlumnos') is not null
	drop proc spListarAlumnos
go
create proc spListarAlumnos
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac CodEscuela from TAlumno
end
go


if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go
create proc spAgregarAlumno
@CodAlumno char(5),	@Apellidos varchar(50),	@Nombres varchar(50),	@LugarNac varchar(50),	@FechaNac datetime,	@CodEscuela char(3)
as
begin
	-- CodEscuela no puede ser duplicado:
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		if not exists (select Apellidos from TAlumno where Apellidos=@Apellidos)
			begin
				insert into TAlumno values(@CodAlumno,@Apellidos,@Nombres,@LugarNac,@FechaNac,@CodEscuela)
				select CodError = 0, Mensaje = 'Se Inserto correctamente la nuevo alumno'
			end
		else select CodError = 1, Mensaje = 'Error: Alumno Duplicada'
	else select CodError=1, Mensaje = 'Error: Codigo de Alumno duplicado'
	-- Escuela no puede ser duplicado

end
go





-- Actividad: Implementar Eliminar, Actualizar y Buscar
--Presentado para el dia miercoles 10 de agosto a traves de aula virtual



-- Eliminar Alumno
if OBJECT_ID('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go
create proc spEliminarAlumno
@CodAlumno char(5)
as
begin
	-- CodEscuela no puede ser duplicado:
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
	begin
		delete from TAlumno where CodAlumno=@CodAlumno
		select CodError=0, Mensaje = 'Alumno Borrado'
	end
	else select CodError=1, Mensaje = 'Error: Codigo de Alumno no encontrado'

end
go



--Actualizar Alumno

if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go
create proc spActualizarAlumno
@CodAlumno char(5),	@Apellidos varchar(50),	@Nombres varchar(50),	@LugarNac varchar(50),	@FechaNac datetime,	@CodEscuela char(3)
as
begin
	-- CodEscuela no puede ser duplicado:
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
	begin
		update TAlumno
		set Apellidos = @Apellidos, Nombres= @Nombres, LugarNac= @LugarNac, FechaNac=@FechaNac, CodEscuela=@CodEscuela
		where CodAlumno = @CodAlumno;
		select CodError=0, Mensaje = 'Datos Actualizados'
		select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno where CodAlumno=@CodAlumno
	end
	else select CodError=1, Mensaje = 'Error: Codigo de Alumno no encontrado'
end
go



-- Buscar Alumno
if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go
create proc spBuscarAlumno
@CodAlumno char(5)
as
begin
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
	begin
		select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno where CodAlumno=@CodAlumno
	end
end
go


exec spListarAlumnos
exec spAgregarAlumno @CodAlumno = 'A0001',@Apellidos = 'Montero',	@Nombres ='Jose',	@LugarNac ='Cusco',	@FechaNac = '20120618 10:34:09 AM', @CodEscuela = 'E01'
exec spBuscarAlumno @CodAlumno = 'A0001'
exec spActualizarAlumno @CodAlumno = 'A0001',@Apellidos = 'Montero',	@Nombres ='Antonio',	@LugarNac ='Lima',	@FechaNac = '16-01-2002',@CodEscuela = 'E03'
exec spEliminarAlumno @CodAlumno = 'A0001'