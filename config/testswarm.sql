--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `useragent_id` varchar(40) NOT NULL,
  `useragent` tinytext NOT NULL,
  `ip` varchar(15) NOT NULL default '',
  `updated` binary(14) NOT NULL,
  `created` binary(14) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `created` binary(14) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `run_client`
--

CREATE TABLE `run_client` (
  `run_id` int(11) NOT NULL default '0',
  `client_id` int(11) NOT NULL default '0',
  `status` tinyint(4) NOT NULL default '0',
  `fail` int(11) NOT NULL default '0',
  `error` int(11) NOT NULL default '0',
  `total` int(11) NOT NULL default '0',
  `results` text NOT NULL,
  `updated` binary(14) NOT NULL,
  `created` binary(14) NOT NULL,
  PRIMARY KEY  (`run_id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `run_useragent`
--

CREATE TABLE `run_useragent` (
  `run_id` int(11) NOT NULL default '0',
  `useragent_id` varchar(40) NOT NULL,
  `runs` int(11) NOT NULL default '0',
  `max` int(11) NOT NULL default '1',
  `completed` int(11) NOT NULL default '0',
  `status` tinyint(4) NOT NULL default '0',
  `updated` binary(14) NOT NULL,
  `created` binary(14) NOT NULL,
  PRIMARY KEY  (`run_id`,`useragent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `runs`
--

CREATE TABLE `runs` (
  `id` int(11) NOT NULL auto_increment,
  `job_id` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `url` tinytext NOT NULL,
  `created` binary(14) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `updated` binary(14) NOT NULL,
  `created` binary(14) NOT NULL,
  `seed` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `auth` varchar(40) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Indexes and Foreign Keys
alter table clients
	add index idx_clients_user_id (user_id),
	add constraint fk_clients_user_id foreign key (user_id) references users (id);
alter table clients
	add index idx_clients_useragent_id (useragent_id);
alter table jobs
	add index idx_jobs_user_id (user_id),
	add constraint fk_jobs_user_id foreign key (user_id) references users (id);
alter table run_client
	add index idx_run_client_run_id (run_id),
	add constraint fk_run_client_run_id foreign key (run_id) references runs (id);
alter table run_client
	add index idx_run_client_client_id (client_id),
	add constraint fk_run_client_client_id foreign key (client_id) references clients (id);
alter table run_useragent
	add index idx_run_useragent_run_id (run_id),
	add constraint fk_run_useragent_run_id foreign key (run_id) references runs (id);
alter table run_useragent
	add index idx_run_useragent_useragent_id (useragent_id);
alter table runs
	add index idx_runs_job_id (job_id),
	add constraint fk_runs_job_id foreign key (job_id) references jobs (id);
