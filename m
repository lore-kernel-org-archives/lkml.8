Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E477C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4F020714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgC0Ity (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:49:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:23421 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgC0Itx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:49:53 -0400
IronPort-SDR: rUhakbOYtTkTrY5A7Ro4KWj/qiaqnxZIc2zXDJLIsxnmHVDTG8+ToQpgBgXeLFgcuHCPVRyXvl
 nhy9u9b/9mIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:49:53 -0700
IronPort-SDR: M0GUwlkTiRHeBIuJb0OQWsrs44vlaTCh26lP5U9FibaZCsUfbnLDAGDg/HfAojf/VScdj3MqrQ
 wk607div46Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="358425864"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2020 01:49:53 -0700
Received: from [10.249.36.56] (abudanko-mobl.ccr.corp.intel.com [10.249.36.56])
        by linux.intel.com (Postfix) with ESMTP id DBCB8580479;
        Fri, 27 Mar 2020 01:49:50 -0700 (PDT)
Subject: [PATCH v1 6/8] perf record: introduce control descriptors and
 --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8f1b6db8-1d54-06d4-18b9-a1e24ff0e2cb@linux.intel.com>
Date:   Fri, 27 Mar 2020 11:49:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce control file descriptors and --ctl-fd[-ack] options to pass
control descriptors from command line. Extend --delay option with -1
value to start collection in paused mode to be resumed later by resume
command provided via control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 18 ++++++++++++++----
 tools/perf/builtin-trace.c  |  2 +-
 tools/perf/util/record.h    |  4 +++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..f99751943b40 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1621,8 +1621,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	if (opts->initial_delay) {
-		usleep(opts->initial_delay * USEC_PER_MSEC);
-		evlist__enable(rec->evlist);
+		pr_info(PERF_EVLIST__PAUSED_MSG);
+		if (opts->initial_delay > 0) {
+			usleep(opts->initial_delay * USEC_PER_MSEC);
+			evlist__enable(rec->evlist);
+			pr_info(PERF_EVLIST__RESUMED_MSG);
+		}
 	}
 
 	trigger_ready(&auxtrace_snapshot_trigger);
@@ -2218,6 +2222,8 @@ static struct record record = {
 			.default_per_cpu = true,
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
+		.ctl_fd              = -1,
+		.ctl_fd_ack          = -1,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -2320,8 +2326,8 @@ static struct option __record_options[] = {
 	OPT_CALLBACK('G', "cgroup", &record.evlist, "name",
 		     "monitor event in cgroup name only",
 		     parse_cgroups),
-	OPT_UINTEGER('D', "delay", &record.opts.initial_delay,
-		  "ms to wait before starting measurement after program start"),
+	OPT_INTEGER('D', "delay", &record.opts.initial_delay,
+		  "ms to wait before starting measurement after program start (-1: start paused)"),
 	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
 	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
 		   "user to profile"),
@@ -2405,6 +2411,10 @@ static struct option __record_options[] = {
 #endif
 	OPT_CALLBACK(0, "max-size", &record.output_max_size,
 		     "size", "Limit the maximum size of the output file", parse_output_max_size),
+	OPT_INTEGER(0, "ctl-fd", &record.opts.ctl_fd,
+		    "Listen on fd descriptor for command to control measurement ('r': resume, 'p': pause)"),
+	OPT_INTEGER(0, "ctl-fd-ack", &record.opts.ctl_fd_ack,
+		    "Send control command completion ('a') to fd ack descriptor"),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 01d542007c8b..4088d099f8bd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4778,7 +4778,7 @@ int cmd_trace(int argc, const char **argv)
 			"per thread proc mmap processing timeout in ms"),
 	OPT_CALLBACK('G', "cgroup", &trace, "name", "monitor event in cgroup name only",
 		     trace__parse_cgroups),
-	OPT_UINTEGER('D', "delay", &trace.opts.initial_delay,
+	OPT_INTEGER('D', "delay", &trace.opts.initial_delay,
 		     "ms to wait before starting measurement after program "
 		     "start"),
 	OPTS_EVSWITCH(&trace.evswitch),
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 5421fd2ad383..138f914f4ea9 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -59,7 +59,7 @@ struct record_opts {
 	const char    *auxtrace_snapshot_opts;
 	const char    *auxtrace_sample_opts;
 	bool	      sample_transaction;
-	unsigned      initial_delay;
+	int	      initial_delay;
 	bool	      use_clockid;
 	clockid_t     clockid;
 	u64	      clockid_res_ns;
@@ -67,6 +67,8 @@ struct record_opts {
 	int	      affinity;
 	int	      mmap_flush;
 	unsigned int  comp_level;
+	int	      ctl_fd;
+	int	      ctl_fd_ack;
 };
 
 extern const char * const *record_usage;
-- 
2.24.1


