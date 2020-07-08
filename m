Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C718BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD50E20672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGHHxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:53:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:63480 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgGHHxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:53:07 -0400
IronPort-SDR: Yo31FCfIKSIrDAuerFWFGcu3vab88eQIOxZfWH7SZL442j99cBnzRJlgJNcTLJY9CK+mACETc+
 CdrHVnVkOeBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="149267012"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="149267012"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:53:06 -0700
IronPort-SDR: 6kvmJWEXknsTkvD4gtKfEm6NH0jUp9MBddMWYFlMGj3MQwDpIemOGkb0jz+qe0HFw9qhsPRxhu
 lopatIRaBE+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358030872"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 00:53:05 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id 1F6595807C9;
        Wed,  8 Jul 2020 00:53:02 -0700 (PDT)
Subject: [PATCH v10 10/15] perf stat: extend -D,--delay option with -1 value
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
Message-ID: <144b72a8-e718-4f28-d1cf-8ec5f402b2e2@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:53:02 +0300
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
index a5a0f4841003..9d5c503e698f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -487,16 +487,26 @@ static bool handle_interval(unsigned int interval, int *times)
 
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
@@ -1053,8 +1063,8 @@ static struct option stat_options[] = {
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
index 1dac16f574fe..243ff8f2f130 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -377,4 +377,7 @@ int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 
+#define EVLIST_ENABLED_MSG "Events enabled\n"
+#define EVLIST_DISABLED_MSG "Events disabled\n"
+
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 6911c7249199..41d59f192931 100644
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


