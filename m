Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF38EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A842145D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGNJM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:12:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:51837 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNJMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:12:25 -0400
IronPort-SDR: kXBjwjQV/AG8GUue9m4xKxdLonS72qC+TRucocfhDiz9gugNgKk9Rgo6Ls5d4caBOMQYj3V7r8
 BAr0O4Da4V6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="166951203"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="166951203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:12:25 -0700
IronPort-SDR: bBu9QoR5gPRVxEQlf8OMzHTMpy9C39Hdru/VajYFWBc4ivUKLlAoDB9YkUM4kRfbtdrwSbTPkC
 A/g7sIPlprfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="269958009"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2020 02:12:25 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id 6A358580814;
        Tue, 14 Jul 2020 02:12:23 -0700 (PDT)
Subject: [PATCH v11 15/15] perf record: introduce --control fd:ctl-fd[,ack-fd]
 options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <07d8ab58-d732-f63d-e662-21ebcdca313a@linux.intel.com>
Date:   Tue, 14 Jul 2020 12:12:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce --control fd:ctl-fd[,ack-fd] options to pass open file
descriptors numbers from command line. Extend perf-record.txt file
with --control fd:ctl-fd[,ack-fd] options description. Document
possible usage model introduced by --control fd:ctl-fd[,ack-fd]
options by providing example bash shell script.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 39 ++++++++++++++++++++++++
 tools/perf/builtin-record.c              | 37 ++++++++++++++++++++++
 tools/perf/util/record.h                 |  2 ++
 3 files changed, 78 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index a84376605805..3f72d8e261f3 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -627,6 +627,45 @@ option. The -e option and this one can be mixed and matched.  Events
 can be grouped using the {} notation.
 endif::HAVE_LIBPFM[]
 
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
+perf record -D -1 -e cpu-cycles -a               \
+            --control fd:${ctl_fd},${ctl_fd_ack} \
+            -- sleep 30 &
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
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 632e61fe70bd..0718aa71b4ba 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1749,6 +1749,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		perf_evlist__start_workload(rec->evlist);
 	}
 
+	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
+		goto out_child;
+
 	if (opts->initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -1895,6 +1898,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
@@ -2244,6 +2248,33 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+static int parse_control_option(const struct option *opt,
+				const char *str,
+				int unset __maybe_unused)
+{
+	char *comma = NULL, *endptr = NULL;
+	struct record_opts *config = (struct record_opts *)opt->value;
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
 static void switch_output_size_warn(struct record *rec)
 {
 	u64 wakeup_size = evlist__mmap_size(rec->opts.mmap_pages);
@@ -2380,6 +2411,8 @@ static struct record record = {
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 		.nr_threads_synthesize = 1,
+		.ctl_fd              = -1,
+		.ctl_fd_ack          = -1,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -2581,6 +2614,10 @@ static struct option __record_options[] = {
 		"libpfm4 event selector. use 'perf list' to list available events",
 		parse_libpfm_events_option),
 #endif
+	OPT_CALLBACK(0, "control", &record.opts, "fd:ctl-fd[,ack-fd]",
+		     "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
+		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.",
+		      parse_control_option),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index da138dcb4d34..4cb72a478af1 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -70,6 +70,8 @@ struct record_opts {
 	int	      mmap_flush;
 	unsigned int  comp_level;
 	unsigned int  nr_threads_synthesize;
+	int	      ctl_fd;
+	int	      ctl_fd_ack;
 };
 
 extern const char * const *record_usage;
-- 
2.24.1


