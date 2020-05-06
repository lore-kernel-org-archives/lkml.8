Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFA92078C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEFSWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:22:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:39177 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbgEFSWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:22:23 -0400
IronPort-SDR: 1DArhKc3A+gQJluoir9519Yyy30ySSsoxfVADDOIkMOtUDRuFyPAvBaLnrFPpXClwbQwk4std8
 2LO+Y8N5gcPw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:22:23 -0700
IronPort-SDR: ns4R22MnWHfFuIq+mrSPORk6soGLphBozU6velJdf/DC7Wqx1+J5NMW+UYcPaLZ4z4s9nfsFFd
 0nsAs+azppXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="260191972"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2020 11:22:23 -0700
Received: from [10.249.228.227] (abudanko-mobl.ccr.corp.intel.com [10.249.228.227])
        by linux.intel.com (Postfix) with ESMTP id 3591058048A;
        Wed,  6 May 2020 11:22:21 -0700 (PDT)
Subject: [PATCH v2 06/11] perf stat: introduce --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cd51a709-aecc-c79a-6d57-80a8cd008c2f@linux.intel.com>
Date:   Wed, 6 May 2020 21:22:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce --ctl-fd[-ack] options to pass open file descriptors
numbers from command line.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 10 ++++++++++
 tools/perf/util/stat.h    |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5aab3ff1bbea..60c0d9521f74 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -187,6 +187,8 @@ static struct perf_stat_config stat_config = {
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
+	.ctl_fd			= -1,
+	.ctl_fd_ack		= -1
 };
 
 static inline void diff_timespec(struct timespec *r, struct timespec *a,
@@ -984,6 +986,10 @@ static struct option stat_options[] = {
 		    "Use with 'percore' event qualifier to show the event "
 		    "counts of one hardware thread by sum up total hardware "
 		    "threads of same physical core"),
+	OPT_INTEGER(0, "ctl-fd", &stat_config.ctl_fd,
+		    "Listen on fd descriptor for command to control measurement ('e': enable events, 'd': disable events)"),
+	OPT_INTEGER(0, "ctl-fd-ack", &stat_config.ctl_fd_ack,
+		    "Send control command completion ('a') to fd ack descriptor"),
 	OPT_END()
 };
 
@@ -2180,6 +2186,8 @@ int cmd_stat(int argc, const char **argv)
 	signal(SIGALRM, skip_signal);
 	signal(SIGABRT, skip_signal);
 
+	perf_evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack);
+
 	status = 0;
 	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
 		if (stat_config.run_count != 1 && verbose > 0)
@@ -2199,6 +2207,8 @@ int cmd_stat(int argc, const char **argv)
 	if (!forever && status != -1 && !interval)
 		print_counters(NULL, argc, argv);
 
+	perf_evlist__finalize_ctlfd(evsel_list);
+
 	if (STAT_RECORD) {
 		/*
 		 * We synthesize the kernel mmap record just so that older tools
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 027b9dcd902f..0b0fa3a2cde2 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -130,6 +130,8 @@ struct perf_stat_config {
 	struct perf_cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
+	int			 ctl_fd;
+	int			 ctl_fd_ack;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.24.1


