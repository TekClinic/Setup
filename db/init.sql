--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE keycloak;
ALTER ROLE keycloak WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:K9oW7tI+l6qYtkyGEipf8w==$BilkPnNuuZwVXDchETfrNE2R0HnNM6zEQ5TvKJEEk4Q=:k5/92jyKxNHm13p7Oj4KYo1U2rJ1oyIsCkiydG9U6Us=';
COMMENT ON ROLE keycloak IS 'Keycloak user for accessing its database';
CREATE ROLE patients;
ALTER ROLE patients WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:/AnCHuPcXABqVnxCHp6R4A==$hezbV2OnjgEDhnYUu1ZnFJAWTs7lrgnkyJiVDsxQRXY=:iBz+YL8FXK/KFSWtSeldtSnM38CieWfFZiJBh5m1RYw=';

ALTER ROLE root WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:mU44hsRGMGGFGFECFEycEw==$s7cztZpXG65hJK5TMf3Hm3mWgN2w/TvxIpWuBemnwgg=:4IbZ06ZF/6aUuPyzJ8f95i8AjQ1HEa6n5N36Mi/x46w=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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

--
-- PostgreSQL database dump complete
--

--
-- Database "keycloak" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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

--
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO keycloak;

\connect keycloak

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
38697b78-1cc5-4c8b-bf6c-7b6872104e33	aaf3bb2a-2d14-4494-8bf7-7e6a94c91321
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
ad5f0b7c-9318-41c5-acc3-0ec843fc1bf3	\N	auth-cookie	319844d6-c993-472b-b6db-ed5f70b1d9fa	57cb89d6-f35d-4251-a482-6751a1ff9e30	2	10	f	\N	\N
95a95cac-cac9-4ec0-878c-956b83b91a7f	\N	auth-spnego	319844d6-c993-472b-b6db-ed5f70b1d9fa	57cb89d6-f35d-4251-a482-6751a1ff9e30	3	20	f	\N	\N
059dbf5e-21ef-413e-a4d2-ef8b87671ca8	\N	identity-provider-redirector	319844d6-c993-472b-b6db-ed5f70b1d9fa	57cb89d6-f35d-4251-a482-6751a1ff9e30	2	25	f	\N	\N
e5c6735a-cdd9-4500-bf00-290fa4a525a2	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	57cb89d6-f35d-4251-a482-6751a1ff9e30	2	30	t	a51a6c63-c864-4c66-91b8-10186b810151	\N
3ef29783-117f-4bc3-9d91-3976b977bd7a	\N	auth-username-password-form	319844d6-c993-472b-b6db-ed5f70b1d9fa	a51a6c63-c864-4c66-91b8-10186b810151	0	10	f	\N	\N
b84ec32a-02b1-476f-b6ea-9c9f44e77796	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	a51a6c63-c864-4c66-91b8-10186b810151	1	20	t	825bade7-f072-41eb-a7b4-8bc39e9375e1	\N
17461064-ab8a-46c9-a426-55028c61129a	\N	conditional-user-configured	319844d6-c993-472b-b6db-ed5f70b1d9fa	825bade7-f072-41eb-a7b4-8bc39e9375e1	0	10	f	\N	\N
62a06f39-8cfa-4086-bb48-11bdb63f9da8	\N	auth-otp-form	319844d6-c993-472b-b6db-ed5f70b1d9fa	825bade7-f072-41eb-a7b4-8bc39e9375e1	0	20	f	\N	\N
f1bac325-c1e6-4745-829d-dfe323e24128	\N	direct-grant-validate-username	319844d6-c993-472b-b6db-ed5f70b1d9fa	3728af33-c666-4428-afd6-191bdc634659	0	10	f	\N	\N
168d466e-5f0c-404f-815a-fed3aba26820	\N	direct-grant-validate-password	319844d6-c993-472b-b6db-ed5f70b1d9fa	3728af33-c666-4428-afd6-191bdc634659	0	20	f	\N	\N
26699500-6489-446a-a11e-cddb2c961729	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	3728af33-c666-4428-afd6-191bdc634659	1	30	t	6cb20edc-80bc-4bf4-9fdd-5747e8ffac50	\N
98453dea-96d0-472b-954b-a1f36efd53a8	\N	conditional-user-configured	319844d6-c993-472b-b6db-ed5f70b1d9fa	6cb20edc-80bc-4bf4-9fdd-5747e8ffac50	0	10	f	\N	\N
4afe1394-a8aa-46ef-ac9f-a9985ecf705d	\N	direct-grant-validate-otp	319844d6-c993-472b-b6db-ed5f70b1d9fa	6cb20edc-80bc-4bf4-9fdd-5747e8ffac50	0	20	f	\N	\N
68e4ec7f-b108-4047-8f00-8363835fa916	\N	registration-page-form	319844d6-c993-472b-b6db-ed5f70b1d9fa	9b4c05fc-3ab0-47a3-9fe1-e45d64ae6fc0	0	10	t	aa498e91-7c0a-4861-a41d-d694f3686131	\N
12ed1a91-213c-49de-a7b1-fe59079bfdb7	\N	registration-user-creation	319844d6-c993-472b-b6db-ed5f70b1d9fa	aa498e91-7c0a-4861-a41d-d694f3686131	0	20	f	\N	\N
24721100-fe33-4d32-974a-10ac12a2d2a4	\N	registration-password-action	319844d6-c993-472b-b6db-ed5f70b1d9fa	aa498e91-7c0a-4861-a41d-d694f3686131	0	50	f	\N	\N
02b3f63a-7c79-4a15-9220-417a5b41be06	\N	registration-recaptcha-action	319844d6-c993-472b-b6db-ed5f70b1d9fa	aa498e91-7c0a-4861-a41d-d694f3686131	3	60	f	\N	\N
9efba2e2-a97f-45c8-b02a-f1383c6ddbac	\N	registration-terms-and-conditions	319844d6-c993-472b-b6db-ed5f70b1d9fa	aa498e91-7c0a-4861-a41d-d694f3686131	3	70	f	\N	\N
8f5f342f-25a9-4768-a961-71bc65447dbd	\N	reset-credentials-choose-user	319844d6-c993-472b-b6db-ed5f70b1d9fa	20789337-b787-43a9-a684-8f2a010f7b5a	0	10	f	\N	\N
2470c59a-65bd-4d0a-9c7c-fe2d96a694ea	\N	reset-credential-email	319844d6-c993-472b-b6db-ed5f70b1d9fa	20789337-b787-43a9-a684-8f2a010f7b5a	0	20	f	\N	\N
3d7299f0-e273-4ea7-95d5-e888e1fbbcba	\N	reset-password	319844d6-c993-472b-b6db-ed5f70b1d9fa	20789337-b787-43a9-a684-8f2a010f7b5a	0	30	f	\N	\N
ff806073-7940-4e39-b674-b95caa33e723	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	20789337-b787-43a9-a684-8f2a010f7b5a	1	40	t	0943f729-b631-4c51-8955-025239857344	\N
85314273-87ab-46d5-89ed-be4142f16582	\N	conditional-user-configured	319844d6-c993-472b-b6db-ed5f70b1d9fa	0943f729-b631-4c51-8955-025239857344	0	10	f	\N	\N
ace6bf06-5a1e-4721-bd7a-20e93d42d9bd	\N	reset-otp	319844d6-c993-472b-b6db-ed5f70b1d9fa	0943f729-b631-4c51-8955-025239857344	0	20	f	\N	\N
02b36331-3c55-4e0b-bf46-3f10268de041	\N	client-secret	319844d6-c993-472b-b6db-ed5f70b1d9fa	ad9173b9-2bd4-43e8-b018-969afd04632b	2	10	f	\N	\N
2b0f35f4-599c-4dee-a18d-9a1ab13dc3b6	\N	client-jwt	319844d6-c993-472b-b6db-ed5f70b1d9fa	ad9173b9-2bd4-43e8-b018-969afd04632b	2	20	f	\N	\N
d40b9bd5-c0b8-4537-9247-2855a500836b	\N	client-secret-jwt	319844d6-c993-472b-b6db-ed5f70b1d9fa	ad9173b9-2bd4-43e8-b018-969afd04632b	2	30	f	\N	\N
48b0d291-5001-4e71-b086-ad9cae61d638	\N	client-x509	319844d6-c993-472b-b6db-ed5f70b1d9fa	ad9173b9-2bd4-43e8-b018-969afd04632b	2	40	f	\N	\N
47f3a19b-fd61-4af7-b94c-5d38471d932f	\N	idp-review-profile	319844d6-c993-472b-b6db-ed5f70b1d9fa	c49c5053-b87e-42ae-a949-9a45e70ff9f8	0	10	f	\N	12902646-d60d-4127-becb-8637b2a3a5d3
ca09b749-ff85-4062-9ce9-e109d1781381	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	c49c5053-b87e-42ae-a949-9a45e70ff9f8	0	20	t	748df98f-2670-474a-9023-4aa0e0929a21	\N
6bdf0a1b-2d69-40df-bb88-ba6de8f7b878	\N	idp-create-user-if-unique	319844d6-c993-472b-b6db-ed5f70b1d9fa	748df98f-2670-474a-9023-4aa0e0929a21	2	10	f	\N	f52970b9-646f-4219-b021-cb2a25e466ae
491a7404-91ad-40a9-8814-0a9f805b5354	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	748df98f-2670-474a-9023-4aa0e0929a21	2	20	t	1d43dbaf-08d1-47bd-9804-7f3dfa1cfc23	\N
50a985a4-f591-45ab-aac0-7e834d42dd50	\N	idp-confirm-link	319844d6-c993-472b-b6db-ed5f70b1d9fa	1d43dbaf-08d1-47bd-9804-7f3dfa1cfc23	0	10	f	\N	\N
be04d41a-ce0d-4738-9426-8ba165d8eefb	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	1d43dbaf-08d1-47bd-9804-7f3dfa1cfc23	0	20	t	fd842a0a-103d-400b-ac6b-d557dfe759c8	\N
b2ac028e-1381-425b-94ce-42acfd68608e	\N	idp-email-verification	319844d6-c993-472b-b6db-ed5f70b1d9fa	fd842a0a-103d-400b-ac6b-d557dfe759c8	2	10	f	\N	\N
2dac8b29-3ebd-470b-a456-c1a067ab79c7	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	fd842a0a-103d-400b-ac6b-d557dfe759c8	2	20	t	4ce0cece-c51a-4c82-908b-87727210e45e	\N
a6bc8431-374e-4460-976d-7e510744973e	\N	idp-username-password-form	319844d6-c993-472b-b6db-ed5f70b1d9fa	4ce0cece-c51a-4c82-908b-87727210e45e	0	10	f	\N	\N
0fe257f1-7702-4f84-8731-e800a8499c33	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	4ce0cece-c51a-4c82-908b-87727210e45e	1	20	t	e7f5bc96-0c98-4722-bd75-b71a66a17793	\N
300aba4f-2839-4ce5-8001-9935f736b3b2	\N	conditional-user-configured	319844d6-c993-472b-b6db-ed5f70b1d9fa	e7f5bc96-0c98-4722-bd75-b71a66a17793	0	10	f	\N	\N
e7ef663b-2f1b-4c23-a065-e32b4d13839e	\N	auth-otp-form	319844d6-c993-472b-b6db-ed5f70b1d9fa	e7f5bc96-0c98-4722-bd75-b71a66a17793	0	20	f	\N	\N
27351679-5b0e-4040-8b46-b16475695df4	\N	http-basic-authenticator	319844d6-c993-472b-b6db-ed5f70b1d9fa	bad19afd-6bcb-4a28-af10-f1c0195738c6	0	10	f	\N	\N
78bb5112-6ee9-425e-8b4e-7536422937f6	\N	docker-http-basic-authenticator	319844d6-c993-472b-b6db-ed5f70b1d9fa	e9794844-9966-4a60-ab86-007a6eec5793	0	10	f	\N	\N
713cadb1-213a-4b10-a944-db773f22cb0c	\N	idp-email-verification	9221edbb-59a4-49c1-a953-17a986e6ecd2	1af31be7-5d1f-4638-968b-b3a66fcd06fe	2	10	f	\N	\N
962b90ea-45ff-4ca0-922b-52ab24a43dee	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	1af31be7-5d1f-4638-968b-b3a66fcd06fe	2	20	t	84f0b6d6-cded-4a78-8e78-7788728a7e3f	\N
59bfba65-749f-4e0d-8f09-a8ae0799b9fc	\N	conditional-user-configured	9221edbb-59a4-49c1-a953-17a986e6ecd2	107bf6c1-8f3e-4510-bbaa-1d97a9a27ee8	0	10	f	\N	\N
b8944f02-63ca-42d2-9860-44178d7e7bbc	\N	auth-otp-form	9221edbb-59a4-49c1-a953-17a986e6ecd2	107bf6c1-8f3e-4510-bbaa-1d97a9a27ee8	0	20	f	\N	\N
e254f213-bcc7-408b-97cc-586f016a48ef	\N	conditional-user-configured	9221edbb-59a4-49c1-a953-17a986e6ecd2	b5adff7a-1670-4ee3-9e0d-e53f9a36b35e	0	10	f	\N	\N
995a0289-679a-48f8-8cd8-b501939fb366	\N	direct-grant-validate-otp	9221edbb-59a4-49c1-a953-17a986e6ecd2	b5adff7a-1670-4ee3-9e0d-e53f9a36b35e	0	20	f	\N	\N
559ae75e-a841-4438-8958-cd09756e2322	\N	conditional-user-configured	9221edbb-59a4-49c1-a953-17a986e6ecd2	720cc79e-3427-478a-a32b-fac664d57b80	0	10	f	\N	\N
340645e9-36e3-4cc4-ac15-2181a201d109	\N	auth-otp-form	9221edbb-59a4-49c1-a953-17a986e6ecd2	720cc79e-3427-478a-a32b-fac664d57b80	0	20	f	\N	\N
9491a9d4-cf15-4cd5-a816-4ab3a5a5c095	\N	idp-confirm-link	9221edbb-59a4-49c1-a953-17a986e6ecd2	9559ce29-679c-491e-b610-22786523fc05	0	10	f	\N	\N
78c340f1-3447-4e5d-9083-63162ef2c11f	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	9559ce29-679c-491e-b610-22786523fc05	0	20	t	1af31be7-5d1f-4638-968b-b3a66fcd06fe	\N
3dd7add4-5713-4ba6-b0ec-4e33ad828e09	\N	conditional-user-configured	9221edbb-59a4-49c1-a953-17a986e6ecd2	7fdcef7c-e8c9-4e7a-93a5-1c6cd499a23a	0	10	f	\N	\N
2467eed9-6037-4f4d-b52e-f2441efa15ca	\N	reset-otp	9221edbb-59a4-49c1-a953-17a986e6ecd2	7fdcef7c-e8c9-4e7a-93a5-1c6cd499a23a	0	20	f	\N	\N
146bba98-512a-4eda-9282-797dfceefe82	\N	idp-create-user-if-unique	9221edbb-59a4-49c1-a953-17a986e6ecd2	8c038e99-eefe-4459-9f09-97c2e74a61d5	2	10	f	\N	72e9516b-177a-4367-8d16-0c8e794c839c
5e1a1dd5-48f5-46ad-a641-d538967e1d4e	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	8c038e99-eefe-4459-9f09-97c2e74a61d5	2	20	t	9559ce29-679c-491e-b610-22786523fc05	\N
e27c14ef-aabe-4fb7-8e62-0a50f789d7df	\N	idp-username-password-form	9221edbb-59a4-49c1-a953-17a986e6ecd2	84f0b6d6-cded-4a78-8e78-7788728a7e3f	0	10	f	\N	\N
7c7b086e-3bae-4cf2-8f10-cc7ff6f48687	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	84f0b6d6-cded-4a78-8e78-7788728a7e3f	1	20	t	720cc79e-3427-478a-a32b-fac664d57b80	\N
b13b88dc-bc1c-40a4-b041-f6dc973b78ee	\N	auth-cookie	9221edbb-59a4-49c1-a953-17a986e6ecd2	749c74a4-7db2-49ee-afbc-ce72afcf5c2e	2	10	f	\N	\N
6b374418-2622-4aa5-aeb9-6ddc427aa696	\N	auth-spnego	9221edbb-59a4-49c1-a953-17a986e6ecd2	749c74a4-7db2-49ee-afbc-ce72afcf5c2e	3	20	f	\N	\N
ff0dcf1e-7653-4080-a6c6-a309f66338ac	\N	identity-provider-redirector	9221edbb-59a4-49c1-a953-17a986e6ecd2	749c74a4-7db2-49ee-afbc-ce72afcf5c2e	2	25	f	\N	\N
f2b67a2f-d48f-4e62-a582-7b25b16d87ad	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	749c74a4-7db2-49ee-afbc-ce72afcf5c2e	2	30	t	b861502e-55b0-401b-87d9-fa91221e0a83	\N
e54effff-1e5d-48a4-b8f4-803b35daf481	\N	client-secret	9221edbb-59a4-49c1-a953-17a986e6ecd2	3f7c1906-4d20-4492-b82f-be9c3da6a4f4	2	10	f	\N	\N
433eb7da-5c75-4f2a-9856-9da24b9f2ab2	\N	client-jwt	9221edbb-59a4-49c1-a953-17a986e6ecd2	3f7c1906-4d20-4492-b82f-be9c3da6a4f4	2	20	f	\N	\N
205e543f-39c7-4f2d-b33f-a584e5c165c2	\N	client-secret-jwt	9221edbb-59a4-49c1-a953-17a986e6ecd2	3f7c1906-4d20-4492-b82f-be9c3da6a4f4	2	30	f	\N	\N
321f3b5b-666b-444b-a277-424ed8692333	\N	client-x509	9221edbb-59a4-49c1-a953-17a986e6ecd2	3f7c1906-4d20-4492-b82f-be9c3da6a4f4	2	40	f	\N	\N
1b2e99db-7d06-4f5f-9889-fba9ca759b2b	\N	direct-grant-validate-username	9221edbb-59a4-49c1-a953-17a986e6ecd2	acd97203-4669-4ec5-8c6a-aea8cca25fde	0	10	f	\N	\N
d67f8bcf-3405-4580-815a-8f61f03e5405	\N	direct-grant-validate-password	9221edbb-59a4-49c1-a953-17a986e6ecd2	acd97203-4669-4ec5-8c6a-aea8cca25fde	0	20	f	\N	\N
b15914c9-c6ee-42c2-a6ef-4f7b7ecf9947	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	acd97203-4669-4ec5-8c6a-aea8cca25fde	1	30	t	b5adff7a-1670-4ee3-9e0d-e53f9a36b35e	\N
9b395555-c7ae-435f-a307-49d1eacdcee3	\N	docker-http-basic-authenticator	9221edbb-59a4-49c1-a953-17a986e6ecd2	5be9a2cc-9bb6-4e50-815e-1990eef2eaf5	0	10	f	\N	\N
80c8b66f-af6f-40a5-9b59-5b68b7c647b9	\N	idp-review-profile	9221edbb-59a4-49c1-a953-17a986e6ecd2	6d1caa14-b20f-44a6-a101-31643f4295d4	0	10	f	\N	44791bb6-21c6-46c5-b110-3b195debc770
3bc7ea43-5d23-498b-9d1c-19a5b6e17fe7	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	6d1caa14-b20f-44a6-a101-31643f4295d4	0	20	t	8c038e99-eefe-4459-9f09-97c2e74a61d5	\N
b402ce12-4ae9-4cb6-927e-dd30cfdfbe57	\N	auth-username-password-form	9221edbb-59a4-49c1-a953-17a986e6ecd2	b861502e-55b0-401b-87d9-fa91221e0a83	0	10	f	\N	\N
340c4dec-bdba-4a00-a273-7c3a7a8160c5	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	b861502e-55b0-401b-87d9-fa91221e0a83	1	20	t	107bf6c1-8f3e-4510-bbaa-1d97a9a27ee8	\N
325d2bc6-0239-43ed-b032-1608656a4b02	\N	registration-page-form	9221edbb-59a4-49c1-a953-17a986e6ecd2	0e504c50-d67e-44ae-a4b8-06a2595aeca5	0	10	t	82da23d2-e9f0-4086-a50a-386ead1e6b24	\N
2152bdce-320c-4e0c-a9d0-faba39655558	\N	registration-user-creation	9221edbb-59a4-49c1-a953-17a986e6ecd2	82da23d2-e9f0-4086-a50a-386ead1e6b24	0	20	f	\N	\N
857813b7-476d-4ce3-a439-cc360ca1eba7	\N	registration-password-action	9221edbb-59a4-49c1-a953-17a986e6ecd2	82da23d2-e9f0-4086-a50a-386ead1e6b24	0	50	f	\N	\N
3d3f0eb6-9c85-4ddf-b74f-0f48358cfdf9	\N	registration-recaptcha-action	9221edbb-59a4-49c1-a953-17a986e6ecd2	82da23d2-e9f0-4086-a50a-386ead1e6b24	3	60	f	\N	\N
8c02fde5-db91-4b4d-9275-89bf3f5636ec	\N	reset-credentials-choose-user	9221edbb-59a4-49c1-a953-17a986e6ecd2	47940d53-00fd-410e-9f92-dbeb14ebd0aa	0	10	f	\N	\N
f8fd9df7-e386-433c-bdec-d0868e122d8a	\N	reset-credential-email	9221edbb-59a4-49c1-a953-17a986e6ecd2	47940d53-00fd-410e-9f92-dbeb14ebd0aa	0	20	f	\N	\N
19e93f3b-a08f-4e03-8573-3de8f559ca7d	\N	reset-password	9221edbb-59a4-49c1-a953-17a986e6ecd2	47940d53-00fd-410e-9f92-dbeb14ebd0aa	0	30	f	\N	\N
9fd5e5fa-408b-43fc-93be-3592807dda5e	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	47940d53-00fd-410e-9f92-dbeb14ebd0aa	1	40	t	7fdcef7c-e8c9-4e7a-93a5-1c6cd499a23a	\N
afeabe2b-b5a6-4494-8173-8eee5e9cebdb	\N	http-basic-authenticator	9221edbb-59a4-49c1-a953-17a986e6ecd2	d60a8068-72c8-41c7-9452-cbb1ddf7263b	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
57cb89d6-f35d-4251-a482-6751a1ff9e30	browser	browser based authentication	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	t	t
a51a6c63-c864-4c66-91b8-10186b810151	forms	Username, password, otp and other auth forms.	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
825bade7-f072-41eb-a7b4-8bc39e9375e1	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
3728af33-c666-4428-afd6-191bdc634659	direct grant	OpenID Connect Resource Owner Grant	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	t	t
6cb20edc-80bc-4bf4-9fdd-5747e8ffac50	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
9b4c05fc-3ab0-47a3-9fe1-e45d64ae6fc0	registration	registration flow	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	t	t
aa498e91-7c0a-4861-a41d-d694f3686131	registration form	registration form	319844d6-c993-472b-b6db-ed5f70b1d9fa	form-flow	f	t
20789337-b787-43a9-a684-8f2a010f7b5a	reset credentials	Reset credentials for a user if they forgot their password or something	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	t	t
0943f729-b631-4c51-8955-025239857344	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
ad9173b9-2bd4-43e8-b018-969afd04632b	clients	Base authentication for clients	319844d6-c993-472b-b6db-ed5f70b1d9fa	client-flow	t	t
c49c5053-b87e-42ae-a949-9a45e70ff9f8	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	t	t
748df98f-2670-474a-9023-4aa0e0929a21	User creation or linking	Flow for the existing/non-existing user alternatives	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
1d43dbaf-08d1-47bd-9804-7f3dfa1cfc23	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
fd842a0a-103d-400b-ac6b-d557dfe759c8	Account verification options	Method with which to verity the existing account	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
4ce0cece-c51a-4c82-908b-87727210e45e	Verify Existing Account by Re-authentication	Reauthentication of existing account	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
e7f5bc96-0c98-4722-bd75-b71a66a17793	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	f	t
bad19afd-6bcb-4a28-af10-f1c0195738c6	saml ecp	SAML ECP Profile Authentication Flow	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	t	t
e9794844-9966-4a60-ab86-007a6eec5793	docker auth	Used by Docker clients to authenticate against the IDP	319844d6-c993-472b-b6db-ed5f70b1d9fa	basic-flow	t	t
1af31be7-5d1f-4638-968b-b3a66fcd06fe	Account verification options	Method with which to verity the existing account	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
107bf6c1-8f3e-4510-bbaa-1d97a9a27ee8	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
b5adff7a-1670-4ee3-9e0d-e53f9a36b35e	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
720cc79e-3427-478a-a32b-fac664d57b80	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
9559ce29-679c-491e-b610-22786523fc05	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
7fdcef7c-e8c9-4e7a-93a5-1c6cd499a23a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
8c038e99-eefe-4459-9f09-97c2e74a61d5	User creation or linking	Flow for the existing/non-existing user alternatives	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
84f0b6d6-cded-4a78-8e78-7788728a7e3f	Verify Existing Account by Re-authentication	Reauthentication of existing account	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
749c74a4-7db2-49ee-afbc-ce72afcf5c2e	browser	browser based authentication	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	t	t
3f7c1906-4d20-4492-b82f-be9c3da6a4f4	clients	Base authentication for clients	9221edbb-59a4-49c1-a953-17a986e6ecd2	client-flow	t	t
acd97203-4669-4ec5-8c6a-aea8cca25fde	direct grant	OpenID Connect Resource Owner Grant	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	t	t
5be9a2cc-9bb6-4e50-815e-1990eef2eaf5	docker auth	Used by Docker clients to authenticate against the IDP	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	t	t
6d1caa14-b20f-44a6-a101-31643f4295d4	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	t	t
b861502e-55b0-401b-87d9-fa91221e0a83	forms	Username, password, otp and other auth forms.	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	f	t
0e504c50-d67e-44ae-a4b8-06a2595aeca5	registration	registration flow	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	t	t
82da23d2-e9f0-4086-a50a-386ead1e6b24	registration form	registration form	9221edbb-59a4-49c1-a953-17a986e6ecd2	form-flow	f	t
47940d53-00fd-410e-9f92-dbeb14ebd0aa	reset credentials	Reset credentials for a user if they forgot their password or something	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	t	t
d60a8068-72c8-41c7-9452-cbb1ddf7263b	saml ecp	SAML ECP Profile Authentication Flow	9221edbb-59a4-49c1-a953-17a986e6ecd2	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
12902646-d60d-4127-becb-8637b2a3a5d3	review profile config	319844d6-c993-472b-b6db-ed5f70b1d9fa
f52970b9-646f-4219-b021-cb2a25e466ae	create unique user config	319844d6-c993-472b-b6db-ed5f70b1d9fa
72e9516b-177a-4367-8d16-0c8e794c839c	create unique user config	9221edbb-59a4-49c1-a953-17a986e6ecd2
44791bb6-21c6-46c5-b110-3b195debc770	review profile config	9221edbb-59a4-49c1-a953-17a986e6ecd2
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
12902646-d60d-4127-becb-8637b2a3a5d3	missing	update.profile.on.first.login
f52970b9-646f-4219-b021-cb2a25e466ae	false	require.password.update.after.registration
44791bb6-21c6-46c5-b110-3b195debc770	missing	update.profile.on.first.login
72e9516b-177a-4367-8d16-0c8e794c839c	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
062d8dbd-56cf-46cc-a577-e924544c0989	t	f	master-realm	0	f	\N	\N	t	\N	f	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	319844d6-c993-472b-b6db-ed5f70b1d9fa	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
0094f806-561d-43c1-a2c5-eeea98a2bacf	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	319844d6-c993-472b-b6db-ed5f70b1d9fa	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	t	f	broker	0	f	\N	\N	t	\N	f	319844d6-c993-472b-b6db-ed5f70b1d9fa	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
141e4dad-404a-4615-b772-9adb633ad401	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	319844d6-c993-472b-b6db-ed5f70b1d9fa	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
93a02950-5b66-414c-8efb-f810627067c7	t	f	admin-cli	0	t	\N	\N	f	\N	f	319844d6-c993-472b-b6db-ed5f70b1d9fa	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	f	tekclinic-realm	0	f	\N	\N	t	\N	f	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N	0	f	f	tekclinic Realm	f	client-secret	\N	\N	\N	t	f	f	f
35f91e48-5547-4615-b233-5753a6a66334	t	f	account	0	t	\N	/realms/tekclinic/account/	f	\N	f	9221edbb-59a4-49c1-a953-17a986e6ecd2	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
291174d2-2dd5-486e-afd5-25223d4acded	t	t	backend-client	0	f	bwMzihSCl9KMb9vykf4SPMNMmzX97Kpa		f		f	9221edbb-59a4-49c1-a953-17a986e6ecd2	openid-connect	-1	t	f	backend-client	t	client-secret			\N	t	f	t	f
d7963a92-c19a-4ca7-a646-90f9cadd92d9	t	f	account-console	0	t	\N	/realms/tekclinic/account/	f	\N	f	9221edbb-59a4-49c1-a953-17a986e6ecd2	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a248885f-d7b3-402e-8225-a26d1d156774	t	f	admin-cli	0	t	\N	\N	f	\N	f	9221edbb-59a4-49c1-a953-17a986e6ecd2	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
088cf0d3-560a-4164-b704-9f47a63f0897	t	f	broker	0	f	\N	\N	t	\N	f	9221edbb-59a4-49c1-a953-17a986e6ecd2	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
17bc51b0-295d-4165-aa7f-61ecd9be7165	t	f	realm-management	0	f	\N	\N	t	\N	f	9221edbb-59a4-49c1-a953-17a986e6ecd2	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	t	f	security-admin-console	0	t	\N	/admin/tekclinic/console/	f	\N	f	9221edbb-59a4-49c1-a953-17a986e6ecd2	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
984ede3f-e7f6-4231-9bfa-68a726c655a5	t	t	web-app	0	t	\N		f		f	9221edbb-59a4-49c1-a953-17a986e6ecd2	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
a6fa7888-d7d4-4839-bf0f-624e7fa91276	post.logout.redirect.uris	+
0094f806-561d-43c1-a2c5-eeea98a2bacf	post.logout.redirect.uris	+
0094f806-561d-43c1-a2c5-eeea98a2bacf	pkce.code.challenge.method	S256
141e4dad-404a-4615-b772-9adb633ad401	post.logout.redirect.uris	+
141e4dad-404a-4615-b772-9adb633ad401	pkce.code.challenge.method	S256
35f91e48-5547-4615-b233-5753a6a66334	post.logout.redirect.uris	+
d7963a92-c19a-4ca7-a646-90f9cadd92d9	post.logout.redirect.uris	+
d7963a92-c19a-4ca7-a646-90f9cadd92d9	pkce.code.challenge.method	S256
a248885f-d7b3-402e-8225-a26d1d156774	post.logout.redirect.uris	+
291174d2-2dd5-486e-afd5-25223d4acded	oidc.ciba.grant.enabled	false
291174d2-2dd5-486e-afd5-25223d4acded	oauth2.device.authorization.grant.enabled	false
291174d2-2dd5-486e-afd5-25223d4acded	backchannel.logout.session.required	true
291174d2-2dd5-486e-afd5-25223d4acded	backchannel.logout.revoke.offline.tokens	false
088cf0d3-560a-4164-b704-9f47a63f0897	post.logout.redirect.uris	+
17bc51b0-295d-4165-aa7f-61ecd9be7165	post.logout.redirect.uris	+
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	post.logout.redirect.uris	+
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	pkce.code.challenge.method	S256
984ede3f-e7f6-4231-9bfa-68a726c655a5	client.secret.creation.time	1707682848
984ede3f-e7f6-4231-9bfa-68a726c655a5	post.logout.redirect.uris	+
984ede3f-e7f6-4231-9bfa-68a726c655a5	oauth2.device.authorization.grant.enabled	false
984ede3f-e7f6-4231-9bfa-68a726c655a5	backchannel.logout.revoke.offline.tokens	false
984ede3f-e7f6-4231-9bfa-68a726c655a5	use.refresh.tokens	true
984ede3f-e7f6-4231-9bfa-68a726c655a5	oidc.ciba.grant.enabled	false
984ede3f-e7f6-4231-9bfa-68a726c655a5	backchannel.logout.session.required	true
984ede3f-e7f6-4231-9bfa-68a726c655a5	client_credentials.use_refresh_token	false
984ede3f-e7f6-4231-9bfa-68a726c655a5	tls.client.certificate.bound.access.tokens	false
984ede3f-e7f6-4231-9bfa-68a726c655a5	require.pushed.authorization.requests	false
984ede3f-e7f6-4231-9bfa-68a726c655a5	acr.loa.map	{}
984ede3f-e7f6-4231-9bfa-68a726c655a5	display.on.consent.screen	false
984ede3f-e7f6-4231-9bfa-68a726c655a5	token.response.type.bearer.lower-case	false
291174d2-2dd5-486e-afd5-25223d4acded	display.on.consent.screen	false
291174d2-2dd5-486e-afd5-25223d4acded	client.secret.creation.time	1707771834
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
e4917aff-9d41-4b56-818d-573c22374851	offline_access	319844d6-c993-472b-b6db-ed5f70b1d9fa	OpenID Connect built-in scope: offline_access	openid-connect
aecb8531-227e-4656-9ea8-24cff5842127	role_list	319844d6-c993-472b-b6db-ed5f70b1d9fa	SAML role list	saml
35bf0504-dc09-47b2-9cde-13f37b2e23e9	profile	319844d6-c993-472b-b6db-ed5f70b1d9fa	OpenID Connect built-in scope: profile	openid-connect
dacf51ef-e4af-454d-8786-819441f86522	email	319844d6-c993-472b-b6db-ed5f70b1d9fa	OpenID Connect built-in scope: email	openid-connect
b9d47b40-8102-46dd-b163-d6d580bb04e7	address	319844d6-c993-472b-b6db-ed5f70b1d9fa	OpenID Connect built-in scope: address	openid-connect
dbf135ed-fbe1-4f06-933e-021281845cad	phone	319844d6-c993-472b-b6db-ed5f70b1d9fa	OpenID Connect built-in scope: phone	openid-connect
8b286dd1-dec4-49a4-a89c-1aed2bd01513	roles	319844d6-c993-472b-b6db-ed5f70b1d9fa	OpenID Connect scope for add user roles to the access token	openid-connect
51c0257f-9717-43b5-be08-e451687bff14	web-origins	319844d6-c993-472b-b6db-ed5f70b1d9fa	OpenID Connect scope for add allowed web origins to the access token	openid-connect
07279171-c967-4fab-a018-eaa52812be5a	microprofile-jwt	319844d6-c993-472b-b6db-ed5f70b1d9fa	Microprofile - JWT built-in scope	openid-connect
513d8b8f-65a9-4405-8edc-70727cdc48d2	acr	319844d6-c993-472b-b6db-ed5f70b1d9fa	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
1cf577e5-b480-4659-84ff-d5671e8ef358	address	9221edbb-59a4-49c1-a953-17a986e6ecd2	OpenID Connect built-in scope: address	openid-connect
1b885366-4134-48cb-a339-31353e63dcc7	role_list	9221edbb-59a4-49c1-a953-17a986e6ecd2	SAML role list	saml
b17c6014-93e8-439a-a134-ac2cd9512121	email	9221edbb-59a4-49c1-a953-17a986e6ecd2	OpenID Connect built-in scope: email	openid-connect
8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	web-origins	9221edbb-59a4-49c1-a953-17a986e6ecd2	OpenID Connect scope for add allowed web origins to the access token	openid-connect
4b96c031-2373-4029-9edb-2bc0e665bcaa	offline_access	9221edbb-59a4-49c1-a953-17a986e6ecd2	OpenID Connect built-in scope: offline_access	openid-connect
f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	phone	9221edbb-59a4-49c1-a953-17a986e6ecd2	OpenID Connect built-in scope: phone	openid-connect
f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	roles	9221edbb-59a4-49c1-a953-17a986e6ecd2	OpenID Connect scope for add user roles to the access token	openid-connect
8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	profile	9221edbb-59a4-49c1-a953-17a986e6ecd2	OpenID Connect built-in scope: profile	openid-connect
054dce8d-0a1c-44d0-a888-684ea11eff05	microprofile-jwt	9221edbb-59a4-49c1-a953-17a986e6ecd2	Microprofile - JWT built-in scope	openid-connect
295d66c3-7adb-4ce1-9c7c-97615de735ca	acr	9221edbb-59a4-49c1-a953-17a986e6ecd2	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
e4917aff-9d41-4b56-818d-573c22374851	true	display.on.consent.screen
e4917aff-9d41-4b56-818d-573c22374851	${offlineAccessScopeConsentText}	consent.screen.text
aecb8531-227e-4656-9ea8-24cff5842127	true	display.on.consent.screen
aecb8531-227e-4656-9ea8-24cff5842127	${samlRoleListScopeConsentText}	consent.screen.text
35bf0504-dc09-47b2-9cde-13f37b2e23e9	true	display.on.consent.screen
35bf0504-dc09-47b2-9cde-13f37b2e23e9	${profileScopeConsentText}	consent.screen.text
35bf0504-dc09-47b2-9cde-13f37b2e23e9	true	include.in.token.scope
dacf51ef-e4af-454d-8786-819441f86522	true	display.on.consent.screen
dacf51ef-e4af-454d-8786-819441f86522	${emailScopeConsentText}	consent.screen.text
dacf51ef-e4af-454d-8786-819441f86522	true	include.in.token.scope
b9d47b40-8102-46dd-b163-d6d580bb04e7	true	display.on.consent.screen
b9d47b40-8102-46dd-b163-d6d580bb04e7	${addressScopeConsentText}	consent.screen.text
b9d47b40-8102-46dd-b163-d6d580bb04e7	true	include.in.token.scope
dbf135ed-fbe1-4f06-933e-021281845cad	true	display.on.consent.screen
dbf135ed-fbe1-4f06-933e-021281845cad	${phoneScopeConsentText}	consent.screen.text
dbf135ed-fbe1-4f06-933e-021281845cad	true	include.in.token.scope
8b286dd1-dec4-49a4-a89c-1aed2bd01513	true	display.on.consent.screen
8b286dd1-dec4-49a4-a89c-1aed2bd01513	${rolesScopeConsentText}	consent.screen.text
8b286dd1-dec4-49a4-a89c-1aed2bd01513	false	include.in.token.scope
51c0257f-9717-43b5-be08-e451687bff14	false	display.on.consent.screen
51c0257f-9717-43b5-be08-e451687bff14		consent.screen.text
51c0257f-9717-43b5-be08-e451687bff14	false	include.in.token.scope
07279171-c967-4fab-a018-eaa52812be5a	false	display.on.consent.screen
07279171-c967-4fab-a018-eaa52812be5a	true	include.in.token.scope
513d8b8f-65a9-4405-8edc-70727cdc48d2	false	display.on.consent.screen
513d8b8f-65a9-4405-8edc-70727cdc48d2	false	include.in.token.scope
1cf577e5-b480-4659-84ff-d5671e8ef358	true	include.in.token.scope
1cf577e5-b480-4659-84ff-d5671e8ef358	true	display.on.consent.screen
1cf577e5-b480-4659-84ff-d5671e8ef358	${addressScopeConsentText}	consent.screen.text
1b885366-4134-48cb-a339-31353e63dcc7	${samlRoleListScopeConsentText}	consent.screen.text
1b885366-4134-48cb-a339-31353e63dcc7	true	display.on.consent.screen
b17c6014-93e8-439a-a134-ac2cd9512121	true	include.in.token.scope
b17c6014-93e8-439a-a134-ac2cd9512121	true	display.on.consent.screen
b17c6014-93e8-439a-a134-ac2cd9512121	${emailScopeConsentText}	consent.screen.text
8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	false	include.in.token.scope
8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	false	display.on.consent.screen
8b153c1c-bdaa-4958-ad39-a62f6f52b1ba		consent.screen.text
4b96c031-2373-4029-9edb-2bc0e665bcaa	${offlineAccessScopeConsentText}	consent.screen.text
4b96c031-2373-4029-9edb-2bc0e665bcaa	true	display.on.consent.screen
f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	true	include.in.token.scope
f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	true	display.on.consent.screen
f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	${phoneScopeConsentText}	consent.screen.text
f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	false	include.in.token.scope
f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	true	display.on.consent.screen
f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	${rolesScopeConsentText}	consent.screen.text
8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	true	include.in.token.scope
8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	true	display.on.consent.screen
8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	${profileScopeConsentText}	consent.screen.text
054dce8d-0a1c-44d0-a888-684ea11eff05	true	include.in.token.scope
054dce8d-0a1c-44d0-a888-684ea11eff05	false	display.on.consent.screen
295d66c3-7adb-4ce1-9c7c-97615de735ca	false	include.in.token.scope
295d66c3-7adb-4ce1-9c7c-97615de735ca	false	display.on.consent.screen
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
a6fa7888-d7d4-4839-bf0f-624e7fa91276	35bf0504-dc09-47b2-9cde-13f37b2e23e9	t
a6fa7888-d7d4-4839-bf0f-624e7fa91276	51c0257f-9717-43b5-be08-e451687bff14	t
a6fa7888-d7d4-4839-bf0f-624e7fa91276	dacf51ef-e4af-454d-8786-819441f86522	t
a6fa7888-d7d4-4839-bf0f-624e7fa91276	8b286dd1-dec4-49a4-a89c-1aed2bd01513	t
a6fa7888-d7d4-4839-bf0f-624e7fa91276	513d8b8f-65a9-4405-8edc-70727cdc48d2	t
a6fa7888-d7d4-4839-bf0f-624e7fa91276	b9d47b40-8102-46dd-b163-d6d580bb04e7	f
a6fa7888-d7d4-4839-bf0f-624e7fa91276	07279171-c967-4fab-a018-eaa52812be5a	f
a6fa7888-d7d4-4839-bf0f-624e7fa91276	e4917aff-9d41-4b56-818d-573c22374851	f
a6fa7888-d7d4-4839-bf0f-624e7fa91276	dbf135ed-fbe1-4f06-933e-021281845cad	f
0094f806-561d-43c1-a2c5-eeea98a2bacf	35bf0504-dc09-47b2-9cde-13f37b2e23e9	t
0094f806-561d-43c1-a2c5-eeea98a2bacf	51c0257f-9717-43b5-be08-e451687bff14	t
0094f806-561d-43c1-a2c5-eeea98a2bacf	dacf51ef-e4af-454d-8786-819441f86522	t
0094f806-561d-43c1-a2c5-eeea98a2bacf	8b286dd1-dec4-49a4-a89c-1aed2bd01513	t
0094f806-561d-43c1-a2c5-eeea98a2bacf	513d8b8f-65a9-4405-8edc-70727cdc48d2	t
0094f806-561d-43c1-a2c5-eeea98a2bacf	b9d47b40-8102-46dd-b163-d6d580bb04e7	f
0094f806-561d-43c1-a2c5-eeea98a2bacf	07279171-c967-4fab-a018-eaa52812be5a	f
0094f806-561d-43c1-a2c5-eeea98a2bacf	e4917aff-9d41-4b56-818d-573c22374851	f
0094f806-561d-43c1-a2c5-eeea98a2bacf	dbf135ed-fbe1-4f06-933e-021281845cad	f
93a02950-5b66-414c-8efb-f810627067c7	35bf0504-dc09-47b2-9cde-13f37b2e23e9	t
93a02950-5b66-414c-8efb-f810627067c7	51c0257f-9717-43b5-be08-e451687bff14	t
93a02950-5b66-414c-8efb-f810627067c7	dacf51ef-e4af-454d-8786-819441f86522	t
93a02950-5b66-414c-8efb-f810627067c7	8b286dd1-dec4-49a4-a89c-1aed2bd01513	t
93a02950-5b66-414c-8efb-f810627067c7	513d8b8f-65a9-4405-8edc-70727cdc48d2	t
93a02950-5b66-414c-8efb-f810627067c7	b9d47b40-8102-46dd-b163-d6d580bb04e7	f
93a02950-5b66-414c-8efb-f810627067c7	07279171-c967-4fab-a018-eaa52812be5a	f
93a02950-5b66-414c-8efb-f810627067c7	e4917aff-9d41-4b56-818d-573c22374851	f
93a02950-5b66-414c-8efb-f810627067c7	dbf135ed-fbe1-4f06-933e-021281845cad	f
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	35bf0504-dc09-47b2-9cde-13f37b2e23e9	t
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	51c0257f-9717-43b5-be08-e451687bff14	t
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	dacf51ef-e4af-454d-8786-819441f86522	t
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	8b286dd1-dec4-49a4-a89c-1aed2bd01513	t
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	513d8b8f-65a9-4405-8edc-70727cdc48d2	t
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	b9d47b40-8102-46dd-b163-d6d580bb04e7	f
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	07279171-c967-4fab-a018-eaa52812be5a	f
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	e4917aff-9d41-4b56-818d-573c22374851	f
93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	dbf135ed-fbe1-4f06-933e-021281845cad	f
062d8dbd-56cf-46cc-a577-e924544c0989	35bf0504-dc09-47b2-9cde-13f37b2e23e9	t
062d8dbd-56cf-46cc-a577-e924544c0989	51c0257f-9717-43b5-be08-e451687bff14	t
062d8dbd-56cf-46cc-a577-e924544c0989	dacf51ef-e4af-454d-8786-819441f86522	t
062d8dbd-56cf-46cc-a577-e924544c0989	8b286dd1-dec4-49a4-a89c-1aed2bd01513	t
062d8dbd-56cf-46cc-a577-e924544c0989	513d8b8f-65a9-4405-8edc-70727cdc48d2	t
062d8dbd-56cf-46cc-a577-e924544c0989	b9d47b40-8102-46dd-b163-d6d580bb04e7	f
062d8dbd-56cf-46cc-a577-e924544c0989	07279171-c967-4fab-a018-eaa52812be5a	f
062d8dbd-56cf-46cc-a577-e924544c0989	e4917aff-9d41-4b56-818d-573c22374851	f
062d8dbd-56cf-46cc-a577-e924544c0989	dbf135ed-fbe1-4f06-933e-021281845cad	f
141e4dad-404a-4615-b772-9adb633ad401	35bf0504-dc09-47b2-9cde-13f37b2e23e9	t
141e4dad-404a-4615-b772-9adb633ad401	51c0257f-9717-43b5-be08-e451687bff14	t
141e4dad-404a-4615-b772-9adb633ad401	dacf51ef-e4af-454d-8786-819441f86522	t
141e4dad-404a-4615-b772-9adb633ad401	8b286dd1-dec4-49a4-a89c-1aed2bd01513	t
141e4dad-404a-4615-b772-9adb633ad401	513d8b8f-65a9-4405-8edc-70727cdc48d2	t
141e4dad-404a-4615-b772-9adb633ad401	b9d47b40-8102-46dd-b163-d6d580bb04e7	f
141e4dad-404a-4615-b772-9adb633ad401	07279171-c967-4fab-a018-eaa52812be5a	f
141e4dad-404a-4615-b772-9adb633ad401	e4917aff-9d41-4b56-818d-573c22374851	f
141e4dad-404a-4615-b772-9adb633ad401	dbf135ed-fbe1-4f06-933e-021281845cad	f
35f91e48-5547-4615-b233-5753a6a66334	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
35f91e48-5547-4615-b233-5753a6a66334	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
35f91e48-5547-4615-b233-5753a6a66334	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
35f91e48-5547-4615-b233-5753a6a66334	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
35f91e48-5547-4615-b233-5753a6a66334	b17c6014-93e8-439a-a134-ac2cd9512121	t
35f91e48-5547-4615-b233-5753a6a66334	1cf577e5-b480-4659-84ff-d5671e8ef358	f
35f91e48-5547-4615-b233-5753a6a66334	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
35f91e48-5547-4615-b233-5753a6a66334	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
35f91e48-5547-4615-b233-5753a6a66334	054dce8d-0a1c-44d0-a888-684ea11eff05	f
d7963a92-c19a-4ca7-a646-90f9cadd92d9	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
d7963a92-c19a-4ca7-a646-90f9cadd92d9	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
d7963a92-c19a-4ca7-a646-90f9cadd92d9	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
d7963a92-c19a-4ca7-a646-90f9cadd92d9	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
d7963a92-c19a-4ca7-a646-90f9cadd92d9	b17c6014-93e8-439a-a134-ac2cd9512121	t
d7963a92-c19a-4ca7-a646-90f9cadd92d9	1cf577e5-b480-4659-84ff-d5671e8ef358	f
d7963a92-c19a-4ca7-a646-90f9cadd92d9	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
d7963a92-c19a-4ca7-a646-90f9cadd92d9	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
d7963a92-c19a-4ca7-a646-90f9cadd92d9	054dce8d-0a1c-44d0-a888-684ea11eff05	f
a248885f-d7b3-402e-8225-a26d1d156774	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
a248885f-d7b3-402e-8225-a26d1d156774	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
a248885f-d7b3-402e-8225-a26d1d156774	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
a248885f-d7b3-402e-8225-a26d1d156774	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
a248885f-d7b3-402e-8225-a26d1d156774	b17c6014-93e8-439a-a134-ac2cd9512121	t
a248885f-d7b3-402e-8225-a26d1d156774	1cf577e5-b480-4659-84ff-d5671e8ef358	f
a248885f-d7b3-402e-8225-a26d1d156774	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
a248885f-d7b3-402e-8225-a26d1d156774	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
a248885f-d7b3-402e-8225-a26d1d156774	054dce8d-0a1c-44d0-a888-684ea11eff05	f
291174d2-2dd5-486e-afd5-25223d4acded	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
291174d2-2dd5-486e-afd5-25223d4acded	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
291174d2-2dd5-486e-afd5-25223d4acded	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
291174d2-2dd5-486e-afd5-25223d4acded	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
291174d2-2dd5-486e-afd5-25223d4acded	b17c6014-93e8-439a-a134-ac2cd9512121	t
291174d2-2dd5-486e-afd5-25223d4acded	1cf577e5-b480-4659-84ff-d5671e8ef358	f
291174d2-2dd5-486e-afd5-25223d4acded	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
291174d2-2dd5-486e-afd5-25223d4acded	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
291174d2-2dd5-486e-afd5-25223d4acded	054dce8d-0a1c-44d0-a888-684ea11eff05	f
088cf0d3-560a-4164-b704-9f47a63f0897	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
088cf0d3-560a-4164-b704-9f47a63f0897	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
088cf0d3-560a-4164-b704-9f47a63f0897	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
088cf0d3-560a-4164-b704-9f47a63f0897	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
088cf0d3-560a-4164-b704-9f47a63f0897	b17c6014-93e8-439a-a134-ac2cd9512121	t
088cf0d3-560a-4164-b704-9f47a63f0897	1cf577e5-b480-4659-84ff-d5671e8ef358	f
088cf0d3-560a-4164-b704-9f47a63f0897	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
088cf0d3-560a-4164-b704-9f47a63f0897	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
088cf0d3-560a-4164-b704-9f47a63f0897	054dce8d-0a1c-44d0-a888-684ea11eff05	f
17bc51b0-295d-4165-aa7f-61ecd9be7165	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
17bc51b0-295d-4165-aa7f-61ecd9be7165	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
17bc51b0-295d-4165-aa7f-61ecd9be7165	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
17bc51b0-295d-4165-aa7f-61ecd9be7165	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
17bc51b0-295d-4165-aa7f-61ecd9be7165	b17c6014-93e8-439a-a134-ac2cd9512121	t
17bc51b0-295d-4165-aa7f-61ecd9be7165	1cf577e5-b480-4659-84ff-d5671e8ef358	f
17bc51b0-295d-4165-aa7f-61ecd9be7165	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
17bc51b0-295d-4165-aa7f-61ecd9be7165	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
17bc51b0-295d-4165-aa7f-61ecd9be7165	054dce8d-0a1c-44d0-a888-684ea11eff05	f
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	b17c6014-93e8-439a-a134-ac2cd9512121	t
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	1cf577e5-b480-4659-84ff-d5671e8ef358	f
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	054dce8d-0a1c-44d0-a888-684ea11eff05	f
984ede3f-e7f6-4231-9bfa-68a726c655a5	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
984ede3f-e7f6-4231-9bfa-68a726c655a5	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
984ede3f-e7f6-4231-9bfa-68a726c655a5	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
984ede3f-e7f6-4231-9bfa-68a726c655a5	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
984ede3f-e7f6-4231-9bfa-68a726c655a5	b17c6014-93e8-439a-a134-ac2cd9512121	t
984ede3f-e7f6-4231-9bfa-68a726c655a5	1cf577e5-b480-4659-84ff-d5671e8ef358	f
984ede3f-e7f6-4231-9bfa-68a726c655a5	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
984ede3f-e7f6-4231-9bfa-68a726c655a5	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
984ede3f-e7f6-4231-9bfa-68a726c655a5	054dce8d-0a1c-44d0-a888-684ea11eff05	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
e4917aff-9d41-4b56-818d-573c22374851	0ce7f3cd-5431-4edf-8bab-1d21ad9fc30a
4b96c031-2373-4029-9edb-2bc0e665bcaa	2fa4f64f-fe91-440a-b180-4702a6e67512
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
27bd877f-af79-4a35-af7c-c49e1053de43	Trusted Hosts	319844d6-c993-472b-b6db-ed5f70b1d9fa	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	anonymous
c73ce3a4-4aea-4690-99e4-096e4704b65b	Consent Required	319844d6-c993-472b-b6db-ed5f70b1d9fa	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	anonymous
9c885711-18c6-4f9d-82e3-ebde39e0c5fb	Full Scope Disabled	319844d6-c993-472b-b6db-ed5f70b1d9fa	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	anonymous
9777f6a0-85ca-46c2-a773-e091d9863d8d	Max Clients Limit	319844d6-c993-472b-b6db-ed5f70b1d9fa	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	anonymous
4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	Allowed Protocol Mapper Types	319844d6-c993-472b-b6db-ed5f70b1d9fa	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	anonymous
b9c418e0-10f5-415b-b86f-559eb0e928ff	Allowed Client Scopes	319844d6-c993-472b-b6db-ed5f70b1d9fa	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	anonymous
4ca59c33-c813-4e2f-be8a-f07241af2d6c	Allowed Protocol Mapper Types	319844d6-c993-472b-b6db-ed5f70b1d9fa	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	authenticated
8ce3acc6-f930-4fdf-968b-dd511ed611ac	Allowed Client Scopes	319844d6-c993-472b-b6db-ed5f70b1d9fa	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	authenticated
d6757ea9-611a-41d2-b030-bbd1a74aaf23	rsa-generated	319844d6-c993-472b-b6db-ed5f70b1d9fa	rsa-generated	org.keycloak.keys.KeyProvider	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N
c106898f-bdd0-4373-83d2-bcbc20585b34	rsa-enc-generated	319844d6-c993-472b-b6db-ed5f70b1d9fa	rsa-enc-generated	org.keycloak.keys.KeyProvider	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N
4669fbd1-98b2-4b9c-af91-522dabc6ff6c	hmac-generated	319844d6-c993-472b-b6db-ed5f70b1d9fa	hmac-generated	org.keycloak.keys.KeyProvider	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N
81533f1b-e342-4e7e-b089-efd999c8df07	aes-generated	319844d6-c993-472b-b6db-ed5f70b1d9fa	aes-generated	org.keycloak.keys.KeyProvider	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N
801410d7-5e89-47ab-b31d-e2096e5c3dc4	Allowed Protocol Mapper Types	9221edbb-59a4-49c1-a953-17a986e6ecd2	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	anonymous
efe25048-7d18-4cb8-82c4-db31ff196f58	Allowed Client Scopes	9221edbb-59a4-49c1-a953-17a986e6ecd2	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	anonymous
23eb6a32-c836-44d7-b548-3c52146d556a	Max Clients Limit	9221edbb-59a4-49c1-a953-17a986e6ecd2	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	anonymous
46a96973-c6de-4056-a1d5-35e00e78e4ac	Full Scope Disabled	9221edbb-59a4-49c1-a953-17a986e6ecd2	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	anonymous
16999ea1-869c-4849-8f1b-cb6d37520d48	Allowed Protocol Mapper Types	9221edbb-59a4-49c1-a953-17a986e6ecd2	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	authenticated
bde8332c-2bbe-4748-b61f-77eb048011b3	Trusted Hosts	9221edbb-59a4-49c1-a953-17a986e6ecd2	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	anonymous
ae55fabe-371c-46f3-b167-24dd14f708f7	Allowed Client Scopes	9221edbb-59a4-49c1-a953-17a986e6ecd2	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	authenticated
6c162183-aa15-458e-9d22-184bc3b25d12	Consent Required	9221edbb-59a4-49c1-a953-17a986e6ecd2	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	anonymous
fae1afee-b894-45cb-88e2-0d6140fb0f9d	rsa-enc-generated	9221edbb-59a4-49c1-a953-17a986e6ecd2	rsa-enc-generated	org.keycloak.keys.KeyProvider	9221edbb-59a4-49c1-a953-17a986e6ecd2	\N
b1149708-ba62-4075-bdf2-6678045db0f3	aes-generated	9221edbb-59a4-49c1-a953-17a986e6ecd2	aes-generated	org.keycloak.keys.KeyProvider	9221edbb-59a4-49c1-a953-17a986e6ecd2	\N
b085cf5c-016c-4b8f-ac72-599b536e21e8	rsa-generated	9221edbb-59a4-49c1-a953-17a986e6ecd2	rsa-generated	org.keycloak.keys.KeyProvider	9221edbb-59a4-49c1-a953-17a986e6ecd2	\N
c6157425-ffdb-4cdc-8dca-bda8b83bb2bc	hmac-generated	9221edbb-59a4-49c1-a953-17a986e6ecd2	hmac-generated	org.keycloak.keys.KeyProvider	9221edbb-59a4-49c1-a953-17a986e6ecd2	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
92495cfe-e406-4ee0-b979-e524ec1e90ea	9777f6a0-85ca-46c2-a773-e091d9863d8d	max-clients	200
8a798c74-24b4-42b3-b138-24c5275f1271	27bd877f-af79-4a35-af7c-c49e1053de43	client-uris-must-match	true
b7f71e4b-e921-4516-9af7-21a0ccc6f59d	27bd877f-af79-4a35-af7c-c49e1053de43	host-sending-registration-request-must-match	true
46781813-395e-4800-afe8-d981b3cff36f	4ca59c33-c813-4e2f-be8a-f07241af2d6c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
2698b86e-f704-410d-b1d3-7ed7e6d794d5	4ca59c33-c813-4e2f-be8a-f07241af2d6c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d6ad2ea6-cf4b-40cb-a29a-d24b5212c0ec	4ca59c33-c813-4e2f-be8a-f07241af2d6c	allowed-protocol-mapper-types	saml-user-property-mapper
c5b8e6f2-ae52-47a8-baac-bc90c88de511	4ca59c33-c813-4e2f-be8a-f07241af2d6c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0589ad6e-d797-4f59-8244-721e4eb9ea7b	4ca59c33-c813-4e2f-be8a-f07241af2d6c	allowed-protocol-mapper-types	oidc-full-name-mapper
9aea08c7-a928-45a0-be0f-f3f75ffedde5	4ca59c33-c813-4e2f-be8a-f07241af2d6c	allowed-protocol-mapper-types	saml-user-attribute-mapper
4a5442e7-a8ea-4cbf-bb72-87c0ce19cdbb	4ca59c33-c813-4e2f-be8a-f07241af2d6c	allowed-protocol-mapper-types	oidc-address-mapper
f583ff41-3df0-4439-a403-bed401c44196	4ca59c33-c813-4e2f-be8a-f07241af2d6c	allowed-protocol-mapper-types	saml-role-list-mapper
314f8e21-cf1c-44cb-afca-5cfcf2f6e5f3	4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	allowed-protocol-mapper-types	saml-user-attribute-mapper
e114042f-9cc7-47be-bce4-2d5607f6b283	4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
76126c76-5dc8-46d3-be04-f41c5ba65569	4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	allowed-protocol-mapper-types	oidc-full-name-mapper
7ba8f6fd-f251-4d8e-90c2-0807d03cb5b5	4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
26bca29a-bd8e-469f-b63d-ad9352839ebb	4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	allowed-protocol-mapper-types	saml-role-list-mapper
293b94a7-cc9f-4178-96cd-9c8260f3b83b	4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	allowed-protocol-mapper-types	saml-user-property-mapper
a32f592d-ecbd-4882-8e17-909eae67a061	4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
b420a72b-9fa6-416e-9e85-7d47082a0fc3	4c6207ff-3ed9-4669-b6b2-0a9de2c2f13b	allowed-protocol-mapper-types	oidc-address-mapper
f42abeb6-2b15-42e2-b895-6593007fdb31	8ce3acc6-f930-4fdf-968b-dd511ed611ac	allow-default-scopes	true
dd8a75d5-36ba-42d3-aa99-52ced1fb46ea	b9c418e0-10f5-415b-b86f-559eb0e928ff	allow-default-scopes	true
245da78e-c58c-41dd-b60f-dd6b277a698d	81533f1b-e342-4e7e-b089-efd999c8df07	kid	8343a166-9a33-44e4-8065-98e5991830ec
42f68db8-0361-4a0d-a025-066382096ecb	81533f1b-e342-4e7e-b089-efd999c8df07	secret	rfcHrjHCFV4VGPpTrXCMEw
9f411d6b-5c26-47ed-a33d-30d5a719d823	81533f1b-e342-4e7e-b089-efd999c8df07	priority	100
f2aa1291-8059-4463-9896-efb162f76af5	c106898f-bdd0-4373-83d2-bcbc20585b34	privateKey	MIIEowIBAAKCAQEAoZE0ZBYId72K2PQZ4FiIVd6LSOpJ8Q4A4z/26dbjwiHFoCF2ckRZyX2U5IoXu7+8BulK3DcyH2/FHop8qMa+VDNFvDVRg/dEArXPU3FdLJ168SzssAzcguOCyMLFBJCifT20u23JU+woh2rRW54OyIFumKDBsZE/r4grUtgsLR/zX056xdwNXLUAq6g9A5V+u46Pvy7XYJGCNhi30FetxHt2pL5NA5IL4dcgl3NmTJbBDn2PXWF8itgOe7euNs1/ewtxwkwT6fFEP3+Qhd/CfsyxJen7jnJo5fTdhcvZCrNTX+byOtb5/wFizipEGx2Lyp1p2R+1jxaNIf3M1/O4qQIDAQABAoIBAAEKNrNDFJNfQahXloj7eW2RhwFolqJYxgKn5pb+aZFesNf1KD8GqtSLHrrlo6QqszVMpXfaOBhJNDJPefo6L4Nj29NtxbEXs4QC4iCdi+S6keNavDf+VGYC77JGvB3LsFJyvYJn687k9L7TDRklR0XYzfRPgCvrSxf+Lxe8D9L+t/pGpolrHMC6LrIIC/mbUh2XR6H2fvZXXF7x/J9GSwBCUBwEOfLMYUzHksdPf9JuVW7SetwMiqlKXmBSjxn2jlRbyXl+dEKzQuBohGBpqO2k+ocpZQav7qqtzkgcu9xrUs/KxKvytHOLHuKdNnH4zFSNkek/tDjjx1ejsQz4HQECgYEA2I8UgycPsQwxMnYIuQ3UHU3fdBpDNsdPa/8Hj8X1/CaI2ryVMRk2TwLNiYZNLaVS79jnpYRetDxsQWROqJHsVlOrDKHvQRzkxEGn9oYzyeWnr+ZHXSZX3B9H4T/jnF6/lgPLIU248aW5GiEo3Nt/JAx9vlP5LjA9URPFzAB+aykCgYEAvv4r+wmsdx2LWP0a9wFw1OJDDjngX9SB/veZ2YqZmp/Z2LCtrVA6rt3CS3egoh0ujqYwGNg2B1+62YIFXWiPNrL2nNnst2WW98V8QJMGXS3PcFO4UAv7QwqLL1KSYx3qt/WGTFwK0xrCKYAllsxc1BqN4mSAEvNtTGPuxuBSEYECgYEAppH/XBXqeur+2GpzsStS0St5ycr9kh/iFhZ20X6aA1X8hArz0m0rGcD1KWfU61wzm+rB2s0jLw0e03l9CyoamBgJBFF2PyYjTFWYBQYaxZvQzHqav6pjgBvLZRWIVFmIkbHfR4GJ1Mz8wH1q+d4XQDofagsbKgzOzRMhXBWxJ2kCgYBxJ82O0dBoUgy5EFvlc+kRd2wbBZc1r4XFNZTlGgSfY42BoEuFnz7lU2VFqP52jauDwFpGnfKEs+bT7wCWstgGpEkP7N0eWwXyjgJrj6/5jKaV+kP8yNx4f8quotEwAA2MJ98FZpLTN8tJIy8iBLoKwCDHvJtUnvxmgd553XVCAQKBgA4vfUGhaSAVhA0iGdJ04Xedh3WAxsIor3GmTxBSMNmwg8wXluM7PvqCq4gXGr7WaDICihDn43sybUL2XLJvDge7RvSzbnQVy+5b4CD71bQwYDoFWr6rMbcMVLthYMgkDKoK/Sb/omykBZEa4GfuSEfIZMQ2pIEsBKtiFp6vZtqt
606b80ba-1d55-43f1-a450-22bb28429c2f	c106898f-bdd0-4373-83d2-bcbc20585b34	keyUse	ENC
7a56ec7f-c007-42d2-8b7c-b61251a5584f	c106898f-bdd0-4373-83d2-bcbc20585b34	certificate	MIICmzCCAYMCBgGNnixqRzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwMjEyMTYzMzQ3WhcNMzQwMjEyMTYzNTI3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQChkTRkFgh3vYrY9BngWIhV3otI6knxDgDjP/bp1uPCIcWgIXZyRFnJfZTkihe7v7wG6UrcNzIfb8Ueinyoxr5UM0W8NVGD90QCtc9TcV0snXrxLOywDNyC44LIwsUEkKJ9PbS7bclT7CiHatFbng7IgW6YoMGxkT+viCtS2CwtH/NfTnrF3A1ctQCrqD0DlX67jo+/LtdgkYI2GLfQV63Ee3akvk0Dkgvh1yCXc2ZMlsEOfY9dYXyK2A57t642zX97C3HCTBPp8UQ/f5CF38J+zLEl6fuOcmjl9N2Fy9kKs1Nf5vI61vn/AWLOKkQbHYvKnWnZH7WPFo0h/czX87ipAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACPgkznsaMwPuPb1u2c9+Av4UXGZUgCHxEsfJbHa5BRSrj2bawD3/+GBElT9yKhxdJVDFTvlVPnfRdvFon3ykHBeeKPZ7s2HuuvwDvZB3yfbUfdPLtDr7g9n/AsvawyC+1fYY/so8y55Ycla3kE/f7rtN+IxUWRXhFZsdjX64HwJWIX0TPtK+XLG3x6EKyRunDbTawlPONlyocAxymvtCXuMmqVnzNfKGw+U/Qtg7bbEa5kYLxBehcp9ogSgOyn9wWYy3pTxYBTh0etB6aCsWD4oXwHLyHg1GmZp9GBlZ3vegD4xLouecFtOZQB3p8FzDCRW+5gAmciJzgqoEhqx6GQ=
b5236db7-d9e3-4da0-bfdb-9ac3f595bee5	c106898f-bdd0-4373-83d2-bcbc20585b34	algorithm	RSA-OAEP
c7401333-aef3-4fe2-890b-c09d6f3ac4ba	c106898f-bdd0-4373-83d2-bcbc20585b34	priority	100
4536bb1c-f90f-47f9-84c7-f6c70711bced	d6757ea9-611a-41d2-b030-bbd1a74aaf23	certificate	MIICmzCCAYMCBgGNnixoaTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwMjEyMTYzMzQ2WhcNMzQwMjEyMTYzNTI2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAOa+X7abAha0lMGxJkStUCwdWoHYTf3uc2mdib+3SNNHb3Rxfv0xE+0VInyuxpRoeNzW+thh8GjtyPf7km/2jm6Xc7otbJXjEW1vF09OgB49wX5VbYXR1029t3do9yEL2JXUP3mSDK/1XDq13EoCYezKG3sYLju8Djr65PGwMhUw2IRskp08AbPJhp0Y7I7LZ8Q2+mYxEqH2nYxCpr4b0YifdQXlHQz8f/aJKChQoGvOevgibvxEPB5VuYK+XyuNLDenOK4FPK3diM/jRh1pd8XY6ns2V1lVPpWNa9M/OUowBTZNS30p01wv3aFBm/FqlR9df5iewFAm+3loMIGbRAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAH2j4GrkEKpcvOpD/ti66x/fcLOR0C8ZuAtNW7UgCG3XzcJzWpY52TChnYQso8Z3sCVJw03jFnrGznXW4QAQ6Wz5Zluue8xKJRKL/4G3WTe7dXc5gZklhlJMuaL4EbsOqORrJpojPzzeMl4tJyGuWfZ9muMOtRXPIgWgUflhDo1n5wZ6IFn82iVQGlsBkGFDM5FFrhjnq6xuQe8pNFJFkoYs8/BMAWR8mkdfPKz9IC+648fVqjIiVV5zoNsDQGn/K0mO/u/0nKWr7kasGW07Qq6mgTiQtKclAmwX562QQKXME30EuNBlxrrzEWL8/wZlg46j6EHpSG6oMalaprW7Y8I=
69a88233-131d-408c-b6fb-3113a33cd3df	d6757ea9-611a-41d2-b030-bbd1a74aaf23	keyUse	SIG
d0337aef-c859-44cd-948b-6aa417a28994	d6757ea9-611a-41d2-b030-bbd1a74aaf23	privateKey	MIIEowIBAAKCAQEAwDmvl+2mwIWtJTBsSZErVAsHVqB2E397nNpnYm/t0jTR290cX79MRPtFSJ8rsaUaHjc1vrYYfBo7cj3+5Jv9o5ul3O6LWyV4xFtbxdPToAePcF+VW2F0ddNvbd3aPchC9iV1D95kgyv9Vw6tdxKAmHsyht7GC47vA46+uTxsDIVMNiEbJKdPAGzyYadGOyOy2fENvpmMRKh9p2MQqa+G9GIn3UF5R0M/H/2iSgoUKBrznr4Im78RDweVbmCvl8rjSw3pziuBTyt3YjP40YdaXfF2Op7NldZVT6VjWvTPzlKMAU2TUt9KdNcL92hQZvxapUfXX+YnsBQJvt5aDCBm0QIDAQABAoIBAADONh854nsyyneV4o6hfoQjtVgOLI/MqNowLT2OxgnmAkl4YbXRcJjhUUkS0Si7C11uT34bSxxSMoQNq7cC4R1ImIoZRmoXmrGJ3cXeKzjsK7WvbblMPexeISwVMKHpg/0aBwm/1VPzTZEPllC4I82vFDfixX3RIBsQu4ZDJg6W7sv3QEgwaeBYbAuPdg284/hrHa/Mj6MbhtDjjpkzWf6IFB9z1QvUsz7UJRnxs4HfYj4DQBGg1EuxfKAQ1qhJStg9oSmpm4gOm4uW4eC/hehMf2JhKvORh5YRApybbDBm7EFU9JXlHWh0IEYWdbJ7L+XyiACJz+hLKWL7Ste4JIcCgYEA+pLzOwUpi+cUx4en4PxHxO2DnJ5Mdn1KanA8GMup7IpJ3OkxMOLYV6XabvCRfBM3v3R39VxJEY4tNk6D3PuLxmKH6UupLEhs3Ti6V8gWTUEGS6l0b575gQq8Up8CwoCFhUa68dEAHBCNC9d326cY87EFjRNkZemDtsLMynFc6OMCgYEAxGNIEbmkfLPI60xsvLQZn2o/6UBpfpIkdCM/2C1DAUi7imR4tNZL8z5645Y+4sSkCLF25ao6RM6GyboWjPJWAtujmM7gdjUz5f13saIlHg7SdJX1y/Ea2yu7ta2giTOi8+N+LhlniqHXO+NF3kfebZ4J9jfEZXQveYkqLxML47sCgYEA0TJ8hUrjC91qOMdl/m1BkgTl+40hs08ZINIBKoZmoIg38Ipzuie5jTt3qWWJYPg+c8ZOHHfmvRRhZNSaPJV6da9vXvP/EmyJDwy8bmsrS2Y9Vk/sWQB1uCl5XtVInZBlaQbLLvZZzBR5XWiPtb/FEjc5tjV5fag+gggSp/WLJxcCgYBJ1UWgHFpB49my1N3AqDlF3M1AZU4EHu+DlkkHfiTF09FmO1XCLxsIzUGoVLE50lIVTprzx2b2vWqhZsvZm7ZIhsjfx09OQbxMSFn6t4oa3dmzqTlqvi+pnKyKpkdHrdkitjGXJUfvL99ajZyT8BMoxRTbs6Wrut2qZK4uWovKxwKBgAzXSduREh7eT3Gc0m4f6X7hMG+M2AQLLeu9uPYAjlETsft9sysMT+LafFsj0c6l5d5DgCFUEpAbNu2N+XfwX8WMp6dw7pN21U0ggB0BgVTLuTL7rFe2ATk2+HOoS2rhXv14DOLFT/enPCywRtFMA8xnL5E/zmRYngubHbgLg2lX
df6be912-ca4b-4582-9fb0-d2eaf4ea4fa5	d6757ea9-611a-41d2-b030-bbd1a74aaf23	priority	100
ef21f749-aaf4-4a5c-bf92-661caaeb4ab8	4669fbd1-98b2-4b9c-af91-522dabc6ff6c	priority	100
6dfbeadb-06d6-4c62-bbda-eac7d8a3c7fb	4669fbd1-98b2-4b9c-af91-522dabc6ff6c	algorithm	HS256
f0293cb6-aa5a-480c-9c4e-0c365ae75e47	4669fbd1-98b2-4b9c-af91-522dabc6ff6c	secret	yXI4VfVvQYAo2qyzFoNJd8-rNptsCUfokMumQnWzUzVpxveFNO49tq14ers0yMDZrFhvd12IdyTixWbadHkoQA
35ccaa9f-69c6-45fd-84c9-fc0b1d07dba5	4669fbd1-98b2-4b9c-af91-522dabc6ff6c	kid	4c9462aa-a6a1-4ae3-b773-0e145d80e832
e270afe8-4f6b-4542-bd7e-8125e78de7ee	801410d7-5e89-47ab-b31d-e2096e5c3dc4	allowed-protocol-mapper-types	oidc-address-mapper
98559def-d609-4b89-bcbc-c71a212dc8f1	801410d7-5e89-47ab-b31d-e2096e5c3dc4	allowed-protocol-mapper-types	oidc-full-name-mapper
5adf9e5e-c975-4fa6-bb7c-714525d4f0d4	801410d7-5e89-47ab-b31d-e2096e5c3dc4	allowed-protocol-mapper-types	saml-user-property-mapper
01cda1f1-8f46-47dd-b111-ccb81f6387fd	801410d7-5e89-47ab-b31d-e2096e5c3dc4	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9312b7ed-2a16-4879-9855-5c36e975515b	801410d7-5e89-47ab-b31d-e2096e5c3dc4	allowed-protocol-mapper-types	saml-role-list-mapper
59dff7e9-0811-46ff-9376-967c13833223	801410d7-5e89-47ab-b31d-e2096e5c3dc4	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4f814c07-6ee9-486b-b813-043054b7675f	801410d7-5e89-47ab-b31d-e2096e5c3dc4	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
182c87f9-37fd-4625-b99a-6968c32386ee	801410d7-5e89-47ab-b31d-e2096e5c3dc4	allowed-protocol-mapper-types	saml-user-attribute-mapper
5b064495-32c5-4313-bdc3-7b2597fe5070	23eb6a32-c836-44d7-b548-3c52146d556a	max-clients	200
afe22e1e-fc79-4f75-9460-3d960ef08e97	b1149708-ba62-4075-bdf2-6678045db0f3	secret	zsL3RCwUkPEtsPO6S-O_Ww
5d003821-69ff-4bbf-b51c-08c01be71682	b1149708-ba62-4075-bdf2-6678045db0f3	priority	100
32de0592-2e1c-44e9-893e-8e41703ba7d6	b1149708-ba62-4075-bdf2-6678045db0f3	kid	f495a9f6-15b5-4982-bd66-ee82b1052e0a
ca8d02ac-4d6a-48e6-8c16-ede803610df8	16999ea1-869c-4849-8f1b-cb6d37520d48	allowed-protocol-mapper-types	saml-role-list-mapper
3db70d07-4084-4397-a41d-a34bffe4c202	16999ea1-869c-4849-8f1b-cb6d37520d48	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
1d4d200b-8727-405d-b67e-600d49ed1e21	16999ea1-869c-4849-8f1b-cb6d37520d48	allowed-protocol-mapper-types	oidc-address-mapper
80a6749b-eab3-414e-98eb-b308059466c1	16999ea1-869c-4849-8f1b-cb6d37520d48	allowed-protocol-mapper-types	saml-user-attribute-mapper
fedba748-9e49-4488-8f09-d97d7c968d08	16999ea1-869c-4849-8f1b-cb6d37520d48	allowed-protocol-mapper-types	saml-user-property-mapper
5b60974e-4809-4c14-a8fb-446d112df1e8	16999ea1-869c-4849-8f1b-cb6d37520d48	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
47ca93c6-627f-4b49-99a6-cfcab4ac940c	16999ea1-869c-4849-8f1b-cb6d37520d48	allowed-protocol-mapper-types	oidc-full-name-mapper
d38e1691-3c7c-4ea8-9527-6257a12fcd14	16999ea1-869c-4849-8f1b-cb6d37520d48	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b0ef4096-3206-4e85-8ab2-820425e6d22e	bde8332c-2bbe-4748-b61f-77eb048011b3	host-sending-registration-request-must-match	true
f402b9dc-5f5d-46b7-a02a-dd8d9e3e975b	bde8332c-2bbe-4748-b61f-77eb048011b3	client-uris-must-match	true
7e7ec006-3195-4549-8492-a26bb7fa5f3f	ae55fabe-371c-46f3-b167-24dd14f708f7	allow-default-scopes	true
6914f214-6a72-4b91-8a45-5963dbefcdc8	fae1afee-b894-45cb-88e2-0d6140fb0f9d	algorithm	RSA-OAEP
9543d4ca-ef15-4db6-a0f4-5fb7bfffe176	fae1afee-b894-45cb-88e2-0d6140fb0f9d	certificate	MIICoTCCAYkCBgGNnix7iTANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAl0ZWtjbGluaWMwHhcNMjQwMjEyMTYzMzUxWhcNMzQwMjEyMTYzNTMxWjAUMRIwEAYDVQQDDAl0ZWtjbGluaWMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIq5wGDuf+mVE9ftAfNOt8SEB5ACzqPW0Codqm3G2Ti0mKuY1aQQdtbUkPMCrEwGfOmJqLAVxBKIWC3JygXfXQ1a+KJRtiJUUm5qLKar/OzyKMM/oKsO73YAeDwU3MxX0KzehzP0UcDWa4ZDl2m/kyYHEPyr50rDUvjlmRr1UT0LDd2cSDOvpN/WIoKXIgg5eGHeNjxwD6hJgNorq8ybtHSVMf6tJelXlJE0NNRi+e6vyGiT1imM/TgkgQlBVjCBKbfLqREz8c0E1RcNMqsNZQAQYCM8TFKdEcs+ohMdg2iR9RCDTnd+M02cgqLG6UZY222+oADkVTJbOQsDwuMWjfAgMBAAEwDQYJKoZIhvcNAQELBQADggEBALTugTBlqRnEJ8yyvwJTTWLsT9MgpLpeSWVuZIBwWOisnhwV+TzDU8rU/iIeVR7em4ORYVv+7I8ysBJ5DtYADvnjj4vGdR2l9WVo6HuVa8yB4DiWkryH+tlW+tFp2TwEixPjDreMTjNp1n7f2T0gu33Fw1E9+TMKSYjQIG/0j4eVJQigrt7pMgEBtZQdCVpLFUu1ZKAdjzXLxKOrDcW/iRt34ns0WyqwrHgjYViLiXIStw8RztY6/fOB4pbVk4bm31iAvPO54O3+xjIsf9R7sWVzPuvPIX9na6i9G4+z9acSvSKasqkACcMmSzxjLz+relYHB/2ggqeW6jVM/Gm/CyE=
302d70fb-0066-426f-a39f-ee51d775642e	fae1afee-b894-45cb-88e2-0d6140fb0f9d	priority	100
00dff434-03b5-4e0a-a567-c3ec3879d9a7	fae1afee-b894-45cb-88e2-0d6140fb0f9d	privateKey	MIIEowIBAAKCAQEAyKucBg7n/plRPX7QHzTrfEhAeQAs6j1tAqHaptxtk4tJirmNWkEHbW1JDzAqxMBnzpiaiwFcQSiFgtycoF310NWviiUbYiVFJuaiymq/zs8ijDP6CrDu92AHg8FNzMV9Cs3ocz9FHA1muGQ5dpv5MmBxD8q+dKw1L45Zka9VE9Cw3dnEgzr6Tf1iKClyIIOXhh3jY8cA+oSYDaK6vMm7R0lTH+rSXpV5SRNDTUYvnur8hok9YpjP04JIEJQVYwgSm3y6kRM/HNBNUXDTKrDWUAEGAjPExSnRHLPqITHYNokfUQg053fjNNnIKixulGWNttvqAA5FUyWzkLA8LjFo3wIDAQABAoIBAAcKKikpcoJDTtvMhcpkEpMwfH6ImIrHiK1fQzeEvR1Z26scf+gRWiYNf7lWLb64QNjSqeOqTECG7OQeqPbHq3aqwGoLi86uH9ZrbRbGMIacGQpFGoaWFwc7nOSs4XW6qeMF2Gh1AqlaX2bX/g7gp7Klba7DPicDd/XJCL0sVilubvSpwdqLUtpXdxIgYacB4QYKT4TzPdLMSkW2IyCqIoZN9S+CmSRC7RZb5kzbomRTseKH8RgxT3utdssCWpaY6QLPXiZ9lsTr73n8nd7CPRs3v0zvPEVDJNLJbNEAme+2Nqi6xjrxgshq1Tq7lBkdp8iMleOAVE2ue2PN2hcxlWUCgYEA8ehX3u8QyeTKtylVTG0g6FfTql80UOvKQD8aIZMVfw+ZMht4hat99WXOCNd9oiGC3x8dmB50od40Y6F1Fcqm5RVfZkI/TDIo3HByFzOefQAsI+IqNHjjLrrlZ5+KOiUNW7/5Y7VTBYu0M+x1ItnWuolv64H66pd9iFt+FuO/oZ0CgYEA1FxHtFoIVvPKaVh68Asc7rmVFiAz6UwOjC9Fh3J/EVr3CVN7qH/R2bpAVWZed0qZoUU71HZ1ejMQTx6WzETvhipsAx4etl1MH+0tYfcgWWUGuHjPoPeMt+FC4Q9gXJJuD2xU5JRe3TN4+TQ9Sdj7vAFjIGkYfK6Kr+FhMNUeuasCgYAG+9ItmXE+ouBHUWYpAq2Eh6SQspbsDyKToD684WYpeOXPUIO2ODE2uG2uS6pQ1+7TSi6siZSMZ8HTboHW0zbmPiu25Aq3xGrxkj149gCJU0vy7UCSqzrDypl82FpBO3ibQXuNqVpwOoxFQ3pOO0O7tuQIRIRd6WmyWhHVz1Vk8QKBgGDIHbXIQny+ZsVUGdNEfU8fLR8EViRBEXA6Kwnr2JVkS6nobjcA6fa8t400NmFPkmy5TOcrhabHlus4GanG0RLoSomxNHYQVx1FzqUTJ58WN9Xi2V2W9H7pHr3LcDNAWQCWcqoqJIHTb5LDiBsb1L5+M1sWCp7oPTSjFtRWjMY5AoGBAO2X/jg7nigABQri1mw2wdtH3Dkj3Wh+ZDCN3xxv8cSr17sWS0JJ9K4qT4LhMh5wKhTBPh4hw/5AxVktZdHp1i9Y5ghEKoojRCMm5cvsXnBKgqZXGVE6WcWKG/0G7ze11ulIuWJkflfHz67ZZ/EbCVriYzFr1sfN/DnbcAkkbpIK
caf60465-e113-4a99-a0e8-85372a2ed521	b085cf5c-016c-4b8f-ac72-599b536e21e8	priority	100
7d82c68f-9f2a-4da5-9852-362134211916	b085cf5c-016c-4b8f-ac72-599b536e21e8	certificate	MIICoTCCAYkCBgGNnix9jzANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAl0ZWtjbGluaWMwHhcNMjQwMjEyMTYzMzUyWhcNMzQwMjEyMTYzNTMyWjAUMRIwEAYDVQQDDAl0ZWtjbGluaWMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDpdMjbqhyUOnEldWTqv9m98LgPJST4qndjH/RNVWtw2kdDIeb5FAIrNdy51XpLgCOEXSGpaplBjV78pH/ZuFQECuRUQHLCUUG++09PMbD8kaKeLaF8OtXPTndrIEJ/QGl72ey73YkCs0TTXSQJ6FTTbY6fx5/EczakKVwIXyRVHIpSLjEEO8G5MjzcvxpqNoFJLCSURHqp49oLbJduJNQ20aEwcF58EL1YeokmWMvWAffpBI7gDKRJO9PtctGmRrTUv2wjgYRF0a408Twj8oQGl6z9yByzXMqPvGPTesZSKwhNSanUyiO/TSX6yLwYXClv1n6vi/vH1uLGSlCbhtaTAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAN9Rym1uxGuGp81xCUrNeZq0ArFKCFqK/dg1ZoGrCBN9ZXOr/WNIJAdUGqFk5tmN39j75x1yAiV21bw5hXWuMrn3cO4Su9uWdHkzzcNkn0nepIC+B1JIptqCrjPdcfVYeIsHZyCLlGUiLSiVTJKWfSUjxux2ADJFNBhqjSsVPAnWvbsOoTqCHNkRWI5AGIx+HnyZMqvmGcfeTpK+579Y1qpgcUYo2zNFl/LuzOG4jwfqEx/0X39M+69D+To6LTHfqVWUDhj0BQYkExrN1gjA8WSGkmdxkphhE+Ror5BUMFOXa9D1nnboBDAOjGBLyD0sBCS3T4l8GQHDgxFy1D0+eNU=
e7deb822-6a23-404c-8761-08e5d7a39459	b085cf5c-016c-4b8f-ac72-599b536e21e8	privateKey	MIIEpAIBAAKCAQEA6XTI26oclDpxJXVk6r/ZvfC4DyUk+Kp3Yx/0TVVrcNpHQyHm+RQCKzXcudV6S4AjhF0hqWqZQY1e/KR/2bhUBArkVEBywlFBvvtPTzGw/JGini2hfDrVz053ayBCf0Bpe9nsu92JArNE010kCehU022On8efxHM2pClcCF8kVRyKUi4xBDvBuTI83L8aajaBSSwklER6qePaC2yXbiTUNtGhMHBefBC9WHqJJljL1gH36QSO4AykSTvT7XLRpka01L9sI4GERdGuNPE8I/KEBpes/cgcs1zKj7xj03rGUisITUmp1Mojv00l+si8GFwpb9Z+r4v7x9bixkpQm4bWkwIDAQABAoIBAEs16g3GsJ1adKA+QUxVkXcdSZbrfw0zkfHX1hNh/RKm58Vrcyd0eDxmhl1CNruDJS4b+N/FLWmOe3cGIgBI35xLzAKOnsoWdolqGkNnvV6pJowyJC/LHp3CaDuVcYbgf/s8GoXtmZnKmlZDz/v3IvjYd1XncIPQIF7jyjgSOrjGMwk+t1RikRyAHDdeVw5n4F8bAucEYo+H8osjvgEy73e7Bao5vM3DTtEgNlhLSZRre+ASjb9w2ls3HV9gzI2pK/C5toZMWEFnNbChzwM0OwUzoJnKIYicS7iIdYjViH7gHZv/J5fRJHksylPyLaJbm12dOkxnhIKKIZ8ny2sjKoECgYEA+JlccEVCW+j35Vs4syYjyw1x+2F6yVLUS8l0s5osqphXz2LXHS7ZdJwseyQ5P1asR2+whsOWDckKWNoKY3K2YZjcaaf3Z3c95lIkSzl4wg0JHx76H2YAaXhD06eDHQtB2RbW9nvGYpGdgIHYbKVu+/PVv7Qc3oPnvLzxGnvZT4ECgYEA8GgEAoji1twHYlVzPaZuc64BlsDC64XL19GUKRk4wyMTCaQ8T5vq6HuFXntBgZnCoN5S5nJDoRQ1eZD74G5WMmm3mXAgHZkeapF3aPPkzNC6+e9VjfZDbZzeDd+gwf0d+5CsMJ3uE+cxzr+5W+/rarZxqqvZH61zJRM+Us5d8BMCgYEA7Fq65U8kAUhk8B4jsUgwvawh03Phjql+iDOYDe4mS2eeDOGXTfqt6s1VCRruhsa78wtAlVA9SQv8F2/ucpCsz+vKm3WDpk5bfrBYK2EP68cDBiCog9OxzpT2P7RC1wlN6L1rUVtqyWpSicxp3RoIg+lXLvVqgTB90hb9UEWx3YECgYAqNtmdaFQMzo4tYjveM39pqMB2rFqN6OymdRLDNL6W5W3OX5yHjiVttWLx+ErEay+V9/QuqxndCyNouWDBRB62s4Gd2+aHy/9fTzPcphcjL/PlN3WafAfTE5yaaw5bggrlxb22u8S2kf5ZA6mUz0hTcL387jguK9LwS7TB7aLpKQKBgQCjhIDmIWgvcoG2oUHAIx524yP6xoAAF8YNAU6BEgfrmcuNznpSxt6HL1Su5FgmQRqlTUIAo8rhaq0C7hln9ak4BLN0MqKsRKl2wGgZf6/KbDhPiL+wkcIWm1KRL2M9pCGHYhEU+sm28CR1asgAWQyoHH9SBVYTh1qckPDVnxvodw==
053f7707-fb58-4325-bcf9-5bc5316efbba	efe25048-7d18-4cb8-82c4-db31ff196f58	allow-default-scopes	true
45e25bd2-88ec-436e-814f-d9a70e139498	c6157425-ffdb-4cdc-8dca-bda8b83bb2bc	priority	100
26c223a1-4a47-4d1b-b933-6dd4e989c959	c6157425-ffdb-4cdc-8dca-bda8b83bb2bc	kid	515a98bd-c5e8-4ca5-99d6-4e66738f3f22
b906ffbb-0183-4f78-991d-720752981edb	c6157425-ffdb-4cdc-8dca-bda8b83bb2bc	algorithm	HS256
d162abbf-fdda-499d-a950-48eec5c9fcd7	c6157425-ffdb-4cdc-8dca-bda8b83bb2bc	secret	hSwRBz229Oq2c9vpP96hwP-XI7anuoAiEpg3HthqfoeP11J9f_s25jG2wFcRPCe9fwilRZpvknzYLOoJUCphuA
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
4ae97f09-282f-4c97-af74-655bbbf587be	1897f3a9-6058-417d-8b4e-cf1dea9d0961
4ae97f09-282f-4c97-af74-655bbbf587be	20896bb7-c85e-424a-8a33-9a07903a94be
4ae97f09-282f-4c97-af74-655bbbf587be	e32a92fd-ee49-420d-a8d0-46af3e6a0bb7
4ae97f09-282f-4c97-af74-655bbbf587be	c36e2252-135b-4233-8223-094d9e6c1d18
4ae97f09-282f-4c97-af74-655bbbf587be	b09481d9-9f32-4a00-8c6f-e4d6973355f1
4ae97f09-282f-4c97-af74-655bbbf587be	a3fc6878-c354-4115-bb16-fe52875da80e
4ae97f09-282f-4c97-af74-655bbbf587be	9461cd74-bf28-4380-9b86-4cf2d2c48c06
4ae97f09-282f-4c97-af74-655bbbf587be	9a394510-9d55-4c49-bfe3-4e2c398fd94a
4ae97f09-282f-4c97-af74-655bbbf587be	48a8eb5e-c7ba-4c59-85f1-231e757c8b23
4ae97f09-282f-4c97-af74-655bbbf587be	7c7695b2-72fa-452b-81e8-9748e91504a5
4ae97f09-282f-4c97-af74-655bbbf587be	81637bbb-ccec-4569-af13-fd39b11d3204
4ae97f09-282f-4c97-af74-655bbbf587be	c934471f-e57d-4465-88b7-3f87a547756d
4ae97f09-282f-4c97-af74-655bbbf587be	2fa24168-207a-4ab7-8025-0632e3b3b07b
4ae97f09-282f-4c97-af74-655bbbf587be	7077a022-fd43-4ec1-ad50-ab77f1f73b8f
4ae97f09-282f-4c97-af74-655bbbf587be	b7016c88-f0bd-4cf2-9f1a-802de20eab0f
4ae97f09-282f-4c97-af74-655bbbf587be	5860e6c4-c610-4f6b-955e-16248384aba9
4ae97f09-282f-4c97-af74-655bbbf587be	ed498025-5831-4442-bb93-920e34019f42
4ae97f09-282f-4c97-af74-655bbbf587be	cc7da313-47c8-4083-940b-c5923041e2c1
203ef85f-ceb0-470d-9c17-eebc02bf0b5f	f83308fc-beef-4127-9b6e-b39e3b800839
b09481d9-9f32-4a00-8c6f-e4d6973355f1	5860e6c4-c610-4f6b-955e-16248384aba9
c36e2252-135b-4233-8223-094d9e6c1d18	cc7da313-47c8-4083-940b-c5923041e2c1
c36e2252-135b-4233-8223-094d9e6c1d18	b7016c88-f0bd-4cf2-9f1a-802de20eab0f
203ef85f-ceb0-470d-9c17-eebc02bf0b5f	e41fb509-d926-482f-97cf-9377bdb156f9
e41fb509-d926-482f-97cf-9377bdb156f9	567ae812-d6f9-4357-aef6-146428fa5325
ee282344-67fa-4bfc-9aa5-15f67bf3570a	f1ec94a5-7bd7-49ab-b088-d5533b9f5f3d
4ae97f09-282f-4c97-af74-655bbbf587be	cb0e9d46-d57d-4ac0-939a-331e8d1e1251
203ef85f-ceb0-470d-9c17-eebc02bf0b5f	0ce7f3cd-5431-4edf-8bab-1d21ad9fc30a
203ef85f-ceb0-470d-9c17-eebc02bf0b5f	648d9f13-0be4-4548-a630-48574c3f0d9d
4ae97f09-282f-4c97-af74-655bbbf587be	92b8318b-9034-48b8-8aba-d787fa820875
4ae97f09-282f-4c97-af74-655bbbf587be	ec0decb7-436d-43c0-9c9b-33feb5c8a7db
4ae97f09-282f-4c97-af74-655bbbf587be	1bc4bcda-5080-4c47-b8ef-1398c1b675e9
4ae97f09-282f-4c97-af74-655bbbf587be	69843657-0d99-45c1-ac64-4c3c9f03fc5c
4ae97f09-282f-4c97-af74-655bbbf587be	69301b89-a05d-40a4-a613-9069c11c71ff
4ae97f09-282f-4c97-af74-655bbbf587be	bfb2f240-1a94-43fc-a710-b3edefb3c905
4ae97f09-282f-4c97-af74-655bbbf587be	994ace4f-05c6-4a0f-90bd-6600f58f5dd8
4ae97f09-282f-4c97-af74-655bbbf587be	0d33a770-e323-4e6d-a9ce-28a8d8eaf273
4ae97f09-282f-4c97-af74-655bbbf587be	5e5c1ec4-3c59-41a5-9500-c0a94a2b640e
4ae97f09-282f-4c97-af74-655bbbf587be	dbf06260-80bf-46a1-94ed-c5dedfce7cf1
4ae97f09-282f-4c97-af74-655bbbf587be	8e09d6f9-5e87-45c1-950c-43fa919fd922
4ae97f09-282f-4c97-af74-655bbbf587be	2bc5902d-2cc2-4527-9f20-b55a9c0a5cf7
4ae97f09-282f-4c97-af74-655bbbf587be	4ef0620f-46bf-4fc7-9b79-de137c94333d
4ae97f09-282f-4c97-af74-655bbbf587be	879072fb-f696-47a7-879d-a19d39da8605
4ae97f09-282f-4c97-af74-655bbbf587be	5b335f06-ee46-49c1-9dba-66c1abed5a68
4ae97f09-282f-4c97-af74-655bbbf587be	0d06fb40-dc3a-41f3-b11d-4aed80acee44
4ae97f09-282f-4c97-af74-655bbbf587be	fb867772-b20d-4d05-94c1-ff707573ae72
1bc4bcda-5080-4c47-b8ef-1398c1b675e9	fb867772-b20d-4d05-94c1-ff707573ae72
1bc4bcda-5080-4c47-b8ef-1398c1b675e9	879072fb-f696-47a7-879d-a19d39da8605
69843657-0d99-45c1-ac64-4c3c9f03fc5c	5b335f06-ee46-49c1-9dba-66c1abed5a68
24f1b422-b8d9-4215-8bd6-d761c4d68a68	8a87487b-5131-4680-a891-c39e415c8b37
6ee7eeee-b7da-42b4-9526-dfab70e42c03	cb73a38e-143d-47c0-82d2-03c5dbc9f347
775978cd-33ee-4abd-810e-ef0ad23c0277	0d76ebc0-dabb-4d52-80ca-41b2922296bb
775978cd-33ee-4abd-810e-ef0ad23c0277	76abdf76-cd3f-47b0-ad3a-1205cd3bb7d7
98b193c6-559a-4657-a1c2-cc82281cc5b4	8a87487b-5131-4680-a891-c39e415c8b37
98b193c6-559a-4657-a1c2-cc82281cc5b4	4d917696-10bb-4dee-8ffd-b984b3deda52
98b193c6-559a-4657-a1c2-cc82281cc5b4	b4f19582-7f11-4599-85a3-b357e7859b88
98b193c6-559a-4657-a1c2-cc82281cc5b4	bdbb0194-70ae-4850-a120-86d50ea96982
98b193c6-559a-4657-a1c2-cc82281cc5b4	b579da5b-f1f9-4f5f-a265-3fe1fc59bb85
98b193c6-559a-4657-a1c2-cc82281cc5b4	bceefe31-feb4-4846-b1a2-d81257f9fd4a
98b193c6-559a-4657-a1c2-cc82281cc5b4	e7423073-baa2-42e2-87c4-0ffe546dc84f
98b193c6-559a-4657-a1c2-cc82281cc5b4	4a5cfde6-9a21-4550-90be-198a6c971125
98b193c6-559a-4657-a1c2-cc82281cc5b4	0d76ebc0-dabb-4d52-80ca-41b2922296bb
98b193c6-559a-4657-a1c2-cc82281cc5b4	0430b875-7d86-4c46-a26d-3348bfa17d1f
98b193c6-559a-4657-a1c2-cc82281cc5b4	775978cd-33ee-4abd-810e-ef0ad23c0277
98b193c6-559a-4657-a1c2-cc82281cc5b4	7f38f0ae-251a-4bb3-8362-f0a3ab7c93d9
98b193c6-559a-4657-a1c2-cc82281cc5b4	c349be39-4507-43cc-9ed5-a7a2d846bfbd
98b193c6-559a-4657-a1c2-cc82281cc5b4	7209ccd3-ea88-4d3c-a0a2-d40d3ff320fd
98b193c6-559a-4657-a1c2-cc82281cc5b4	35a4e591-458a-4d7b-bce2-c4e55ca2208f
98b193c6-559a-4657-a1c2-cc82281cc5b4	d35435e2-36f0-433e-b21d-9e282633d182
98b193c6-559a-4657-a1c2-cc82281cc5b4	24f1b422-b8d9-4215-8bd6-d761c4d68a68
98b193c6-559a-4657-a1c2-cc82281cc5b4	76abdf76-cd3f-47b0-ad3a-1205cd3bb7d7
bd6f2982-6db9-426e-9234-3c15867d9215	6ee7eeee-b7da-42b4-9526-dfab70e42c03
bd6f2982-6db9-426e-9234-3c15867d9215	2fa4f64f-fe91-440a-b180-4702a6e67512
bd6f2982-6db9-426e-9234-3c15867d9215	21aa873f-2036-4cad-a296-2657956d5fcb
bd6f2982-6db9-426e-9234-3c15867d9215	cd42766e-6606-401b-b777-29577067222c
cceda277-92c7-413d-9b87-f804c6ca6e70	cded9dd3-7c95-4bd7-b74d-9aafa434543b
4ae97f09-282f-4c97-af74-655bbbf587be	aaa6942c-e092-48ce-9c9d-4784d5415f7e
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
5daa2d85-4c7a-4185-becd-512142adc119	\N	password	5f716f5b-6c06-41b9-8722-6b4e4b9f2e78	1707755733794	\N	{"value":"F3xxYZd0VqbZNUnRHLqRCv3AMTd8D8jpVq7UuSMUpZ8=","salt":"l9Q60asvzK9AB8UTV+szMw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
a7f84cd0-36bb-497b-a833-3e408456df1e	\N	password	e6badb8c-23ef-46e7-b9ac-d7826f18aeef	1711114736612	My password	{"value":"VMH+kl6euO41xd3Toh8/MLtaXP4s6x9yW2Xz+TgAZfk=","salt":"DrhTtTAIvRZ7HOoAyO57xg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-02-12 16:35:10.396751	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	7755707762
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-02-12 16:35:10.500339	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	7755707762
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-02-12 16:35:10.69412	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	7755707762
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-02-12 16:35:10.713336	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	7755707762
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-02-12 16:35:11.341858	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	7755707762
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-02-12 16:35:11.41674	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	7755707762
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-02-12 16:35:12.135498	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	7755707762
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-02-12 16:35:12.298365	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	7755707762
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-02-12 16:35:12.334836	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	7755707762
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-02-12 16:35:13.252727	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	7755707762
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-02-12 16:35:13.725433	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	7755707762
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-02-12 16:35:13.789905	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	7755707762
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-02-12 16:35:13.909517	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	7755707762
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-02-12 16:35:14.110674	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	7755707762
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-02-12 16:35:14.120328	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	7755707762
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-02-12 16:35:14.145964	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	7755707762
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-02-12 16:35:14.160099	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	7755707762
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-02-12 16:35:14.586492	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	7755707762
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-02-12 16:35:14.866464	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	7755707762
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-02-12 16:35:14.894138	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	7755707762
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-02-12 16:35:14.919559	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	7755707762
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-02-12 16:35:14.945302	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	7755707762
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-02-12 16:35:15.092635	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	7755707762
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-02-12 16:35:15.112779	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	7755707762
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-02-12 16:35:15.119985	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	7755707762
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-02-12 16:35:15.352173	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	7755707762
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-02-12 16:35:16.020657	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	7755707762
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-02-12 16:35:16.058257	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	7755707762
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-02-12 16:35:16.491882	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	7755707762
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-02-12 16:35:16.62059	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	7755707762
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-02-12 16:35:16.740331	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	7755707762
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-02-12 16:35:16.757677	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	7755707762
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-02-12 16:35:16.775773	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	7755707762
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-02-12 16:35:16.788005	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	7755707762
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-02-12 16:35:17.104596	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	7755707762
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-02-12 16:35:17.134931	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	7755707762
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-02-12 16:35:17.175423	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	7755707762
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-02-12 16:35:17.195989	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	7755707762
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-02-12 16:35:17.214224	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	7755707762
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-02-12 16:35:17.22254	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	7755707762
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-02-12 16:35:17.235123	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	7755707762
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-02-12 16:35:17.252867	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	7755707762
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-02-12 16:35:18.675777	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	7755707762
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-02-12 16:35:18.696519	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	7755707762
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-12 16:35:18.717325	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	7755707762
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-12 16:35:18.739247	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	7755707762
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-12 16:35:18.766951	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	7755707762
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-12 16:35:19.001405	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	7755707762
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-12 16:35:19.020254	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	7755707762
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-02-12 16:35:19.256603	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	7755707762
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-02-12 16:35:19.41339	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	7755707762
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-02-12 16:35:19.425863	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	7755707762
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-02-12 16:35:19.435227	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	7755707762
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-02-12 16:35:19.443831	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	7755707762
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-02-12 16:35:19.472586	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	7755707762
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-02-12 16:35:19.49752	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	7755707762
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-02-12 16:35:19.60107	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	7755707762
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-02-12 16:35:20.206885	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	7755707762
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-02-12 16:35:20.36262	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	7755707762
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-02-12 16:35:20.389175	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	7755707762
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-02-12 16:35:20.419992	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	7755707762
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-02-12 16:35:20.444649	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	7755707762
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-02-12 16:35:20.456579	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	7755707762
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-02-12 16:35:20.470115	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	7755707762
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-02-12 16:35:20.479579	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	7755707762
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-02-12 16:35:20.561294	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	7755707762
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-02-12 16:35:20.589107	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	7755707762
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-02-12 16:35:20.604663	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	7755707762
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-02-12 16:35:20.649216	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	7755707762
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-02-12 16:35:20.671694	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	7755707762
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-02-12 16:35:20.689237	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	7755707762
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-12 16:35:20.708949	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	7755707762
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-12 16:35:20.732315	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	7755707762
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-12 16:35:20.738352	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	7755707762
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-12 16:35:20.82474	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	7755707762
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-12 16:35:20.85015	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	7755707762
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-02-12 16:35:20.861457	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	7755707762
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-02-12 16:35:20.866957	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	7755707762
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-02-12 16:35:20.935186	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	7755707762
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-02-12 16:35:20.94335	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	7755707762
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-12 16:35:20.967769	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	7755707762
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-12 16:35:20.973166	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	7755707762
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-12 16:35:20.99328	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	7755707762
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-12 16:35:20.999438	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	7755707762
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-12 16:35:21.022175	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	7755707762
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-02-12 16:35:21.034811	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	7755707762
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-02-12 16:35:21.050582	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	7755707762
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-02-12 16:35:21.095557	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	7755707762
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-12 16:35:21.111435	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	7755707762
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-12 16:35:21.159964	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	7755707762
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-12 16:35:21.186496	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	7755707762
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-12 16:35:21.208028	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	7755707762
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-12 16:35:21.214079	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	7755707762
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-12 16:35:21.245328	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	7755707762
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-12 16:35:21.252173	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	7755707762
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-12 16:35:21.274903	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	7755707762
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-12 16:35:21.337506	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	7755707762
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-12 16:35:21.345216	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	7755707762
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-12 16:35:21.384859	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	7755707762
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-12 16:35:21.412949	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	7755707762
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-12 16:35:21.420927	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	7755707762
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-12 16:35:21.458019	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	7755707762
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-12 16:35:21.470198	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	7755707762
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-02-12 16:35:21.49075	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	7755707762
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-02-12 16:35:21.514931	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	7755707762
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-02-12 16:35:21.545075	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	7755707762
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-02-12 16:35:21.559162	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	7755707762
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-02-12 16:35:21.581366	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	7755707762
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-02-12 16:35:21.586597	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	7755707762
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-02-12 16:35:21.622	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	7755707762
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-02-12 16:35:21.634745	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	7755707762
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-02-12 16:35:21.908509	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	7755707762
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-02-12 16:35:21.91984	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	7755707762
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-02-12 16:35:21.933183	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	7755707762
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-02-12 16:35:21.938564	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	7755707762
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-02-12 16:35:21.964354	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	7755707762
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-02-12 16:35:21.976991	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	7755707762
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
319844d6-c993-472b-b6db-ed5f70b1d9fa	e4917aff-9d41-4b56-818d-573c22374851	f
319844d6-c993-472b-b6db-ed5f70b1d9fa	aecb8531-227e-4656-9ea8-24cff5842127	t
319844d6-c993-472b-b6db-ed5f70b1d9fa	35bf0504-dc09-47b2-9cde-13f37b2e23e9	t
319844d6-c993-472b-b6db-ed5f70b1d9fa	dacf51ef-e4af-454d-8786-819441f86522	t
319844d6-c993-472b-b6db-ed5f70b1d9fa	b9d47b40-8102-46dd-b163-d6d580bb04e7	f
319844d6-c993-472b-b6db-ed5f70b1d9fa	dbf135ed-fbe1-4f06-933e-021281845cad	f
319844d6-c993-472b-b6db-ed5f70b1d9fa	8b286dd1-dec4-49a4-a89c-1aed2bd01513	t
319844d6-c993-472b-b6db-ed5f70b1d9fa	51c0257f-9717-43b5-be08-e451687bff14	t
319844d6-c993-472b-b6db-ed5f70b1d9fa	07279171-c967-4fab-a018-eaa52812be5a	f
319844d6-c993-472b-b6db-ed5f70b1d9fa	513d8b8f-65a9-4405-8edc-70727cdc48d2	t
9221edbb-59a4-49c1-a953-17a986e6ecd2	1b885366-4134-48cb-a339-31353e63dcc7	t
9221edbb-59a4-49c1-a953-17a986e6ecd2	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9	t
9221edbb-59a4-49c1-a953-17a986e6ecd2	b17c6014-93e8-439a-a134-ac2cd9512121	t
9221edbb-59a4-49c1-a953-17a986e6ecd2	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5	t
9221edbb-59a4-49c1-a953-17a986e6ecd2	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba	t
9221edbb-59a4-49c1-a953-17a986e6ecd2	295d66c3-7adb-4ce1-9c7c-97615de735ca	t
9221edbb-59a4-49c1-a953-17a986e6ecd2	4b96c031-2373-4029-9edb-2bc0e665bcaa	f
9221edbb-59a4-49c1-a953-17a986e6ecd2	1cf577e5-b480-4659-84ff-d5671e8ef358	f
9221edbb-59a4-49c1-a953-17a986e6ecd2	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90	f
9221edbb-59a4-49c1-a953-17a986e6ecd2	054dce8d-0a1c-44d0-a888-684ea11eff05	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
203ef85f-ceb0-470d-9c17-eebc02bf0b5f	319844d6-c993-472b-b6db-ed5f70b1d9fa	f	${role_default-roles}	default-roles-master	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N	\N
1897f3a9-6058-417d-8b4e-cf1dea9d0961	319844d6-c993-472b-b6db-ed5f70b1d9fa	f	${role_create-realm}	create-realm	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N	\N
4ae97f09-282f-4c97-af74-655bbbf587be	319844d6-c993-472b-b6db-ed5f70b1d9fa	f	${role_admin}	admin	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N	\N
20896bb7-c85e-424a-8a33-9a07903a94be	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_create-client}	create-client	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
e32a92fd-ee49-420d-a8d0-46af3e6a0bb7	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_view-realm}	view-realm	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
c36e2252-135b-4233-8223-094d9e6c1d18	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_view-users}	view-users	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
b09481d9-9f32-4a00-8c6f-e4d6973355f1	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_view-clients}	view-clients	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
a3fc6878-c354-4115-bb16-fe52875da80e	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_view-events}	view-events	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
9461cd74-bf28-4380-9b86-4cf2d2c48c06	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_view-identity-providers}	view-identity-providers	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
9a394510-9d55-4c49-bfe3-4e2c398fd94a	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_view-authorization}	view-authorization	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
48a8eb5e-c7ba-4c59-85f1-231e757c8b23	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_manage-realm}	manage-realm	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
7c7695b2-72fa-452b-81e8-9748e91504a5	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_manage-users}	manage-users	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
81637bbb-ccec-4569-af13-fd39b11d3204	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_manage-clients}	manage-clients	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
c934471f-e57d-4465-88b7-3f87a547756d	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_manage-events}	manage-events	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
2fa24168-207a-4ab7-8025-0632e3b3b07b	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_manage-identity-providers}	manage-identity-providers	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
7077a022-fd43-4ec1-ad50-ab77f1f73b8f	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_manage-authorization}	manage-authorization	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
b7016c88-f0bd-4cf2-9f1a-802de20eab0f	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_query-users}	query-users	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
5860e6c4-c610-4f6b-955e-16248384aba9	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_query-clients}	query-clients	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
ed498025-5831-4442-bb93-920e34019f42	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_query-realms}	query-realms	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
ea2163e5-97ad-4880-85c6-7a494bdae39b	291174d2-2dd5-486e-afd5-25223d4acded	t	\N	uma_protection	9221edbb-59a4-49c1-a953-17a986e6ecd2	291174d2-2dd5-486e-afd5-25223d4acded	\N
cc7da313-47c8-4083-940b-c5923041e2c1	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_query-groups}	query-groups	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
f83308fc-beef-4127-9b6e-b39e3b800839	a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	${role_view-profile}	view-profile	319844d6-c993-472b-b6db-ed5f70b1d9fa	a6fa7888-d7d4-4839-bf0f-624e7fa91276	\N
e41fb509-d926-482f-97cf-9377bdb156f9	a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	${role_manage-account}	manage-account	319844d6-c993-472b-b6db-ed5f70b1d9fa	a6fa7888-d7d4-4839-bf0f-624e7fa91276	\N
567ae812-d6f9-4357-aef6-146428fa5325	a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	${role_manage-account-links}	manage-account-links	319844d6-c993-472b-b6db-ed5f70b1d9fa	a6fa7888-d7d4-4839-bf0f-624e7fa91276	\N
3423e070-8766-485c-b4dc-df345dac404e	a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	${role_view-applications}	view-applications	319844d6-c993-472b-b6db-ed5f70b1d9fa	a6fa7888-d7d4-4839-bf0f-624e7fa91276	\N
f1ec94a5-7bd7-49ab-b088-d5533b9f5f3d	a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	${role_view-consent}	view-consent	319844d6-c993-472b-b6db-ed5f70b1d9fa	a6fa7888-d7d4-4839-bf0f-624e7fa91276	\N
ee282344-67fa-4bfc-9aa5-15f67bf3570a	a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	${role_manage-consent}	manage-consent	319844d6-c993-472b-b6db-ed5f70b1d9fa	a6fa7888-d7d4-4839-bf0f-624e7fa91276	\N
c7de59c1-614b-4e61-b62c-f0270a59b132	a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	${role_view-groups}	view-groups	319844d6-c993-472b-b6db-ed5f70b1d9fa	a6fa7888-d7d4-4839-bf0f-624e7fa91276	\N
77db21d9-4376-47ed-96ac-1e49ae9d996e	a6fa7888-d7d4-4839-bf0f-624e7fa91276	t	${role_delete-account}	delete-account	319844d6-c993-472b-b6db-ed5f70b1d9fa	a6fa7888-d7d4-4839-bf0f-624e7fa91276	\N
b1c26a51-92f3-4531-b347-cb37b4c2ff80	93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	t	${role_read-token}	read-token	319844d6-c993-472b-b6db-ed5f70b1d9fa	93b2446e-4cec-4a69-ba4e-81d8e01d5e9a	\N
cb0e9d46-d57d-4ac0-939a-331e8d1e1251	062d8dbd-56cf-46cc-a577-e924544c0989	t	${role_impersonation}	impersonation	319844d6-c993-472b-b6db-ed5f70b1d9fa	062d8dbd-56cf-46cc-a577-e924544c0989	\N
0ce7f3cd-5431-4edf-8bab-1d21ad9fc30a	319844d6-c993-472b-b6db-ed5f70b1d9fa	f	${role_offline-access}	offline_access	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N	\N
648d9f13-0be4-4548-a630-48574c3f0d9d	319844d6-c993-472b-b6db-ed5f70b1d9fa	f	${role_uma_authorization}	uma_authorization	319844d6-c993-472b-b6db-ed5f70b1d9fa	\N	\N
bd6f2982-6db9-426e-9234-3c15867d9215	9221edbb-59a4-49c1-a953-17a986e6ecd2	f	${role_default-roles}	default-roles-tekclinic	9221edbb-59a4-49c1-a953-17a986e6ecd2	\N	\N
92b8318b-9034-48b8-8aba-d787fa820875	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_create-client}	create-client	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
ec0decb7-436d-43c0-9c9b-33feb5c8a7db	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_view-realm}	view-realm	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
1bc4bcda-5080-4c47-b8ef-1398c1b675e9	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_view-users}	view-users	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
69843657-0d99-45c1-ac64-4c3c9f03fc5c	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_view-clients}	view-clients	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
69301b89-a05d-40a4-a613-9069c11c71ff	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_view-events}	view-events	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
b579da5b-f1f9-4f5f-a265-3fe1fc59bb85	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_query-realms}	query-realms	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
bfb2f240-1a94-43fc-a710-b3edefb3c905	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_view-identity-providers}	view-identity-providers	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
994ace4f-05c6-4a0f-90bd-6600f58f5dd8	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_view-authorization}	view-authorization	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
0d33a770-e323-4e6d-a9ce-28a8d8eaf273	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_manage-realm}	manage-realm	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
5e5c1ec4-3c59-41a5-9500-c0a94a2b640e	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_manage-users}	manage-users	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
dbf06260-80bf-46a1-94ed-c5dedfce7cf1	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_manage-clients}	manage-clients	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
8e09d6f9-5e87-45c1-950c-43fa919fd922	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_manage-events}	manage-events	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
2bc5902d-2cc2-4527-9f20-b55a9c0a5cf7	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_manage-identity-providers}	manage-identity-providers	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
4ef0620f-46bf-4fc7-9b79-de137c94333d	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_manage-authorization}	manage-authorization	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
879072fb-f696-47a7-879d-a19d39da8605	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_query-users}	query-users	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
5b335f06-ee46-49c1-9dba-66c1abed5a68	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_query-clients}	query-clients	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
0d06fb40-dc3a-41f3-b11d-4aed80acee44	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_query-realms}	query-realms	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
fb867772-b20d-4d05-94c1-ff707573ae72	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_query-groups}	query-groups	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
2fa4f64f-fe91-440a-b180-4702a6e67512	9221edbb-59a4-49c1-a953-17a986e6ecd2	f	${role_offline-access}	offline_access	9221edbb-59a4-49c1-a953-17a986e6ecd2	\N	\N
21aa873f-2036-4cad-a296-2657956d5fcb	9221edbb-59a4-49c1-a953-17a986e6ecd2	f	${role_uma_authorization}	uma_authorization	9221edbb-59a4-49c1-a953-17a986e6ecd2	\N	\N
8a87487b-5131-4680-a891-c39e415c8b37	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_query-clients}	query-clients	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
4d917696-10bb-4dee-8ffd-b984b3deda52	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_view-authorization}	view-authorization	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
b4f19582-7f11-4599-85a3-b357e7859b88	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_manage-clients}	manage-clients	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
bdbb0194-70ae-4850-a120-86d50ea96982	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_view-identity-providers}	view-identity-providers	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
bceefe31-feb4-4846-b1a2-d81257f9fd4a	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_manage-realm}	manage-realm	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
e7423073-baa2-42e2-87c4-0ffe546dc84f	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_manage-users}	manage-users	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
4a5cfde6-9a21-4550-90be-198a6c971125	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_manage-events}	manage-events	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
0d76ebc0-dabb-4d52-80ca-41b2922296bb	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_query-users}	query-users	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
0430b875-7d86-4c46-a26d-3348bfa17d1f	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_manage-authorization}	manage-authorization	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
7f38f0ae-251a-4bb3-8362-f0a3ab7c93d9	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_view-realm}	view-realm	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
775978cd-33ee-4abd-810e-ef0ad23c0277	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_view-users}	view-users	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
c349be39-4507-43cc-9ed5-a7a2d846bfbd	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_create-client}	create-client	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
98b193c6-559a-4657-a1c2-cc82281cc5b4	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_realm-admin}	realm-admin	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
7209ccd3-ea88-4d3c-a0a2-d40d3ff320fd	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_manage-identity-providers}	manage-identity-providers	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
35a4e591-458a-4d7b-bce2-c4e55ca2208f	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_impersonation}	impersonation	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
d35435e2-36f0-433e-b21d-9e282633d182	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_view-events}	view-events	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
24f1b422-b8d9-4215-8bd6-d761c4d68a68	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_view-clients}	view-clients	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
76abdf76-cd3f-47b0-ad3a-1205cd3bb7d7	17bc51b0-295d-4165-aa7f-61ecd9be7165	t	${role_query-groups}	query-groups	9221edbb-59a4-49c1-a953-17a986e6ecd2	17bc51b0-295d-4165-aa7f-61ecd9be7165	\N
2e6fe9bd-89c3-4400-8f49-f4a1e63a8d60	088cf0d3-560a-4164-b704-9f47a63f0897	t	${role_read-token}	read-token	9221edbb-59a4-49c1-a953-17a986e6ecd2	088cf0d3-560a-4164-b704-9f47a63f0897	\N
01ec5858-68d7-433b-b7cf-a96a10d1b326	35f91e48-5547-4615-b233-5753a6a66334	t	${role_view-groups}	view-groups	9221edbb-59a4-49c1-a953-17a986e6ecd2	35f91e48-5547-4615-b233-5753a6a66334	\N
cded9dd3-7c95-4bd7-b74d-9aafa434543b	35f91e48-5547-4615-b233-5753a6a66334	t	${role_view-consent}	view-consent	9221edbb-59a4-49c1-a953-17a986e6ecd2	35f91e48-5547-4615-b233-5753a6a66334	\N
aa7e022f-9bc2-47db-b308-130b03564efa	35f91e48-5547-4615-b233-5753a6a66334	t	${role_view-applications}	view-applications	9221edbb-59a4-49c1-a953-17a986e6ecd2	35f91e48-5547-4615-b233-5753a6a66334	\N
6ee7eeee-b7da-42b4-9526-dfab70e42c03	35f91e48-5547-4615-b233-5753a6a66334	t	${role_manage-account}	manage-account	9221edbb-59a4-49c1-a953-17a986e6ecd2	35f91e48-5547-4615-b233-5753a6a66334	\N
31e4f671-b147-49bc-ad47-c44d0e6a890c	35f91e48-5547-4615-b233-5753a6a66334	t	${role_delete-account}	delete-account	9221edbb-59a4-49c1-a953-17a986e6ecd2	35f91e48-5547-4615-b233-5753a6a66334	\N
cb73a38e-143d-47c0-82d2-03c5dbc9f347	35f91e48-5547-4615-b233-5753a6a66334	t	${role_manage-account-links}	manage-account-links	9221edbb-59a4-49c1-a953-17a986e6ecd2	35f91e48-5547-4615-b233-5753a6a66334	\N
cceda277-92c7-413d-9b87-f804c6ca6e70	35f91e48-5547-4615-b233-5753a6a66334	t	${role_manage-consent}	manage-consent	9221edbb-59a4-49c1-a953-17a986e6ecd2	35f91e48-5547-4615-b233-5753a6a66334	\N
cd42766e-6606-401b-b777-29577067222c	35f91e48-5547-4615-b233-5753a6a66334	t	${role_view-profile}	view-profile	9221edbb-59a4-49c1-a953-17a986e6ecd2	35f91e48-5547-4615-b233-5753a6a66334	\N
aaa6942c-e092-48ce-9c9d-4784d5415f7e	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	t	${role_impersonation}	impersonation	319844d6-c993-472b-b6db-ed5f70b1d9fa	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	\N
a90ff6de-1cba-4e54-8241-fb1a63fe6101	9221edbb-59a4-49c1-a953-17a986e6ecd2	f	Can access any resource in the clinic.	admin	9221edbb-59a4-49c1-a953-17a986e6ecd2	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
hcw28	23.0.6	1707755722
8q66b	23.0.7	1711113895
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
aaf3bb2a-2d14-4494-8bf7-7e6a94c91321	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
38697b78-1cc5-4c8b-bf6c-7b6872104e33	defaultResourceType	urn:backend-client:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
d3c6a40a-24d9-4137-9554-8edb55072f74	audience resolve	openid-connect	oidc-audience-resolve-mapper	0094f806-561d-43c1-a2c5-eeea98a2bacf	\N
a6d2f033-add0-4856-bb05-56a2cd5e17cf	locale	openid-connect	oidc-usermodel-attribute-mapper	141e4dad-404a-4615-b772-9adb633ad401	\N
6f6d366a-4ddc-49c6-8c25-035959398f7b	role list	saml	saml-role-list-mapper	\N	aecb8531-227e-4656-9ea8-24cff5842127
62d83249-3afd-46aa-9841-27aa9f627a26	full name	openid-connect	oidc-full-name-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
e730dae2-bc36-452e-932b-520e8d89bae4	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
e11cbef8-e206-4c49-b9e2-0fb51869ec61	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
ba2447fd-d075-470f-bf72-b28e1b3c8583	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
5f85bc9f-5549-4dc9-a026-99aac74acaf4	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
3e3bf18a-e8a6-4ddd-bfb0-9826f8be017a	username	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
8410c1ef-c054-421f-9085-7c40e75209ca	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
a84ef910-2b14-4f03-a226-6faf3fca85c4	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
e4dd4e42-237f-4c31-a017-77681479ffcc	website	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
adcf891b-c27d-4527-b8b6-802b05dd77f4	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
fdc5d6ee-9776-4383-b2b5-61b595b9ce95	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
39ad8bf1-bd11-4c54-b9ec-6af4c7fa2cef	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
6487138b-159a-40b7-a512-1914f4951947	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
7446966c-5124-4554-83d8-3b1ed143dc60	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	35bf0504-dc09-47b2-9cde-13f37b2e23e9
dc993d58-7f79-4313-944d-07474736895e	email	openid-connect	oidc-usermodel-attribute-mapper	\N	dacf51ef-e4af-454d-8786-819441f86522
f672d682-1580-483b-a212-482311554c2e	email verified	openid-connect	oidc-usermodel-property-mapper	\N	dacf51ef-e4af-454d-8786-819441f86522
6667363a-2018-4d55-84aa-32ca37bf0c39	address	openid-connect	oidc-address-mapper	\N	b9d47b40-8102-46dd-b163-d6d580bb04e7
b9637b5f-df76-4538-b639-48d429bba724	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf135ed-fbe1-4f06-933e-021281845cad
f14dbff4-67ef-47fe-b4ca-b3221dc0cdf5	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf135ed-fbe1-4f06-933e-021281845cad
b5fcaca8-c675-4342-ae34-e63974f02fab	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	8b286dd1-dec4-49a4-a89c-1aed2bd01513
6c1a120c-53ea-4142-a0c3-b83262391c43	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	8b286dd1-dec4-49a4-a89c-1aed2bd01513
4c79d400-7991-463c-b292-5b0ec6d820e8	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	8b286dd1-dec4-49a4-a89c-1aed2bd01513
d7f6f7c7-f977-4cda-8b49-5a03b9441be1	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	51c0257f-9717-43b5-be08-e451687bff14
6a154ccc-d2c0-412d-8f87-9fccebce86f9	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	07279171-c967-4fab-a018-eaa52812be5a
5168db96-8426-4154-ae39-79a63bf56d9a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	07279171-c967-4fab-a018-eaa52812be5a
0df0ed73-d7a0-4dd4-a200-67c94ef0bac6	acr loa level	openid-connect	oidc-acr-mapper	\N	513d8b8f-65a9-4405-8edc-70727cdc48d2
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	address	openid-connect	oidc-address-mapper	\N	1cf577e5-b480-4659-84ff-d5671e8ef358
fb33b1fe-9078-4fa9-a030-a16a93209568	role list	saml	saml-role-list-mapper	\N	1b885366-4134-48cb-a339-31353e63dcc7
4bbe6764-833a-4af1-8ee6-70a4bf8ad026	email	openid-connect	oidc-usermodel-attribute-mapper	\N	b17c6014-93e8-439a-a134-ac2cd9512121
df6f6a2e-285c-4c0f-a4e4-ebd1b9d8a888	email verified	openid-connect	oidc-usermodel-property-mapper	\N	b17c6014-93e8-439a-a134-ac2cd9512121
20154421-ecc9-4b28-b522-4893d9d708de	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8b153c1c-bdaa-4958-ad39-a62f6f52b1ba
5ab7379b-6c55-4d65-b308-75ef8d3c2eee	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90
04186653-d8bc-4cbe-bbab-922cdc865564	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f9740ba3-6c66-4b6f-85c6-3bcc8c161e90
928a84c9-9db4-4808-ae54-cedc8f4f7c5f	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5
26807e2d-ebc4-41eb-b0c1-6a4ea4ea0237	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5
46d9a1fc-9a43-4798-8569-892cfd69e5e0	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f1cf68b2-6ab5-4f40-b0e1-2199531ce0c5
201f4e29-6f40-4798-b47c-1eac3449b652	website	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
bed869e8-2a32-4aee-8fdc-71bc033b74c5	username	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
90d32913-ec9e-495f-b04c-0f53dee7df89	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
1b039693-15a5-4879-b297-72062dfb2038	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
a3111a97-340f-4969-8b61-c0465d83af28	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
be1b0ac3-6a99-413a-8c98-d0405f380d4b	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
58643c4f-b268-4173-841f-d8f53904320a	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
7f749d21-8756-4ac4-add0-43b3660e5fd1	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
352a6d72-6ffd-4b86-aa9e-e7cf060df24a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
f0783309-d57e-40ba-ae3c-90320dfbb0a6	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
e3a76d00-68cd-4e3a-add5-eac72070362f	full name	openid-connect	oidc-full-name-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
38745f2c-e033-4953-90b9-76f92afba9c6	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
3939afcf-9b08-446c-8598-1b8222e846b8	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
638f0750-9807-4bcf-8e3d-f4afa995c51e	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	8fdb5e3d-cb6d-4ebe-ba96-9afbec8155f9
8bf6a681-0209-4e0a-90e4-f83a8dc8d0ec	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	054dce8d-0a1c-44d0-a888-684ea11eff05
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	054dce8d-0a1c-44d0-a888-684ea11eff05
55cf560a-3302-4f86-8c76-6d15b3aff06e	acr loa level	openid-connect	oidc-acr-mapper	\N	295d66c3-7adb-4ce1-9c7c-97615de735ca
1fc089de-b498-4764-9582-d3cc221c9e10	audience resolve	openid-connect	oidc-audience-resolve-mapper	d7963a92-c19a-4ca7-a646-90f9cadd92d9	\N
5c7adaca-1d26-470b-b130-3c45b195147c	locale	openid-connect	oidc-usermodel-attribute-mapper	af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	\N
3c907763-b171-45c8-9ba9-fdcb0863bdd9	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	291174d2-2dd5-486e-afd5-25223d4acded	\N
ff26e645-c448-4d62-9874-e2f107d76c7d	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	291174d2-2dd5-486e-afd5-25223d4acded	\N
ceb31af9-c769-421c-aebe-5add7b7fcf95	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	291174d2-2dd5-486e-afd5-25223d4acded	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
a6d2f033-add0-4856-bb05-56a2cd5e17cf	true	introspection.token.claim
a6d2f033-add0-4856-bb05-56a2cd5e17cf	true	userinfo.token.claim
a6d2f033-add0-4856-bb05-56a2cd5e17cf	locale	user.attribute
a6d2f033-add0-4856-bb05-56a2cd5e17cf	true	id.token.claim
a6d2f033-add0-4856-bb05-56a2cd5e17cf	true	access.token.claim
a6d2f033-add0-4856-bb05-56a2cd5e17cf	locale	claim.name
a6d2f033-add0-4856-bb05-56a2cd5e17cf	String	jsonType.label
6f6d366a-4ddc-49c6-8c25-035959398f7b	false	single
6f6d366a-4ddc-49c6-8c25-035959398f7b	Basic	attribute.nameformat
6f6d366a-4ddc-49c6-8c25-035959398f7b	Role	attribute.name
39ad8bf1-bd11-4c54-b9ec-6af4c7fa2cef	true	introspection.token.claim
39ad8bf1-bd11-4c54-b9ec-6af4c7fa2cef	true	userinfo.token.claim
39ad8bf1-bd11-4c54-b9ec-6af4c7fa2cef	zoneinfo	user.attribute
39ad8bf1-bd11-4c54-b9ec-6af4c7fa2cef	true	id.token.claim
39ad8bf1-bd11-4c54-b9ec-6af4c7fa2cef	true	access.token.claim
39ad8bf1-bd11-4c54-b9ec-6af4c7fa2cef	zoneinfo	claim.name
39ad8bf1-bd11-4c54-b9ec-6af4c7fa2cef	String	jsonType.label
3e3bf18a-e8a6-4ddd-bfb0-9826f8be017a	true	introspection.token.claim
3e3bf18a-e8a6-4ddd-bfb0-9826f8be017a	true	userinfo.token.claim
3e3bf18a-e8a6-4ddd-bfb0-9826f8be017a	username	user.attribute
3e3bf18a-e8a6-4ddd-bfb0-9826f8be017a	true	id.token.claim
3e3bf18a-e8a6-4ddd-bfb0-9826f8be017a	true	access.token.claim
3e3bf18a-e8a6-4ddd-bfb0-9826f8be017a	preferred_username	claim.name
3e3bf18a-e8a6-4ddd-bfb0-9826f8be017a	String	jsonType.label
5f85bc9f-5549-4dc9-a026-99aac74acaf4	true	introspection.token.claim
5f85bc9f-5549-4dc9-a026-99aac74acaf4	true	userinfo.token.claim
5f85bc9f-5549-4dc9-a026-99aac74acaf4	nickname	user.attribute
5f85bc9f-5549-4dc9-a026-99aac74acaf4	true	id.token.claim
5f85bc9f-5549-4dc9-a026-99aac74acaf4	true	access.token.claim
5f85bc9f-5549-4dc9-a026-99aac74acaf4	nickname	claim.name
5f85bc9f-5549-4dc9-a026-99aac74acaf4	String	jsonType.label
62d83249-3afd-46aa-9841-27aa9f627a26	true	introspection.token.claim
62d83249-3afd-46aa-9841-27aa9f627a26	true	userinfo.token.claim
62d83249-3afd-46aa-9841-27aa9f627a26	true	id.token.claim
62d83249-3afd-46aa-9841-27aa9f627a26	true	access.token.claim
6487138b-159a-40b7-a512-1914f4951947	true	introspection.token.claim
6487138b-159a-40b7-a512-1914f4951947	true	userinfo.token.claim
6487138b-159a-40b7-a512-1914f4951947	locale	user.attribute
6487138b-159a-40b7-a512-1914f4951947	true	id.token.claim
6487138b-159a-40b7-a512-1914f4951947	true	access.token.claim
6487138b-159a-40b7-a512-1914f4951947	locale	claim.name
6487138b-159a-40b7-a512-1914f4951947	String	jsonType.label
7446966c-5124-4554-83d8-3b1ed143dc60	true	introspection.token.claim
7446966c-5124-4554-83d8-3b1ed143dc60	true	userinfo.token.claim
7446966c-5124-4554-83d8-3b1ed143dc60	updatedAt	user.attribute
7446966c-5124-4554-83d8-3b1ed143dc60	true	id.token.claim
7446966c-5124-4554-83d8-3b1ed143dc60	true	access.token.claim
7446966c-5124-4554-83d8-3b1ed143dc60	updated_at	claim.name
7446966c-5124-4554-83d8-3b1ed143dc60	long	jsonType.label
8410c1ef-c054-421f-9085-7c40e75209ca	true	introspection.token.claim
8410c1ef-c054-421f-9085-7c40e75209ca	true	userinfo.token.claim
8410c1ef-c054-421f-9085-7c40e75209ca	profile	user.attribute
8410c1ef-c054-421f-9085-7c40e75209ca	true	id.token.claim
8410c1ef-c054-421f-9085-7c40e75209ca	true	access.token.claim
8410c1ef-c054-421f-9085-7c40e75209ca	profile	claim.name
8410c1ef-c054-421f-9085-7c40e75209ca	String	jsonType.label
a84ef910-2b14-4f03-a226-6faf3fca85c4	true	introspection.token.claim
a84ef910-2b14-4f03-a226-6faf3fca85c4	true	userinfo.token.claim
a84ef910-2b14-4f03-a226-6faf3fca85c4	picture	user.attribute
a84ef910-2b14-4f03-a226-6faf3fca85c4	true	id.token.claim
a84ef910-2b14-4f03-a226-6faf3fca85c4	true	access.token.claim
a84ef910-2b14-4f03-a226-6faf3fca85c4	picture	claim.name
a84ef910-2b14-4f03-a226-6faf3fca85c4	String	jsonType.label
adcf891b-c27d-4527-b8b6-802b05dd77f4	true	introspection.token.claim
adcf891b-c27d-4527-b8b6-802b05dd77f4	true	userinfo.token.claim
adcf891b-c27d-4527-b8b6-802b05dd77f4	gender	user.attribute
adcf891b-c27d-4527-b8b6-802b05dd77f4	true	id.token.claim
adcf891b-c27d-4527-b8b6-802b05dd77f4	true	access.token.claim
adcf891b-c27d-4527-b8b6-802b05dd77f4	gender	claim.name
adcf891b-c27d-4527-b8b6-802b05dd77f4	String	jsonType.label
ba2447fd-d075-470f-bf72-b28e1b3c8583	true	introspection.token.claim
ba2447fd-d075-470f-bf72-b28e1b3c8583	true	userinfo.token.claim
ba2447fd-d075-470f-bf72-b28e1b3c8583	middleName	user.attribute
ba2447fd-d075-470f-bf72-b28e1b3c8583	true	id.token.claim
ba2447fd-d075-470f-bf72-b28e1b3c8583	true	access.token.claim
ba2447fd-d075-470f-bf72-b28e1b3c8583	middle_name	claim.name
ba2447fd-d075-470f-bf72-b28e1b3c8583	String	jsonType.label
e11cbef8-e206-4c49-b9e2-0fb51869ec61	true	introspection.token.claim
e11cbef8-e206-4c49-b9e2-0fb51869ec61	true	userinfo.token.claim
e11cbef8-e206-4c49-b9e2-0fb51869ec61	firstName	user.attribute
e11cbef8-e206-4c49-b9e2-0fb51869ec61	true	id.token.claim
e11cbef8-e206-4c49-b9e2-0fb51869ec61	true	access.token.claim
e11cbef8-e206-4c49-b9e2-0fb51869ec61	given_name	claim.name
e11cbef8-e206-4c49-b9e2-0fb51869ec61	String	jsonType.label
e4dd4e42-237f-4c31-a017-77681479ffcc	true	introspection.token.claim
e4dd4e42-237f-4c31-a017-77681479ffcc	true	userinfo.token.claim
e4dd4e42-237f-4c31-a017-77681479ffcc	website	user.attribute
e4dd4e42-237f-4c31-a017-77681479ffcc	true	id.token.claim
e4dd4e42-237f-4c31-a017-77681479ffcc	true	access.token.claim
e4dd4e42-237f-4c31-a017-77681479ffcc	website	claim.name
e4dd4e42-237f-4c31-a017-77681479ffcc	String	jsonType.label
e730dae2-bc36-452e-932b-520e8d89bae4	true	introspection.token.claim
e730dae2-bc36-452e-932b-520e8d89bae4	true	userinfo.token.claim
e730dae2-bc36-452e-932b-520e8d89bae4	lastName	user.attribute
e730dae2-bc36-452e-932b-520e8d89bae4	true	id.token.claim
e730dae2-bc36-452e-932b-520e8d89bae4	true	access.token.claim
e730dae2-bc36-452e-932b-520e8d89bae4	family_name	claim.name
e730dae2-bc36-452e-932b-520e8d89bae4	String	jsonType.label
fdc5d6ee-9776-4383-b2b5-61b595b9ce95	true	introspection.token.claim
fdc5d6ee-9776-4383-b2b5-61b595b9ce95	true	userinfo.token.claim
fdc5d6ee-9776-4383-b2b5-61b595b9ce95	birthdate	user.attribute
fdc5d6ee-9776-4383-b2b5-61b595b9ce95	true	id.token.claim
fdc5d6ee-9776-4383-b2b5-61b595b9ce95	true	access.token.claim
fdc5d6ee-9776-4383-b2b5-61b595b9ce95	birthdate	claim.name
fdc5d6ee-9776-4383-b2b5-61b595b9ce95	String	jsonType.label
dc993d58-7f79-4313-944d-07474736895e	true	introspection.token.claim
dc993d58-7f79-4313-944d-07474736895e	true	userinfo.token.claim
dc993d58-7f79-4313-944d-07474736895e	email	user.attribute
dc993d58-7f79-4313-944d-07474736895e	true	id.token.claim
dc993d58-7f79-4313-944d-07474736895e	true	access.token.claim
dc993d58-7f79-4313-944d-07474736895e	email	claim.name
dc993d58-7f79-4313-944d-07474736895e	String	jsonType.label
f672d682-1580-483b-a212-482311554c2e	true	introspection.token.claim
f672d682-1580-483b-a212-482311554c2e	true	userinfo.token.claim
f672d682-1580-483b-a212-482311554c2e	emailVerified	user.attribute
f672d682-1580-483b-a212-482311554c2e	true	id.token.claim
f672d682-1580-483b-a212-482311554c2e	true	access.token.claim
f672d682-1580-483b-a212-482311554c2e	email_verified	claim.name
f672d682-1580-483b-a212-482311554c2e	boolean	jsonType.label
6667363a-2018-4d55-84aa-32ca37bf0c39	formatted	user.attribute.formatted
6667363a-2018-4d55-84aa-32ca37bf0c39	country	user.attribute.country
6667363a-2018-4d55-84aa-32ca37bf0c39	true	introspection.token.claim
6667363a-2018-4d55-84aa-32ca37bf0c39	postal_code	user.attribute.postal_code
6667363a-2018-4d55-84aa-32ca37bf0c39	true	userinfo.token.claim
6667363a-2018-4d55-84aa-32ca37bf0c39	street	user.attribute.street
6667363a-2018-4d55-84aa-32ca37bf0c39	true	id.token.claim
6667363a-2018-4d55-84aa-32ca37bf0c39	region	user.attribute.region
6667363a-2018-4d55-84aa-32ca37bf0c39	true	access.token.claim
6667363a-2018-4d55-84aa-32ca37bf0c39	locality	user.attribute.locality
b9637b5f-df76-4538-b639-48d429bba724	true	introspection.token.claim
b9637b5f-df76-4538-b639-48d429bba724	true	userinfo.token.claim
b9637b5f-df76-4538-b639-48d429bba724	phoneNumber	user.attribute
b9637b5f-df76-4538-b639-48d429bba724	true	id.token.claim
b9637b5f-df76-4538-b639-48d429bba724	true	access.token.claim
b9637b5f-df76-4538-b639-48d429bba724	phone_number	claim.name
b9637b5f-df76-4538-b639-48d429bba724	String	jsonType.label
f14dbff4-67ef-47fe-b4ca-b3221dc0cdf5	true	introspection.token.claim
f14dbff4-67ef-47fe-b4ca-b3221dc0cdf5	true	userinfo.token.claim
f14dbff4-67ef-47fe-b4ca-b3221dc0cdf5	phoneNumberVerified	user.attribute
f14dbff4-67ef-47fe-b4ca-b3221dc0cdf5	true	id.token.claim
f14dbff4-67ef-47fe-b4ca-b3221dc0cdf5	true	access.token.claim
f14dbff4-67ef-47fe-b4ca-b3221dc0cdf5	phone_number_verified	claim.name
f14dbff4-67ef-47fe-b4ca-b3221dc0cdf5	boolean	jsonType.label
4c79d400-7991-463c-b292-5b0ec6d820e8	true	introspection.token.claim
4c79d400-7991-463c-b292-5b0ec6d820e8	true	access.token.claim
6c1a120c-53ea-4142-a0c3-b83262391c43	true	introspection.token.claim
6c1a120c-53ea-4142-a0c3-b83262391c43	true	multivalued
6c1a120c-53ea-4142-a0c3-b83262391c43	foo	user.attribute
6c1a120c-53ea-4142-a0c3-b83262391c43	true	access.token.claim
6c1a120c-53ea-4142-a0c3-b83262391c43	resource_access.${client_id}.roles	claim.name
6c1a120c-53ea-4142-a0c3-b83262391c43	String	jsonType.label
b5fcaca8-c675-4342-ae34-e63974f02fab	true	introspection.token.claim
b5fcaca8-c675-4342-ae34-e63974f02fab	true	multivalued
b5fcaca8-c675-4342-ae34-e63974f02fab	foo	user.attribute
b5fcaca8-c675-4342-ae34-e63974f02fab	true	access.token.claim
b5fcaca8-c675-4342-ae34-e63974f02fab	realm_access.roles	claim.name
b5fcaca8-c675-4342-ae34-e63974f02fab	String	jsonType.label
d7f6f7c7-f977-4cda-8b49-5a03b9441be1	true	introspection.token.claim
d7f6f7c7-f977-4cda-8b49-5a03b9441be1	true	access.token.claim
5168db96-8426-4154-ae39-79a63bf56d9a	true	introspection.token.claim
5168db96-8426-4154-ae39-79a63bf56d9a	true	multivalued
5168db96-8426-4154-ae39-79a63bf56d9a	foo	user.attribute
5168db96-8426-4154-ae39-79a63bf56d9a	true	id.token.claim
5168db96-8426-4154-ae39-79a63bf56d9a	true	access.token.claim
5168db96-8426-4154-ae39-79a63bf56d9a	groups	claim.name
5168db96-8426-4154-ae39-79a63bf56d9a	String	jsonType.label
6a154ccc-d2c0-412d-8f87-9fccebce86f9	true	introspection.token.claim
6a154ccc-d2c0-412d-8f87-9fccebce86f9	true	userinfo.token.claim
6a154ccc-d2c0-412d-8f87-9fccebce86f9	username	user.attribute
6a154ccc-d2c0-412d-8f87-9fccebce86f9	true	id.token.claim
6a154ccc-d2c0-412d-8f87-9fccebce86f9	true	access.token.claim
6a154ccc-d2c0-412d-8f87-9fccebce86f9	upn	claim.name
6a154ccc-d2c0-412d-8f87-9fccebce86f9	String	jsonType.label
0df0ed73-d7a0-4dd4-a200-67c94ef0bac6	true	introspection.token.claim
0df0ed73-d7a0-4dd4-a200-67c94ef0bac6	true	id.token.claim
0df0ed73-d7a0-4dd4-a200-67c94ef0bac6	true	access.token.claim
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	formatted	user.attribute.formatted
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	country	user.attribute.country
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	true	introspection.token.claim
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	postal_code	user.attribute.postal_code
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	true	userinfo.token.claim
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	street	user.attribute.street
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	true	id.token.claim
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	region	user.attribute.region
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	true	access.token.claim
7a9290a5-cfb2-4fcf-b6ee-a8a954360920	locality	user.attribute.locality
fb33b1fe-9078-4fa9-a030-a16a93209568	false	single
fb33b1fe-9078-4fa9-a030-a16a93209568	Basic	attribute.nameformat
fb33b1fe-9078-4fa9-a030-a16a93209568	Role	attribute.name
4bbe6764-833a-4af1-8ee6-70a4bf8ad026	true	introspection.token.claim
4bbe6764-833a-4af1-8ee6-70a4bf8ad026	true	userinfo.token.claim
4bbe6764-833a-4af1-8ee6-70a4bf8ad026	email	user.attribute
4bbe6764-833a-4af1-8ee6-70a4bf8ad026	true	id.token.claim
4bbe6764-833a-4af1-8ee6-70a4bf8ad026	true	access.token.claim
4bbe6764-833a-4af1-8ee6-70a4bf8ad026	email	claim.name
4bbe6764-833a-4af1-8ee6-70a4bf8ad026	String	jsonType.label
df6f6a2e-285c-4c0f-a4e4-ebd1b9d8a888	true	introspection.token.claim
df6f6a2e-285c-4c0f-a4e4-ebd1b9d8a888	true	userinfo.token.claim
df6f6a2e-285c-4c0f-a4e4-ebd1b9d8a888	emailVerified	user.attribute
df6f6a2e-285c-4c0f-a4e4-ebd1b9d8a888	true	id.token.claim
df6f6a2e-285c-4c0f-a4e4-ebd1b9d8a888	true	access.token.claim
df6f6a2e-285c-4c0f-a4e4-ebd1b9d8a888	email_verified	claim.name
df6f6a2e-285c-4c0f-a4e4-ebd1b9d8a888	boolean	jsonType.label
20154421-ecc9-4b28-b522-4893d9d708de	true	introspection.token.claim
20154421-ecc9-4b28-b522-4893d9d708de	true	access.token.claim
04186653-d8bc-4cbe-bbab-922cdc865564	true	introspection.token.claim
04186653-d8bc-4cbe-bbab-922cdc865564	true	userinfo.token.claim
04186653-d8bc-4cbe-bbab-922cdc865564	phoneNumber	user.attribute
04186653-d8bc-4cbe-bbab-922cdc865564	true	id.token.claim
04186653-d8bc-4cbe-bbab-922cdc865564	true	access.token.claim
04186653-d8bc-4cbe-bbab-922cdc865564	phone_number	claim.name
04186653-d8bc-4cbe-bbab-922cdc865564	String	jsonType.label
5ab7379b-6c55-4d65-b308-75ef8d3c2eee	true	introspection.token.claim
5ab7379b-6c55-4d65-b308-75ef8d3c2eee	true	userinfo.token.claim
5ab7379b-6c55-4d65-b308-75ef8d3c2eee	phoneNumberVerified	user.attribute
5ab7379b-6c55-4d65-b308-75ef8d3c2eee	true	id.token.claim
5ab7379b-6c55-4d65-b308-75ef8d3c2eee	true	access.token.claim
5ab7379b-6c55-4d65-b308-75ef8d3c2eee	phone_number_verified	claim.name
5ab7379b-6c55-4d65-b308-75ef8d3c2eee	boolean	jsonType.label
26807e2d-ebc4-41eb-b0c1-6a4ea4ea0237	true	introspection.token.claim
26807e2d-ebc4-41eb-b0c1-6a4ea4ea0237	true	multivalued
26807e2d-ebc4-41eb-b0c1-6a4ea4ea0237	foo	user.attribute
26807e2d-ebc4-41eb-b0c1-6a4ea4ea0237	true	access.token.claim
26807e2d-ebc4-41eb-b0c1-6a4ea4ea0237	realm_access.roles	claim.name
26807e2d-ebc4-41eb-b0c1-6a4ea4ea0237	String	jsonType.label
46d9a1fc-9a43-4798-8569-892cfd69e5e0	true	introspection.token.claim
46d9a1fc-9a43-4798-8569-892cfd69e5e0	true	access.token.claim
928a84c9-9db4-4808-ae54-cedc8f4f7c5f	true	introspection.token.claim
928a84c9-9db4-4808-ae54-cedc8f4f7c5f	true	multivalued
928a84c9-9db4-4808-ae54-cedc8f4f7c5f	foo	user.attribute
928a84c9-9db4-4808-ae54-cedc8f4f7c5f	true	access.token.claim
928a84c9-9db4-4808-ae54-cedc8f4f7c5f	resource_access.${client_id}.roles	claim.name
928a84c9-9db4-4808-ae54-cedc8f4f7c5f	String	jsonType.label
1b039693-15a5-4879-b297-72062dfb2038	true	introspection.token.claim
1b039693-15a5-4879-b297-72062dfb2038	true	userinfo.token.claim
1b039693-15a5-4879-b297-72062dfb2038	nickname	user.attribute
1b039693-15a5-4879-b297-72062dfb2038	true	id.token.claim
1b039693-15a5-4879-b297-72062dfb2038	true	access.token.claim
1b039693-15a5-4879-b297-72062dfb2038	nickname	claim.name
1b039693-15a5-4879-b297-72062dfb2038	String	jsonType.label
201f4e29-6f40-4798-b47c-1eac3449b652	true	introspection.token.claim
201f4e29-6f40-4798-b47c-1eac3449b652	true	userinfo.token.claim
201f4e29-6f40-4798-b47c-1eac3449b652	website	user.attribute
201f4e29-6f40-4798-b47c-1eac3449b652	true	id.token.claim
201f4e29-6f40-4798-b47c-1eac3449b652	true	access.token.claim
201f4e29-6f40-4798-b47c-1eac3449b652	website	claim.name
201f4e29-6f40-4798-b47c-1eac3449b652	String	jsonType.label
352a6d72-6ffd-4b86-aa9e-e7cf060df24a	true	introspection.token.claim
352a6d72-6ffd-4b86-aa9e-e7cf060df24a	true	userinfo.token.claim
352a6d72-6ffd-4b86-aa9e-e7cf060df24a	gender	user.attribute
352a6d72-6ffd-4b86-aa9e-e7cf060df24a	true	id.token.claim
352a6d72-6ffd-4b86-aa9e-e7cf060df24a	true	access.token.claim
352a6d72-6ffd-4b86-aa9e-e7cf060df24a	gender	claim.name
352a6d72-6ffd-4b86-aa9e-e7cf060df24a	String	jsonType.label
38745f2c-e033-4953-90b9-76f92afba9c6	true	introspection.token.claim
38745f2c-e033-4953-90b9-76f92afba9c6	true	userinfo.token.claim
38745f2c-e033-4953-90b9-76f92afba9c6	profile	user.attribute
38745f2c-e033-4953-90b9-76f92afba9c6	true	id.token.claim
38745f2c-e033-4953-90b9-76f92afba9c6	true	access.token.claim
38745f2c-e033-4953-90b9-76f92afba9c6	profile	claim.name
38745f2c-e033-4953-90b9-76f92afba9c6	String	jsonType.label
3939afcf-9b08-446c-8598-1b8222e846b8	true	introspection.token.claim
3939afcf-9b08-446c-8598-1b8222e846b8	true	userinfo.token.claim
3939afcf-9b08-446c-8598-1b8222e846b8	zoneinfo	user.attribute
3939afcf-9b08-446c-8598-1b8222e846b8	true	id.token.claim
3939afcf-9b08-446c-8598-1b8222e846b8	true	access.token.claim
3939afcf-9b08-446c-8598-1b8222e846b8	zoneinfo	claim.name
3939afcf-9b08-446c-8598-1b8222e846b8	String	jsonType.label
58643c4f-b268-4173-841f-d8f53904320a	true	introspection.token.claim
58643c4f-b268-4173-841f-d8f53904320a	true	userinfo.token.claim
58643c4f-b268-4173-841f-d8f53904320a	lastName	user.attribute
58643c4f-b268-4173-841f-d8f53904320a	true	id.token.claim
58643c4f-b268-4173-841f-d8f53904320a	true	access.token.claim
58643c4f-b268-4173-841f-d8f53904320a	family_name	claim.name
58643c4f-b268-4173-841f-d8f53904320a	String	jsonType.label
638f0750-9807-4bcf-8e3d-f4afa995c51e	true	introspection.token.claim
638f0750-9807-4bcf-8e3d-f4afa995c51e	true	userinfo.token.claim
638f0750-9807-4bcf-8e3d-f4afa995c51e	firstName	user.attribute
638f0750-9807-4bcf-8e3d-f4afa995c51e	true	id.token.claim
638f0750-9807-4bcf-8e3d-f4afa995c51e	true	access.token.claim
638f0750-9807-4bcf-8e3d-f4afa995c51e	given_name	claim.name
638f0750-9807-4bcf-8e3d-f4afa995c51e	String	jsonType.label
7f749d21-8756-4ac4-add0-43b3660e5fd1	true	introspection.token.claim
7f749d21-8756-4ac4-add0-43b3660e5fd1	true	userinfo.token.claim
7f749d21-8756-4ac4-add0-43b3660e5fd1	middleName	user.attribute
7f749d21-8756-4ac4-add0-43b3660e5fd1	true	id.token.claim
7f749d21-8756-4ac4-add0-43b3660e5fd1	true	access.token.claim
7f749d21-8756-4ac4-add0-43b3660e5fd1	middle_name	claim.name
7f749d21-8756-4ac4-add0-43b3660e5fd1	String	jsonType.label
90d32913-ec9e-495f-b04c-0f53dee7df89	true	introspection.token.claim
90d32913-ec9e-495f-b04c-0f53dee7df89	true	userinfo.token.claim
90d32913-ec9e-495f-b04c-0f53dee7df89	updatedAt	user.attribute
90d32913-ec9e-495f-b04c-0f53dee7df89	true	id.token.claim
90d32913-ec9e-495f-b04c-0f53dee7df89	true	access.token.claim
90d32913-ec9e-495f-b04c-0f53dee7df89	updated_at	claim.name
90d32913-ec9e-495f-b04c-0f53dee7df89	long	jsonType.label
a3111a97-340f-4969-8b61-c0465d83af28	true	introspection.token.claim
a3111a97-340f-4969-8b61-c0465d83af28	true	userinfo.token.claim
a3111a97-340f-4969-8b61-c0465d83af28	picture	user.attribute
a3111a97-340f-4969-8b61-c0465d83af28	true	id.token.claim
a3111a97-340f-4969-8b61-c0465d83af28	true	access.token.claim
a3111a97-340f-4969-8b61-c0465d83af28	picture	claim.name
a3111a97-340f-4969-8b61-c0465d83af28	String	jsonType.label
be1b0ac3-6a99-413a-8c98-d0405f380d4b	true	introspection.token.claim
be1b0ac3-6a99-413a-8c98-d0405f380d4b	true	userinfo.token.claim
be1b0ac3-6a99-413a-8c98-d0405f380d4b	birthdate	user.attribute
be1b0ac3-6a99-413a-8c98-d0405f380d4b	true	id.token.claim
be1b0ac3-6a99-413a-8c98-d0405f380d4b	true	access.token.claim
be1b0ac3-6a99-413a-8c98-d0405f380d4b	birthdate	claim.name
be1b0ac3-6a99-413a-8c98-d0405f380d4b	String	jsonType.label
bed869e8-2a32-4aee-8fdc-71bc033b74c5	true	introspection.token.claim
bed869e8-2a32-4aee-8fdc-71bc033b74c5	true	userinfo.token.claim
bed869e8-2a32-4aee-8fdc-71bc033b74c5	username	user.attribute
bed869e8-2a32-4aee-8fdc-71bc033b74c5	true	id.token.claim
bed869e8-2a32-4aee-8fdc-71bc033b74c5	true	access.token.claim
bed869e8-2a32-4aee-8fdc-71bc033b74c5	preferred_username	claim.name
bed869e8-2a32-4aee-8fdc-71bc033b74c5	String	jsonType.label
e3a76d00-68cd-4e3a-add5-eac72070362f	true	id.token.claim
e3a76d00-68cd-4e3a-add5-eac72070362f	true	introspection.token.claim
e3a76d00-68cd-4e3a-add5-eac72070362f	true	access.token.claim
e3a76d00-68cd-4e3a-add5-eac72070362f	true	userinfo.token.claim
f0783309-d57e-40ba-ae3c-90320dfbb0a6	true	introspection.token.claim
f0783309-d57e-40ba-ae3c-90320dfbb0a6	true	userinfo.token.claim
f0783309-d57e-40ba-ae3c-90320dfbb0a6	locale	user.attribute
f0783309-d57e-40ba-ae3c-90320dfbb0a6	true	id.token.claim
f0783309-d57e-40ba-ae3c-90320dfbb0a6	true	access.token.claim
f0783309-d57e-40ba-ae3c-90320dfbb0a6	locale	claim.name
f0783309-d57e-40ba-ae3c-90320dfbb0a6	String	jsonType.label
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	true	introspection.token.claim
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	true	multivalued
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	true	userinfo.token.claim
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	foo	user.attribute
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	true	id.token.claim
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	true	access.token.claim
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	groups	claim.name
1ac195e6-7075-4c1e-8a19-4ac64a580ed1	String	jsonType.label
8bf6a681-0209-4e0a-90e4-f83a8dc8d0ec	true	introspection.token.claim
8bf6a681-0209-4e0a-90e4-f83a8dc8d0ec	true	userinfo.token.claim
8bf6a681-0209-4e0a-90e4-f83a8dc8d0ec	username	user.attribute
8bf6a681-0209-4e0a-90e4-f83a8dc8d0ec	true	id.token.claim
8bf6a681-0209-4e0a-90e4-f83a8dc8d0ec	true	access.token.claim
8bf6a681-0209-4e0a-90e4-f83a8dc8d0ec	upn	claim.name
8bf6a681-0209-4e0a-90e4-f83a8dc8d0ec	String	jsonType.label
55cf560a-3302-4f86-8c76-6d15b3aff06e	true	id.token.claim
55cf560a-3302-4f86-8c76-6d15b3aff06e	true	introspection.token.claim
55cf560a-3302-4f86-8c76-6d15b3aff06e	true	access.token.claim
55cf560a-3302-4f86-8c76-6d15b3aff06e	true	userinfo.token.claim
5c7adaca-1d26-470b-b130-3c45b195147c	true	introspection.token.claim
5c7adaca-1d26-470b-b130-3c45b195147c	true	userinfo.token.claim
5c7adaca-1d26-470b-b130-3c45b195147c	locale	user.attribute
5c7adaca-1d26-470b-b130-3c45b195147c	true	id.token.claim
5c7adaca-1d26-470b-b130-3c45b195147c	true	access.token.claim
5c7adaca-1d26-470b-b130-3c45b195147c	locale	claim.name
5c7adaca-1d26-470b-b130-3c45b195147c	String	jsonType.label
3c907763-b171-45c8-9ba9-fdcb0863bdd9	client_id	user.session.note
3c907763-b171-45c8-9ba9-fdcb0863bdd9	true	introspection.token.claim
3c907763-b171-45c8-9ba9-fdcb0863bdd9	true	id.token.claim
3c907763-b171-45c8-9ba9-fdcb0863bdd9	true	access.token.claim
3c907763-b171-45c8-9ba9-fdcb0863bdd9	client_id	claim.name
3c907763-b171-45c8-9ba9-fdcb0863bdd9	String	jsonType.label
ceb31af9-c769-421c-aebe-5add7b7fcf95	clientAddress	user.session.note
ceb31af9-c769-421c-aebe-5add7b7fcf95	true	introspection.token.claim
ceb31af9-c769-421c-aebe-5add7b7fcf95	true	id.token.claim
ceb31af9-c769-421c-aebe-5add7b7fcf95	true	access.token.claim
ceb31af9-c769-421c-aebe-5add7b7fcf95	clientAddress	claim.name
ceb31af9-c769-421c-aebe-5add7b7fcf95	String	jsonType.label
ff26e645-c448-4d62-9874-e2f107d76c7d	clientHost	user.session.note
ff26e645-c448-4d62-9874-e2f107d76c7d	true	introspection.token.claim
ff26e645-c448-4d62-9874-e2f107d76c7d	true	id.token.claim
ff26e645-c448-4d62-9874-e2f107d76c7d	true	access.token.claim
ff26e645-c448-4d62-9874-e2f107d76c7d	clientHost	claim.name
ff26e645-c448-4d62-9874-e2f107d76c7d	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
319844d6-c993-472b-b6db-ed5f70b1d9fa	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	062d8dbd-56cf-46cc-a577-e924544c0989	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	57cb89d6-f35d-4251-a482-6751a1ff9e30	9b4c05fc-3ab0-47a3-9fe1-e45d64ae6fc0	3728af33-c666-4428-afd6-191bdc634659	20789337-b787-43a9-a684-8f2a010f7b5a	ad9173b9-2bd4-43e8-b018-969afd04632b	2592000	f	900	t	f	e9794844-9966-4a60-ab86-007a6eec5793	0	f	0	0	203ef85f-ceb0-470d-9c17-eebc02bf0b5f
9221edbb-59a4-49c1-a953-17a986e6ecd2	60	300	300	\N	\N	\N	t	f	0	\N	tekclinic	0	\N	t	f	f	f	EXTERNAL	1800	36000	f	f	c6afb667-13cc-49d1-b19b-1f6ba5f13e1b	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	749c74a4-7db2-49ee-afbc-ce72afcf5c2e	0e504c50-d67e-44ae-a4b8-06a2595aeca5	acd97203-4669-4ec5-8c6a-aea8cca25fde	47940d53-00fd-410e-9f92-dbeb14ebd0aa	3f7c1906-4d20-4492-b82f-be9c3da6a4f4	2592000	f	900	t	f	5be9a2cc-9bb6-4e50-815e-1990eef2eaf5	0	f	0	0	bd6f2982-6db9-426e-9234-3c15867d9215
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	319844d6-c993-472b-b6db-ed5f70b1d9fa	
_browser_header.xContentTypeOptions	319844d6-c993-472b-b6db-ed5f70b1d9fa	nosniff
_browser_header.referrerPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	no-referrer
_browser_header.xRobotsTag	319844d6-c993-472b-b6db-ed5f70b1d9fa	none
_browser_header.xFrameOptions	319844d6-c993-472b-b6db-ed5f70b1d9fa	SAMEORIGIN
_browser_header.contentSecurityPolicy	319844d6-c993-472b-b6db-ed5f70b1d9fa	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	319844d6-c993-472b-b6db-ed5f70b1d9fa	1; mode=block
_browser_header.strictTransportSecurity	319844d6-c993-472b-b6db-ed5f70b1d9fa	max-age=31536000; includeSubDomains
bruteForceProtected	319844d6-c993-472b-b6db-ed5f70b1d9fa	false
permanentLockout	319844d6-c993-472b-b6db-ed5f70b1d9fa	false
maxFailureWaitSeconds	319844d6-c993-472b-b6db-ed5f70b1d9fa	900
minimumQuickLoginWaitSeconds	319844d6-c993-472b-b6db-ed5f70b1d9fa	60
waitIncrementSeconds	319844d6-c993-472b-b6db-ed5f70b1d9fa	60
quickLoginCheckMilliSeconds	319844d6-c993-472b-b6db-ed5f70b1d9fa	1000
maxDeltaTimeSeconds	319844d6-c993-472b-b6db-ed5f70b1d9fa	43200
failureFactor	319844d6-c993-472b-b6db-ed5f70b1d9fa	30
realmReusableOtpCode	319844d6-c993-472b-b6db-ed5f70b1d9fa	false
displayName	319844d6-c993-472b-b6db-ed5f70b1d9fa	Keycloak
displayNameHtml	319844d6-c993-472b-b6db-ed5f70b1d9fa	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	319844d6-c993-472b-b6db-ed5f70b1d9fa	RS256
offlineSessionMaxLifespanEnabled	319844d6-c993-472b-b6db-ed5f70b1d9fa	false
offlineSessionMaxLifespan	319844d6-c993-472b-b6db-ed5f70b1d9fa	5184000
_browser_header.contentSecurityPolicyReportOnly	9221edbb-59a4-49c1-a953-17a986e6ecd2	
_browser_header.xContentTypeOptions	9221edbb-59a4-49c1-a953-17a986e6ecd2	nosniff
_browser_header.referrerPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	no-referrer
_browser_header.xRobotsTag	9221edbb-59a4-49c1-a953-17a986e6ecd2	none
_browser_header.xFrameOptions	9221edbb-59a4-49c1-a953-17a986e6ecd2	SAMEORIGIN
_browser_header.contentSecurityPolicy	9221edbb-59a4-49c1-a953-17a986e6ecd2	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	9221edbb-59a4-49c1-a953-17a986e6ecd2	1; mode=block
_browser_header.strictTransportSecurity	9221edbb-59a4-49c1-a953-17a986e6ecd2	max-age=31536000; includeSubDomains
bruteForceProtected	9221edbb-59a4-49c1-a953-17a986e6ecd2	false
permanentLockout	9221edbb-59a4-49c1-a953-17a986e6ecd2	false
maxFailureWaitSeconds	9221edbb-59a4-49c1-a953-17a986e6ecd2	900
minimumQuickLoginWaitSeconds	9221edbb-59a4-49c1-a953-17a986e6ecd2	60
waitIncrementSeconds	9221edbb-59a4-49c1-a953-17a986e6ecd2	60
quickLoginCheckMilliSeconds	9221edbb-59a4-49c1-a953-17a986e6ecd2	1000
maxDeltaTimeSeconds	9221edbb-59a4-49c1-a953-17a986e6ecd2	43200
failureFactor	9221edbb-59a4-49c1-a953-17a986e6ecd2	30
realmReusableOtpCode	9221edbb-59a4-49c1-a953-17a986e6ecd2	false
defaultSignatureAlgorithm	9221edbb-59a4-49c1-a953-17a986e6ecd2	RS256
offlineSessionMaxLifespanEnabled	9221edbb-59a4-49c1-a953-17a986e6ecd2	false
offlineSessionMaxLifespan	9221edbb-59a4-49c1-a953-17a986e6ecd2	5184000
clientSessionIdleTimeout	9221edbb-59a4-49c1-a953-17a986e6ecd2	0
clientSessionMaxLifespan	9221edbb-59a4-49c1-a953-17a986e6ecd2	0
clientOfflineSessionIdleTimeout	9221edbb-59a4-49c1-a953-17a986e6ecd2	0
clientOfflineSessionMaxLifespan	9221edbb-59a4-49c1-a953-17a986e6ecd2	0
actionTokenGeneratedByAdminLifespan	9221edbb-59a4-49c1-a953-17a986e6ecd2	43200
actionTokenGeneratedByUserLifespan	9221edbb-59a4-49c1-a953-17a986e6ecd2	300
oauth2DeviceCodeLifespan	9221edbb-59a4-49c1-a953-17a986e6ecd2	600
oauth2DevicePollingInterval	9221edbb-59a4-49c1-a953-17a986e6ecd2	5
webAuthnPolicyRpEntityName	9221edbb-59a4-49c1-a953-17a986e6ecd2	keycloak
webAuthnPolicySignatureAlgorithms	9221edbb-59a4-49c1-a953-17a986e6ecd2	ES256
webAuthnPolicyRpId	9221edbb-59a4-49c1-a953-17a986e6ecd2	
webAuthnPolicyAttestationConveyancePreference	9221edbb-59a4-49c1-a953-17a986e6ecd2	not specified
webAuthnPolicyAuthenticatorAttachment	9221edbb-59a4-49c1-a953-17a986e6ecd2	not specified
webAuthnPolicyRequireResidentKey	9221edbb-59a4-49c1-a953-17a986e6ecd2	not specified
webAuthnPolicyUserVerificationRequirement	9221edbb-59a4-49c1-a953-17a986e6ecd2	not specified
webAuthnPolicyCreateTimeout	9221edbb-59a4-49c1-a953-17a986e6ecd2	0
webAuthnPolicyAvoidSameAuthenticatorRegister	9221edbb-59a4-49c1-a953-17a986e6ecd2	false
webAuthnPolicyRpEntityNamePasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	ES256
webAuthnPolicyRpIdPasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	
webAuthnPolicyAttestationConveyancePreferencePasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	not specified
webAuthnPolicyRequireResidentKeyPasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	not specified
webAuthnPolicyCreateTimeoutPasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	false
cibaBackchannelTokenDeliveryMode	9221edbb-59a4-49c1-a953-17a986e6ecd2	poll
cibaExpiresIn	9221edbb-59a4-49c1-a953-17a986e6ecd2	120
cibaInterval	9221edbb-59a4-49c1-a953-17a986e6ecd2	5
cibaAuthRequestedUserHint	9221edbb-59a4-49c1-a953-17a986e6ecd2	login_hint
parRequestUriLifespan	9221edbb-59a4-49c1-a953-17a986e6ecd2	60
client-policies.profiles	9221edbb-59a4-49c1-a953-17a986e6ecd2	{"profiles":[]}
client-policies.policies	9221edbb-59a4-49c1-a953-17a986e6ecd2	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
319844d6-c993-472b-b6db-ed5f70b1d9fa	jboss-logging
9221edbb-59a4-49c1-a953-17a986e6ecd2	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	319844d6-c993-472b-b6db-ed5f70b1d9fa
password	password	t	t	9221edbb-59a4-49c1-a953-17a986e6ecd2
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
a6fa7888-d7d4-4839-bf0f-624e7fa91276	/realms/master/account/*
0094f806-561d-43c1-a2c5-eeea98a2bacf	/realms/master/account/*
141e4dad-404a-4615-b772-9adb633ad401	/admin/master/console/*
35f91e48-5547-4615-b233-5753a6a66334	/realms/tekclinic/account/*
d7963a92-c19a-4ca7-a646-90f9cadd92d9	/realms/tekclinic/account/*
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	/admin/tekclinic/console/*
291174d2-2dd5-486e-afd5-25223d4acded	
984ede3f-e7f6-4231-9bfa-68a726c655a5	http://tekclinic.org*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
6375c147-832b-463c-9893-52356de115ec	VERIFY_EMAIL	Verify Email	319844d6-c993-472b-b6db-ed5f70b1d9fa	t	f	VERIFY_EMAIL	50
a1e8d55d-7dae-4720-81ca-19d55f5c82d1	UPDATE_PROFILE	Update Profile	319844d6-c993-472b-b6db-ed5f70b1d9fa	t	f	UPDATE_PROFILE	40
21920b56-4400-40de-b866-b7a42a8dbdd9	CONFIGURE_TOTP	Configure OTP	319844d6-c993-472b-b6db-ed5f70b1d9fa	t	f	CONFIGURE_TOTP	10
df13bed1-07f5-4af4-a283-35b1f06ea314	UPDATE_PASSWORD	Update Password	319844d6-c993-472b-b6db-ed5f70b1d9fa	t	f	UPDATE_PASSWORD	30
86492eef-0ef0-40d6-ae38-bb32c7786ca1	TERMS_AND_CONDITIONS	Terms and Conditions	319844d6-c993-472b-b6db-ed5f70b1d9fa	f	f	TERMS_AND_CONDITIONS	20
974657d4-8b2d-42d5-a074-e83b22d06a71	delete_account	Delete Account	319844d6-c993-472b-b6db-ed5f70b1d9fa	f	f	delete_account	60
569f4c86-eb2f-4e88-876a-a5ccae7e57fb	update_user_locale	Update User Locale	319844d6-c993-472b-b6db-ed5f70b1d9fa	t	f	update_user_locale	1000
5df5e3f4-172d-48c8-8dad-e3a575db4e48	webauthn-register	Webauthn Register	319844d6-c993-472b-b6db-ed5f70b1d9fa	t	f	webauthn-register	70
1cae0413-e7b0-4414-8469-bd71a5610114	webauthn-register-passwordless	Webauthn Register Passwordless	319844d6-c993-472b-b6db-ed5f70b1d9fa	t	f	webauthn-register-passwordless	80
a14650bf-3241-4aa1-89aa-0e0dce279df2	CONFIGURE_TOTP	Configure OTP	9221edbb-59a4-49c1-a953-17a986e6ecd2	t	f	CONFIGURE_TOTP	10
415bc494-aa96-4401-a576-87e12cc15c13	TERMS_AND_CONDITIONS	Terms and Conditions	9221edbb-59a4-49c1-a953-17a986e6ecd2	f	f	TERMS_AND_CONDITIONS	20
de2d7da9-04cc-44c1-82ca-e82583ad3def	UPDATE_PASSWORD	Update Password	9221edbb-59a4-49c1-a953-17a986e6ecd2	t	f	UPDATE_PASSWORD	30
096f8cdc-c9da-4a30-a3ec-6de1249b1e74	UPDATE_PROFILE	Update Profile	9221edbb-59a4-49c1-a953-17a986e6ecd2	t	f	UPDATE_PROFILE	40
687ac847-1ea9-4fa3-a9d2-f1beac8a1c94	VERIFY_EMAIL	Verify Email	9221edbb-59a4-49c1-a953-17a986e6ecd2	t	f	VERIFY_EMAIL	50
9f07e3ce-f413-4c81-94c4-6b8d41899277	delete_account	Delete Account	9221edbb-59a4-49c1-a953-17a986e6ecd2	f	f	delete_account	60
190a0efb-c725-453c-8988-0329d1fd72f1	webauthn-register	Webauthn Register	9221edbb-59a4-49c1-a953-17a986e6ecd2	t	f	webauthn-register	70
18be6280-5ab9-4811-89f5-926e5203eb72	webauthn-register-passwordless	Webauthn Register Passwordless	9221edbb-59a4-49c1-a953-17a986e6ecd2	t	f	webauthn-register-passwordless	80
c9938470-59f2-4187-adb5-e1f0641757e9	update_user_locale	Update User Locale	9221edbb-59a4-49c1-a953-17a986e6ecd2	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
291174d2-2dd5-486e-afd5-25223d4acded	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
aaf3bb2a-2d14-4494-8bf7-7e6a94c91321	Default Policy	A policy that grants access only for users within this realm	js	0	0	291174d2-2dd5-486e-afd5-25223d4acded	\N
38697b78-1cc5-4c8b-bf6c-7b6872104e33	Default Permission	A permission that applies to the default resource type	resource	1	0	291174d2-2dd5-486e-afd5-25223d4acded	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
a289e82c-2a3d-4562-9281-9fa507cbd18a	Default Resource	urn:backend-client:resources:default	\N	291174d2-2dd5-486e-afd5-25223d4acded	291174d2-2dd5-486e-afd5-25223d4acded	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
a289e82c-2a3d-4562-9281-9fa507cbd18a	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
0094f806-561d-43c1-a2c5-eeea98a2bacf	c7de59c1-614b-4e61-b62c-f0270a59b132
0094f806-561d-43c1-a2c5-eeea98a2bacf	e41fb509-d926-482f-97cf-9377bdb156f9
d7963a92-c19a-4ca7-a646-90f9cadd92d9	01ec5858-68d7-433b-b7cf-a96a10d1b326
d7963a92-c19a-4ca7-a646-90f9cadd92d9	6ee7eeee-b7da-42b4-9526-dfab70e42c03
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
5f716f5b-6c06-41b9-8722-6b4e4b9f2e78	\N	eddfbd19-f37c-4baa-9f2d-ff22c8860cab	f	t	\N	\N	\N	319844d6-c993-472b-b6db-ed5f70b1d9fa	admin	1707755733518	\N	0
d39a75a9-517b-48ae-a79a-b8d4420c170e	\N	a5a3e25a-1840-46c7-8e27-e8705398a0c3	f	t	\N	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	service-account-backend-client	1707771862461	291174d2-2dd5-486e-afd5-25223d4acded	0
e6badb8c-23ef-46e7-b9ac-d7826f18aeef	\N	f8df0e97-6224-4346-892d-6b15e154f71f	t	t	\N	\N	\N	9221edbb-59a4-49c1-a953-17a986e6ecd2	test_user	1711114720599	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
203ef85f-ceb0-470d-9c17-eebc02bf0b5f	5f716f5b-6c06-41b9-8722-6b4e4b9f2e78
4ae97f09-282f-4c97-af74-655bbbf587be	5f716f5b-6c06-41b9-8722-6b4e4b9f2e78
bd6f2982-6db9-426e-9234-3c15867d9215	d39a75a9-517b-48ae-a79a-b8d4420c170e
ea2163e5-97ad-4880-85c6-7a494bdae39b	d39a75a9-517b-48ae-a79a-b8d4420c170e
a90ff6de-1cba-4e54-8241-fb1a63fe6101	d39a75a9-517b-48ae-a79a-b8d4420c170e
bd6f2982-6db9-426e-9234-3c15867d9215	e6badb8c-23ef-46e7-b9ac-d7826f18aeef
a90ff6de-1cba-4e54-8241-fb1a63fe6101	e6badb8c-23ef-46e7-b9ac-d7826f18aeef
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
141e4dad-404a-4615-b772-9adb633ad401	+
af9754e2-54f1-4dfc-a2a3-3092f6dd77bf	+
291174d2-2dd5-486e-afd5-25223d4acded	
984ede3f-e7f6-4231-9bfa-68a726c655a5	http://tekclinic.org
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- Database "patients" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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

--
-- Name: patients; Type: DATABASE; Schema: -; Owner: patients
--

CREATE DATABASE patients WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE patients OWNER TO patients;

\connect patients

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
-- Name: emergency_contacts; Type: TABLE; Schema: public; Owner: patients
--

CREATE TABLE public.emergency_contacts (
    id integer NOT NULL,
    name character varying,
    closeness character varying,
    phone character varying,
    patient_id integer
);


ALTER TABLE public.emergency_contacts OWNER TO patients;

--
-- Name: emergency_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: patients
--

CREATE SEQUENCE public.emergency_contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emergency_contacts_id_seq OWNER TO patients;

--
-- Name: emergency_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: patients
--

ALTER SEQUENCE public.emergency_contacts_id_seq OWNED BY public.emergency_contacts.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: patients
--

CREATE TABLE public.patients (
    id integer NOT NULL,
    active boolean,
    name character varying,
    personal_id_id character varying,
    personal_id_type character varying,
    gender integer,
    phone_number character varying,
    languages character varying[],
    birth_date timestamp with time zone,
    referred_by character varying,
    special_note character varying
);


ALTER TABLE public.patients OWNER TO patients;

--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: patients
--

CREATE SEQUENCE public.patients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patients_id_seq OWNER TO patients;

--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: patients
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.id;


--
-- Name: emergency_contacts id; Type: DEFAULT; Schema: public; Owner: patients
--

ALTER TABLE ONLY public.emergency_contacts ALTER COLUMN id SET DEFAULT nextval('public.emergency_contacts_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: patients
--

ALTER TABLE ONLY public.patients ALTER COLUMN id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- Data for Name: emergency_contacts; Type: TABLE DATA; Schema: public; Owner: patients
--

COPY public.emergency_contacts (id, name, closeness, phone, patient_id) FROM stdin;
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: patients
--

COPY public.patients (id, active, name, personal_id_id, personal_id_type, gender, phone_number, languages, birth_date, referred_by, special_note) FROM stdin;
1	t	John Smith	21472148	ID	1	+93782374732	{chinese,hebrew}	2000-10-10 00:00:00+00	\N	\N
2	f	Miranda Grand	74832741	Passport	2	+18218347219	{english}	1988-10-11 00:00:00+00	John Smith	\N
\.


--
-- Name: emergency_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: patients
--

SELECT pg_catalog.setval('public.emergency_contacts_id_seq', 1, false);


--
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: patients
--

SELECT pg_catalog.setval('public.patients_id_seq', 2, true);


--
-- Name: emergency_contacts emergency_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: patients
--

ALTER TABLE ONLY public.emergency_contacts
    ADD CONSTRAINT emergency_contacts_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: patients
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

