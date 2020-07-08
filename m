Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E492C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1422067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGHHyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:54:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:12405 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgGHHyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:54:09 -0400
IronPort-SDR: s8ZYQH71FMSVosl0F6TGrltLLzs2plz4tgHDADYxXHGOOfd2p2OlAswTKENIypYgZC5POE7NPQ
 jV0CsFtXOQyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145857891"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="145857891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:54:08 -0700
IronPort-SDR: 0gaOCey7TLCJesrjndmnA+NtCKauhnAxxE6QhygbDyhzf596mxy43m1SZsbMSrvOTofgqaEsmM
 KQQmdSXutXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="268406989"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2020 00:54:08 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id C81135807C9;
        Wed,  8 Jul 2020 00:54:05 -0700 (PDT)
Subject: [PATCH v10 12/15] perf stat: introduce --control fd:ctl-fd[,ack-fd]
 options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a6273d44-3329-e098-194e-fa9463bf7bef@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:54:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce --control fd:ctl-fd[,ack-fd] options to pass open file
descriptors numbers from command line. Extend perf-stat.txt file
with --control fd:ctl-fd[,ack-fd] options description. Document
possible usage model introduced by --control fd:ctl-fd[,ack-fd]
options by providing example bash shell script.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 39 +++++++++++++++++++++++++
 tools/perf/builtin-stat.c              | 40 +++++++++++++++++++++++++-
 tools/perf/util/stat.h                 |  2 ++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9f32f6cd558d..c9bfefc051fb 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -176,6 +176,45 @@ with it.  --append may be used here.  Examples:
      3>results  perf stat --log-fd 3          -- $cmd
      3>>results perf stat --log-fd 3 --append -- $cmd
 
+--control fd:ctl-fd[,ack-fd]
+Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
+'disable': disable events). Measurements can be started with events disabled using
+--delay=-1 option. Optionally send control command completion ('ack\n') to ack-fd descriptor
+to synchronize with the controlling process. Example of bash shell script to enable and
+disable events during measurements:
+
+#!/bin/bash
+
+ctl_dir=/tmp/
+
+ctl_fifo=${ctl_dir}perf_ctl.fifo
+test -p ${ctl_fifo} && unlink ${ctl_fifo}
+mkfifo ${ctl_fifo}
+exec {ctl_fd}<>${ctl_fifo}
+
+ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
+test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
+mkfifo ${ctl_ack_fifo}
+exec {ctl_fd_ack}<>${ctl_ack_fifo}
+
+perf stat -D -1 -e cpu-cycles -a -I 1000       \
+          --control fd:${ctl_fd},${ctl_fd_ack} \
+          -- sleep 30 &
+perf_pid=$!
+
+sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
+sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
+
+exec {ctl_fd_ack}>&-
+unlink ${ctl_ack_fifo}
+
+exec {ctl_fd}>&-
+unlink ${ctl_fifo}
+
+wait -n ${perf_pid}
+exit $?
+
+
 --pre::
 --post::
 	Pre and post measurement hooks, e.g.:
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5280a45af5dc..483a28ef4ec4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -188,6 +188,8 @@ static struct perf_stat_config stat_config = {
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
+	.ctl_fd			= -1,
+	.ctl_fd_ack		= -1
 };
 
 static bool cpus_map_matched(struct evsel *a, struct evsel *b)
@@ -867,7 +869,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		perf_evlist__start_workload(evsel_list);
 		enable_counters();
 
-		if (interval || timeout)
+		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
 			status = dispatch_events(forks, timeout, interval, &times);
 		if (child_pid != -1) {
 			if (timeout)
@@ -1039,6 +1041,33 @@ static int parse_metric_groups(const struct option *opt,
 					 &stat_config.metric_events);
 }
 
+static int parse_control_option(const struct option *opt,
+				const char *str,
+				int unset __maybe_unused)
+{
+	char *comma = NULL, *endptr = NULL;
+	struct perf_stat_config *config = (struct perf_stat_config *)opt->value;
+
+	if (strncmp(str, "fd:", 3))
+		return -EINVAL;
+
+	config->ctl_fd = strtoul(&str[3], &endptr, 0);
+	if (endptr == &str[3])
+		return -EINVAL;
+
+	comma = strchr(str, ',');
+	if (comma) {
+		if (endptr != comma)
+			return -EINVAL;
+
+		config->ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
+		if (endptr == comma + 1 || *endptr != '\0')
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1140,6 +1169,10 @@ static struct option stat_options[] = {
 		"libpfm4 event selector. use 'perf list' to list available events",
 		parse_libpfm_events_option),
 #endif
+	OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd]",
+		     "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
+		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.",
+		      parse_control_option),
 	OPT_END()
 };
 
@@ -2309,6 +2342,9 @@ int cmd_stat(int argc, const char **argv)
 	signal(SIGALRM, skip_signal);
 	signal(SIGABRT, skip_signal);
 
+	if (evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack))
+		goto out;
+
 	status = 0;
 	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
 		if (stat_config.run_count != 1 && verbose > 0)
@@ -2328,6 +2364,8 @@ int cmd_stat(int argc, const char **argv)
 	if (!forever && status != -1 && (!interval || stat_config.summary))
 		print_counters(NULL, argc, argv);
 
+	evlist__finalize_ctlfd(evsel_list);
+
 	if (STAT_RECORD) {
 		/*
 		 * We synthesize the kernel mmap record just so that older tools
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 41d59f192931..f8778cffd941 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -133,6 +133,8 @@ struct perf_stat_config {
 	struct perf_cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
+	int			 ctl_fd;
+	int			 ctl_fd_ack;
 };
 
 void perf_stat__set_big_num(int set);
-- 
2.24.1


