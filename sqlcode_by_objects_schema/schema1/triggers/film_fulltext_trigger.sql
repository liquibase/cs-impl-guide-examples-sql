CREATE TRIGGER film_fulltext_trigger BEFORE INSERT OR UPDATE ON "dvdrental".film FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');
