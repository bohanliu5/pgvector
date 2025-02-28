SET enable_seqscan = off;

CREATE TABLE t (val vector(3));
INSERT INTO t (val) VALUES ('[0,0,0]'), ('[1,2,3]'), ('[1,1,1]'), (NULL);
CREATE INDEX ON t USING ivf (val vector_l2_ops) WITH (lists = 1, quantizer = 'SQ8');

INSERT INTO t (val) VALUES ('[1,2,4]');

SELECT * FROM t ORDER BY val <-> '[3,3,3]';
SELECT * FROM t ORDER BY val <-> (SELECT NULL::vector);
SELECT COUNT(*) FROM t;

DROP TABLE t;
