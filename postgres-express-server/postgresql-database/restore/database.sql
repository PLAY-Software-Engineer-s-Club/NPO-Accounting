PGDMP     1                    {           play-accounting    15.3    15.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    16399    play-accounting    DATABASE     �   CREATE DATABASE "play-accounting" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Canada.1252';
 !   DROP DATABASE "play-accounting";
                ihsan    false            �            1259    16401    donors    TABLE     x  CREATE TABLE public.donors (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    postcode character varying(255),
    phone character varying(255),
    email character varying(255),
    donor_area integer,
    donor_group integer,
    promised_amount numeric,
    promised_date date
);
    DROP TABLE public.donors;
       public         heap    postgres    false            �            1259    16400    donors_id_seq    SEQUENCE     �   CREATE SEQUENCE public.donors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.donors_id_seq;
       public          postgres    false    215            "           0    0    donors_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.donors_id_seq OWNED BY public.donors.id;
          public          postgres    false    214            �            1259    16424    expenses    TABLE     :  CREATE TABLE public.expenses (
    id integer NOT NULL,
    expense_name character varying(255),
    payment_method character varying(255),
    expense_category character varying(255),
    payee_information character varying(255),
    expense_amount numeric,
    expense_date date,
    expense_description text
);
    DROP TABLE public.expenses;
       public         heap    postgres    false            �            1259    16423    expenses_id_seq    SEQUENCE     �   CREATE SEQUENCE public.expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.expenses_id_seq;
       public          postgres    false    219            #           0    0    expenses_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;
          public          postgres    false    218            �            1259    16410    incomes    TABLE       CREATE TABLE public.incomes (
    id integer NOT NULL,
    income_category character varying(255),
    payment_method character varying(255),
    income_amount numeric,
    income_date date,
    income_source_name character varying(255),
    donor_id integer,
    description text
);
    DROP TABLE public.incomes;
       public         heap    postgres    false            �            1259    16409    incomes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.incomes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.incomes_id_seq;
       public          postgres    false    217            $           0    0    incomes_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.incomes_id_seq OWNED BY public.incomes.id;
          public          postgres    false    216            �            1259    16445    monthly_donations    VIEW     �  CREATE VIEW public.monthly_donations AS
 SELECT date_trunc('month'::text, (incomes.income_date)::timestamp with time zone) AS month,
    sum(incomes.income_amount) AS total_donations
   FROM public.incomes
  WHERE ((incomes.income_category)::text = 'donation'::text)
  GROUP BY (date_trunc('month'::text, (incomes.income_date)::timestamp with time zone))
  ORDER BY (date_trunc('month'::text, (incomes.income_date)::timestamp with time zone));
 $   DROP VIEW public.monthly_donations;
       public          postgres    false    217    217    217            �            1259    16441    monthly_expense    VIEW     �  CREATE VIEW public.monthly_expense AS
 SELECT date_trunc('month'::text, (expenses.expense_date)::timestamp with time zone) AS month,
    sum(expenses.expense_amount) AS total_expense
   FROM public.expenses
  GROUP BY (date_trunc('month'::text, (expenses.expense_date)::timestamp with time zone))
  ORDER BY (date_trunc('month'::text, (expenses.expense_date)::timestamp with time zone));
 "   DROP VIEW public.monthly_expense;
       public          postgres    false    219    219            �            1259    16432    monthly_income    VIEW     !  CREATE VIEW public.monthly_income AS
 SELECT date_trunc('month'::text, (incomes.income_date)::timestamp with time zone) AS month,
    sum(incomes.income_amount) AS total_income
   FROM public.incomes
  GROUP BY (date_trunc('month'::text, (incomes.income_date)::timestamp with time zone));
 !   DROP VIEW public.monthly_income;
       public          postgres    false    217    217            {           2604    16404 	   donors id    DEFAULT     f   ALTER TABLE ONLY public.donors ALTER COLUMN id SET DEFAULT nextval('public.donors_id_seq'::regclass);
 8   ALTER TABLE public.donors ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            }           2604    16427    expenses id    DEFAULT     j   ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);
 :   ALTER TABLE public.expenses ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            |           2604    16413 
   incomes id    DEFAULT     h   ALTER TABLE ONLY public.incomes ALTER COLUMN id SET DEFAULT nextval('public.incomes_id_seq'::regclass);
 9   ALTER TABLE public.incomes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217                      0    16401    donors 
   TABLE DATA           �   COPY public.donors (id, first_name, last_name, address, postcode, phone, email, donor_area, donor_group, promised_amount, promised_date) FROM stdin;
    public          postgres    false    215   C$                 0    16424    expenses 
   TABLE DATA           �   COPY public.expenses (id, expense_name, payment_method, expense_category, payee_information, expense_amount, expense_date, expense_description) FROM stdin;
    public          postgres    false    219   k&                 0    16410    incomes 
   TABLE DATA           �   COPY public.incomes (id, income_category, payment_method, income_amount, income_date, income_source_name, donor_id, description) FROM stdin;
    public          postgres    false    217   !(       %           0    0    donors_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.donors_id_seq', 18, true);
          public          postgres    false    214            &           0    0    expenses_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.expenses_id_seq', 11, true);
          public          postgres    false    218            '           0    0    incomes_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.incomes_id_seq', 20, true);
          public          postgres    false    216                       2606    16408    donors donors_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.donors
    ADD CONSTRAINT donors_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.donors DROP CONSTRAINT donors_pkey;
       public            postgres    false    215            �           2606    16431    expenses expenses_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.expenses DROP CONSTRAINT expenses_pkey;
       public            postgres    false    219            �           2606    16417    incomes incomes_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.incomes
    ADD CONSTRAINT incomes_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.incomes DROP CONSTRAINT incomes_pkey;
       public            postgres    false    217            �           2606    16418    incomes fk_donor_id    FK CONSTRAINT     t   ALTER TABLE ONLY public.incomes
    ADD CONSTRAINT fk_donor_id FOREIGN KEY (donor_id) REFERENCES public.donors(id);
 =   ALTER TABLE ONLY public.incomes DROP CONSTRAINT fk_donor_id;
       public          postgres    false    215    3199    217                 x�m��n�0E�ï��)Q��_��8@6�L%�b,��G��%�&��Z�����řak���u�[�C^����I*���2fj����\����JZ�`�D<��,3V�6�jP����Vp�h%k4�̸cr��=JO!:B;0$��qUv��(�7��ʮf�T�j<�]=ڟ��$��䈜�lHN	K�;ia���|��͹�������f'��!\������-8@����W?d��)�FD�bH��@���oh��A�dx�G�{�6!8�^9$�en|������n,���ܐV>3��!� |o,����2��t�i]U�e�2�V�?�_�Ҥ�8O�8�ߪ�K�6�w��/�|􉘰�����~�m��AWj�8��!H�FO-�n얂9`��&o�Ci�Do�����s8�!J��hC� <���F_��?T/�#Z���c�\��p�a�e(�A�;���s}��݇�˵��H���]N+`k;7���9�`�f#[����_?���㫐�wJ���3�         �  x�]��N�0���S��ڎ;�HH .�x�E��8����k��%�����1,��b���*����f&�̺��'�[}��(E���"�\D�4x�40�^�=7�RN��Ӽ����~A#9��Gg�Kxv6��^��P�uφl@kl�z�~K��>�P���2v��4���n��Ѻ��kX�U�/�6_�Is��mYb�[W��ng��]��\�}G�)y�T70�n%�E�y�n���)�u;�EI!׃��w7����}�F��j*#�yAp඗s��E�*��S|���z���EG�.��S�nS�ܘ�kR	BɩYCJ��ڛR����c��􌊢-�5PA�$Q]z/;�$-�tڃ����}	H�1�������n1�ѳ�\\8Z0�eN�mecA�9�C�a�8#�9RJ��}g         J  x����n�0�ϛ�����?rl�@T��R/\L�$V�-�	*o��@1��~3��ˠ�4j��5l����R��>�|��Z|�w�*`�sg�H��=z
�D#��\�
u
o�Rd�"���hx�?��/����ՐY�/U�(Bt�0��"W��R����ű�қ 1�B3&��p �>���h{��~�L%w�]8���ђ�K��)��2,*+�q/�7��S�!@�1d��b��ـ�;�]�fX��$�K<���X
�ZٶkP�d�� �;U��J^�Wu���%�n�,��x��J#r�����ڨ�7���{�6m�Y���y�<����     