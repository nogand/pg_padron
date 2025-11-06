--
-- PostgreSQL database dump
--

\restrict bTGvIbn1cPZ6zuVf0cAEgQphEl76ZA5mP3jBGX5gOe46Re6dUMfwABkOsl013Hp

-- Dumped from database version 15.14
-- Dumped by pg_dump version 15.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;



SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: canton; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.canton (
    provincia character(1) NOT NULL,
    codigo character(2) NOT NULL,
    nombre character varying(22)
);


ALTER TABLE public.canton OWNER TO admin;

--
-- Name: ciudadano; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ciudadano (
    cedula character(9) NOT NULL,
    vencimiento date,
    nombre character varying(30),
    apellido1 character varying(26),
    apellido2 character varying(26),
    provincia character(1),
    canton character(2),
    distrito character(3),
    junta numeric(5,0)
);


ALTER TABLE public.ciudadano OWNER TO admin;

--
-- Name: distrito; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.distrito (
    provincia character(1) NOT NULL,
    canton character(2) NOT NULL,
    codigo character(3) NOT NULL,
    nombre character varying(34)
);


ALTER TABLE public.distrito OWNER TO admin;

--
-- Name: provincia; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.provincia (
    codigo character(1) NOT NULL,
    nombre character varying(10)
);


ALTER TABLE public.provincia OWNER TO admin;

--
-- Name: datos_gen; Type: VIEW; Schema: public; Owner: admin
--

CREATE VIEW public.datos_gen AS
 SELECT c.cedula,
    (((((c.nombre)::text || ' '::text) || (c.apellido1)::text) || ' '::text) || (c.apellido2)::text) AS nombre,
    p.nombre AS provincia,
    can.nombre AS canton,
    d.nombre AS distrito
   FROM public.ciudadano c,
    public.provincia p,
    public.canton can,
    public.distrito d
  WHERE ((c.provincia = d.provincia) AND (c.canton = d.canton) AND (c.distrito = d.codigo) AND (can.provincia = p.codigo) AND (d.provincia = p.codigo) AND (d.canton = can.codigo));


ALTER TABLE public.datos_gen OWNER TO admin;


--
-- Name: canton canton_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.canton
    ADD CONSTRAINT canton_pkey PRIMARY KEY (provincia, codigo);


--
-- Name: ciudadano ciudadano_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ciudadano
    ADD CONSTRAINT ciudadano_pkey PRIMARY KEY (cedula);


--
-- Name: distrito distrito_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.distrito
    ADD CONSTRAINT distrito_pkey PRIMARY KEY (provincia, canton, codigo);


--
-- Name: provincia provincia_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT provincia_pkey PRIMARY KEY (codigo);



--
-- Name: canton canton_provincia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.canton
    ADD CONSTRAINT canton_provincia_fkey FOREIGN KEY (provincia) REFERENCES public.provincia(codigo);


--
-- Name: ciudadano ciudadano_provincia_canton_distrito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ciudadano
    ADD CONSTRAINT ciudadano_provincia_canton_distrito_fkey FOREIGN KEY (provincia, canton, distrito) REFERENCES public.distrito(provincia, canton, codigo);


--
-- Name: distrito distrito_provincia_canton_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.distrito
    ADD CONSTRAINT distrito_provincia_canton_fkey FOREIGN KEY (provincia, canton) REFERENCES public.canton(provincia, codigo);


--
-- PostgreSQL database dump complete
--

\unrestrict bTGvIbn1cPZ6zuVf0cAEgQphEl76ZA5mP3jBGX5gOe46Re6dUMfwABkOsl013Hp

