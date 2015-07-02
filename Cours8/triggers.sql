-- Empêcher la suppression sur la table artiste.
create or replace trigger artiste_empecherSuppression
before delete on artiste
for each row
begin
  raise_application_error(-20100, 'Suppression impossible sur la table artiste');
end;
/

create or replace trigger artiste_empecherModification
before update on artiste
referencing
  old as avant
for each row
declare
  nombre number;
begin
  select count(*)
  into nombre
  from album
  where artiste_id = avant.id;

  if nombre > 0 then
    raise_application_error(-20111, 'Impossible de modifier un artiste qui a des albums');
  end if;
end;
/
