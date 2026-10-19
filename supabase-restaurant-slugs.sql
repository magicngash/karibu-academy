-- Run this once in Supabase SQL Editor.
-- It adds friendly links such as /savannah-grill while preserving UUID links.

alter table public.restaurants
  add column if not exists slug text;

create or replace function public.make_restaurant_slug()
returns trigger
language plpgsql
set search_path = public
as $$
declare
  base_slug text;
  candidate text;
begin
  base_slug := lower(regexp_replace(trim(new.name), '[^a-zA-Z0-9]+', '-', 'g'));
  base_slug := trim(both '-' from base_slug);
  if base_slug = '' then base_slug := 'restaurant'; end if;
  candidate := base_slug;

  if exists (select 1 from public.restaurants r where r.slug = candidate and r.id <> new.id) then
    candidate := base_slug || '-' || left(replace(new.id::text, '-', ''), 6);
  end if;

  new.slug := candidate;
  return new;
end;
$$;

drop trigger if exists restaurants_set_slug on public.restaurants;
create trigger restaurants_set_slug
before insert or update of name on public.restaurants
for each row execute function public.make_restaurant_slug();

update public.restaurants
set slug = trim(both '-' from lower(regexp_replace(trim(name), '[^a-zA-Z0-9]+', '-', 'g')))
where slug is null or slug = '';

create unique index if not exists restaurants_slug_unique
  on public.restaurants (slug);

create or replace function public.get_restaurant_by_slug(p_slug text)
returns jsonb
language sql
security definer
set search_path = public
as $$
  select jsonb_build_object(
    'id', r.id,
    'name', r.name,
    'app_name', r.app_name
  )
  from public.restaurants r
  where r.slug = lower(trim(p_slug))
  limit 1;
$$;

grant execute on function public.get_restaurant_by_slug(text) to anon, authenticated;
