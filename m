Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF6CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C8C206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgFCP6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:58:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:62242 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgFCP6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:58:38 -0400
IronPort-SDR: aT35cZqUGWGp5DD3go2MJE1XOR+/G6nkm59Aqe9lUQSPS+KEvyYBU82jmt4n3XUwiN9pNKV4nz
 fmOWGG3BCmqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:58:38 -0700
IronPort-SDR: XF6dSrgaYnITRbEYe4xUrZmb7jo7V+sRHlxPXCRZ/sEaBQWq18NqpLM28V25H3hUpM9ZXPICnV
 +uyXFRkEjutQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="378146490"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jun 2020 08:58:38 -0700
Received: from [10.249.225.188] (abudanko-mobl.ccr.corp.intel.com [10.249.225.188])
        by linux.intel.com (Postfix) with ESMTP id C066A58045A;
        Wed,  3 Jun 2020 08:58:35 -0700 (PDT)
Subject: [PATCH v7 08/13] perf stat: extend -D,--delay option with -1 value
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Organization: Intel Corp.
Message-ID: <eb0ed2ae-0cfc-08e5-5df1-69b8bfa60aa6@linux.intel.com>
Date:   Wed, 3 Jun 2020 18:58:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Extend -D,--delay option with -1 value to start monitoring with
events disabled to be enabled later by enable command provided
via control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  5 +++--
 tools/perf/builtin-stat.c              | 18 ++++++++++++++----
 tools/perf/util/evlist.h               |  3 +++
 tools/perf/util/stat.h                 |  2 +-
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b029ee728a0b..9f32f6cd558d 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -238,8 +238,9 @@ mode, use --per-node in addition to -a. (system-wide).
 
 -D msecs::
 --delay msecs::
-After starting the program, wait msecs before measuring. This is useful to
-filter out the startup phase of the program, which is often very different.
+After starting the program, wait msecs before measuring (-1: start with events
+disabled). This is useful to filter out the startup phase of the program,
+which is often very different.
 
 -T::
 --transaction::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 39749c290508..f88d5ee55022 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -494,16 +494,26 @@ static bool process_timeout(int timeout, unsigned int interval, int *times)
 
 static void enable_counters(void)
 {
-	if (stat_config.initial_delay)
+	if (stat_config.initial_delay < 0) {
+		pr_info(EVLIST_DISABLED_MSG);
+		return;
+	}
+
+	if (stat_config.initial_delay > 0) {
+		pr_info(EVLIST_DISABLED_MSG);
 		usleep(stat_config.initial_delay * USEC_PER_MSEC);
+	}
 
 	/*
 	 * We need to enable counters only if:
 	 * - we don't have tracee (attaching to task or cpu)
 	 * - we have initial delay configured
 	 */
-	if (!target__none(&target) || stat_config.initial_delay)
+	if (!target__none(&target) || stat_config.initial_delay) {
 		evlist__enable(evsel_list);
+		if (stat_config.initial_delay > 0)
+			pr_info(EVLIST_ENABLED_MSG);
+	}
 }
 
 static void disable_counters(void)
@@ -1060,8 +1070,8 @@ static struct option stat_options[] = {
 		     "aggregate counts per thread", AGGR_THREAD),
 	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
 		     "aggregate counts per numa node", AGGR_NODE),
-	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
-		     "ms to wait before starting measurement after program start"),
+	OPT_INTEGER('D', "delay", &stat_config.initial_delay,
+		    "ms to wait before starting measurement after program start (-1: start with events disabled)"),
 	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
 			"Only print computed metrics. No raw values", enable_metric_only),
 	OPT_BOOLEAN(0, "metric-no-group", &stat_config.metric_no_group,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bccf0a970371..7c3726a685f5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -377,4 +377,7 @@ int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 
+#define EVLIST_ENABLED_MSG "Events enabled\n"
+#define EVLIST_DISABLED_MSG "Events disabled\n"
+
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f75ae679eb28..626421ef35c2 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -116,7 +116,7 @@ struct perf_stat_config {
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-	unsigned int		 initial_delay;
+	int			 initial_delay;
 	unsigned int		 unit_width;
 	unsigned int		 metric_only_len;
 	int			 times;
-- 
2.24.1


