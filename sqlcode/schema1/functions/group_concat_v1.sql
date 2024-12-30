CREATE AGGREGATE dvdrental.group_concat(text) (
	SFUNC = _group_concat,
	STYPE = text
);