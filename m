Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B8C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDDD208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgH2Kwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:52:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:17383 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgH2KvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:51:05 -0400
IronPort-SDR: 86CBWbDr7/nJ3svi8AERr//olbg5e1sGXR9AeD8XOJffHXP0KJD1GrFn9OeZxgQZw8goI3eu3V
 4BlU1ZlR/Uvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="174838402"
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="174838402"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 03:51:02 -0700
IronPort-SDR: YbCREIIT7dBUqjsta9vuHHXML/6clRh+2/fijq566aBC30iqpbFdScLntWVStG6BlVeCWXRQoK
 2h/czkVqHu2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="313853171"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2020 03:51:00 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] perf tools: Add FIFO file names as alternative options to --control
Date:   Sat, 29 Aug 2020 13:50:13 +0300
Message-Id: <20200829105015.10800-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829105015.10800-1-adrian.hunter@intel.com>
References: <20200829105015.10800-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the --control option to accept file names as an alternative to
file descriptors.

Example:

 $ mkfifo perf.control
 $ mkfifo perf.ack
 $ cat perf.ack &
 [1] 6808
 $ perf record --control perf.control,perf.ack -- sleep 300 &
 [2] 6810
 $ echo disable > perf.control
 $ Events disabled
 ack

 $ echo enable > perf.control
 $ Events enabled
 ack

 $ echo disable > perf.control
 $ Events disabled
 ack

 $ kill %2
 [ perf record: Woken up 4 times to write data ]
 $ [ perf record: Captured and wrote 0.018 MB perf.data (7 samples) ]

 [1]-  Done                    cat perf.ack
 [2]+  Terminated              perf record --control perf.control,perf.ack -- sleep 300
 $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-record.txt |  2 +
 tools/perf/Documentation/perf-stat.txt   |  2 +
 tools/perf/builtin-record.c              | 34 ++++++++++++----
 tools/perf/builtin-stat.c                | 18 +++++++--
 tools/perf/util/evlist.c                 | 49 +++++++++++++++++++++++-
 tools/perf/util/evlist.h                 |  2 +-
 tools/perf/util/record.h                 |  1 +
 tools/perf/util/stat.h                   |  1 +
 8 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 07c4734f1c7a..74fa3e905bf1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -627,7 +627,9 @@ option. The -e option and this one can be mixed and matched.  Events
 can be grouped using the {} notation.
 endif::HAVE_LIBPFM[]
 
+--control=ctl-fifo[,ack-fifo]::
 --control=fd:ctl-fd[,ack-fd]::
+ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
 Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
 'disable': disable events). Measurements can be started with events disabled using
 --delay=-1 option. Optionally send control command completion ('ack\n') to ack-fd descriptor
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 7fb7368cc2d9..bd7e52f09048 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -176,7 +176,9 @@ with it.  --append may be used here.  Examples:
      3>results  perf stat --log-fd 3          -- $cmd
      3>>results perf stat --log-fd 3 --append -- $cmd
 
+--control=ctl-fifo[,ack-fifo]::
 --control=fd:ctl-fd[,ack-fd]::
+ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
 Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
 'disable': disable events). Measurements can be started with events disabled using
 --delay=-1 option. Optionally send control command completion ('ack\n') to ack-fd descriptor
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f2ab5bd7e2ba..af7238b1356f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2236,7 +2236,17 @@ static int parse_control_option(const struct option *opt,
 {
 	struct record_opts *opts = opt->value;
 
-	return evlist__parse_control(str, &opts->ctl_fd, &opts->ctl_fd_ack);
+	return evlist__parse_control(str, &opts->ctl_fd, &opts->ctl_fd_ack, &opts->ctl_fd_close);
+}
+
+static void close_control_option(struct record_opts *opts)
+{
+	if (opts->ctl_fd_close) {
+		opts->ctl_fd_close = false;
+		close(opts->ctl_fd);
+		if (opts->ctl_fd_ack >= 0)
+			close(opts->ctl_fd_ack);
+	}
 }
 
 static void switch_output_size_warn(struct record *rec)
@@ -2578,9 +2588,10 @@ static struct option __record_options[] = {
 		"libpfm4 event selector. use 'perf list' to list available events",
 		parse_libpfm_events_option),
 #endif
-	OPT_CALLBACK(0, "control", &record.opts, "fd:ctl-fd[,ack-fd]",
+	OPT_CALLBACK(0, "control", &record.opts, "fd:ctl-fd[,ack-fd] or ctl-fifo[,ack-fifo]",
 		     "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
-		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.",
+		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
+		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
 	OPT_END()
 };
@@ -2653,12 +2664,14 @@ int cmd_record(int argc, const char **argv)
 	    !perf_can_record_switch_events()) {
 		ui__error("kernel does not support recording context switch events\n");
 		parse_options_usage(record_usage, record_options, "switch-events", 0);
-		return -EINVAL;
+		err = -EINVAL;
+		goto out_opts;
 	}
 
 	if (switch_output_setup(rec)) {
 		parse_options_usage(record_usage, record_options, "switch-output", 0);
-		return -EINVAL;
+		err = -EINVAL;
+		goto out_opts;
 	}
 
 	if (rec->switch_output.time) {
@@ -2669,8 +2682,10 @@ int cmd_record(int argc, const char **argv)
 	if (rec->switch_output.num_files) {
 		rec->switch_output.filenames = calloc(sizeof(char *),
 						      rec->switch_output.num_files);
-		if (!rec->switch_output.filenames)
-			return -EINVAL;
+		if (!rec->switch_output.filenames) {
+			err = -EINVAL;
+			goto out_opts;
+		}
 	}
 
 	/*
@@ -2686,7 +2701,8 @@ int cmd_record(int argc, const char **argv)
 		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
 		if (!rec->affinity_mask.bits) {
 			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto out_opts;
 		}
 		pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
 	}
@@ -2817,6 +2833,8 @@ int cmd_record(int argc, const char **argv)
 	evlist__delete(rec->evlist);
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
+out_opts:
+	close_control_option(&rec->opts);
 	return err;
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 12ce5cf2b10e..0d4495bace13 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1047,7 +1047,17 @@ static int parse_control_option(const struct option *opt,
 {
 	struct perf_stat_config *config = opt->value;
 
-	return evlist__parse_control(str, &config->ctl_fd, &config->ctl_fd_ack);
+	return evlist__parse_control(str, &config->ctl_fd, &config->ctl_fd_ack, &config->ctl_fd_close);
+}
+
+static void close_control_option(struct perf_stat_config *config)
+{
+	if (config->ctl_fd_close) {
+		config->ctl_fd_close = false;
+		close(config->ctl_fd);
+		if (config->ctl_fd_ack >= 0)
+			close(config->ctl_fd_ack);
+	}
 }
 
 static struct option stat_options[] = {
@@ -1151,9 +1161,10 @@ static struct option stat_options[] = {
 		"libpfm4 event selector. use 'perf list' to list available events",
 		parse_libpfm_events_option),
 #endif
-	OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd]",
+	OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd] or ctl-fifo[,ack-fifo]",
 		     "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
-		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.",
+		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
+		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
 	OPT_END()
 };
@@ -2396,6 +2407,7 @@ int cmd_stat(int argc, const char **argv)
 
 	metricgroup__rblist_exit(&stat_config.metric_events);
 	runtime_stat_delete(&stat_config);
+	close_control_option(&stat_config);
 
 	return status;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47d1045a19af..cb61c223927f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1727,12 +1727,57 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	return leader;
 }
 
-int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack)
+static int evlist__parse_control_names(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close)
+{
+	char *s, *p;
+	int ret = 0, fd;
+
+	if (!str || !*str || *str == ',')
+		return -EINVAL;
+
+	s = strdup(str);
+	if (!s)
+		return -ENOMEM;
+
+	p = strchr(s, ',');
+	if (p)
+		*p = '\0';
+
+	/*
+	 * O_RDWR avoids POLLHUPs which is necessary to allow the other
+	 * end of a FIFO to be repeatedly opened and closed.
+	 */
+	fd = open(s, O_RDWR | O_NONBLOCK | O_CLOEXEC);
+	if (fd < 0) {
+		pr_err("Failed to open '%s'\n", s);
+		ret = -errno;
+		goto out_free;
+	}
+	*ctl_fd = fd;
+	*ctl_fd_close = true;
+
+	if (p && *++p) {
+		/* O_RDWR | O_NONBLOCK means the other end need not be open */
+		fd = open(p, O_RDWR | O_NONBLOCK | O_CLOEXEC);
+		if (fd < 0) {
+			pr_err("Failed to open '%s'\n", p);
+			ret = -errno;
+			goto out_free;
+		}
+		*ctl_fd_ack = fd;
+	}
+
+out_free:
+	free(s);
+	return ret;
+}
+
+int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close)
 {
 	char *comma = NULL, *endptr = NULL;
 
 	if (strncmp(str, "fd:", 3))
-		return -EINVAL;
+		return evlist__parse_control_names(str, ctl_fd, ctl_fd_ack, ctl_fd_close);
 
 	*ctl_fd = strtoul(&str[3], &endptr, 0);
 	if (endptr == &str[3])
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index a5a5a07d5c55..a5678eb5ee60 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -373,7 +373,7 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_ACK
 };
 
-int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack);
+int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
 int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 03678ff25539..266760ac9143 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -73,6 +73,7 @@ struct record_opts {
 	unsigned int  nr_threads_synthesize;
 	int	      ctl_fd;
 	int	      ctl_fd_ack;
+	bool	      ctl_fd_close;
 };
 
 extern const char * const *record_usage;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f8778cffd941..65402e13b704 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -135,6 +135,7 @@ struct perf_stat_config {
 	struct rblist		 metric_events;
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
+	bool			 ctl_fd_close;
 };
 
 void perf_stat__set_big_num(int set);
-- 
2.17.1

