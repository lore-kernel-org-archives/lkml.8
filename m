Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E4C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9091923126
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgEMIBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:01:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:47595 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgEMIBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:01:40 -0400
IronPort-SDR: 0ejbC3xMoK1Cl88D0ug6YVdWdGZ921DOnox6czgHMhYwOIgAopvfWrx2xDmuXBhrxWF/e0K7GM
 Tx+ZTavu+GYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 01:01:39 -0700
IronPort-SDR: NoTDY+AIgDQXQtgG8AzhetVcXPGchDeUYv1K4zDJNpp5WkZw8tw7WwjG4V3Horar2CSZafuHk5
 jTlvURndN+/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="463843822"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2020 01:01:39 -0700
Received: from [10.249.229.18] (abudanko-mobl.ccr.corp.intel.com [10.249.229.18])
        by linux.intel.com (Postfix) with ESMTP id 0171E5804B6;
        Wed, 13 May 2020 01:01:36 -0700 (PDT)
Subject: [PATCH v3 4/9] perf stat: extend -D,--delay option with -1 value
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <86180715-faae-e701-319c-70ce589923a9@linux.intel.com>
Date:   Wed, 13 May 2020 11:01:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
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
 tools/perf/util/evlist.h               |  4 ++++
 tools/perf/util/stat.h                 |  2 +-
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 3fb5028aef08..3b91b30d7672 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -226,8 +226,9 @@ mode, use --per-node in addition to -a. (system-wide).
 
 -D msecs::
 --delay msecs::
-After starting the program, wait msecs before measuring. This is useful to
-filter out the startup phase of the program, which is often very different.
+After starting the program, wait msecs before measuring (-1: start with events
+disabled"). This is useful to filter out the startup phase of the program,
+which is often very different.
 
 -T::
 --transaction::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9775b0905146..73404b723592 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -383,16 +383,26 @@ static bool print_interval_and_stop(struct perf_stat_config *config, int *times)
 
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
@@ -929,8 +939,8 @@ static struct option stat_options[] = {
 		     "aggregate counts per thread", AGGR_THREAD),
 	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
 		     "aggregate counts per numa node", AGGR_NODE),
-	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
-		     "ms to wait before starting measurement after program start"),
+	OPT_INTEGER('D', "delay", &stat_config.initial_delay,
+		    "ms to wait before starting measurement after program start (-1: start with events disabled"),
 	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
 			"Only print computed metrics. No raw values", enable_metric_only),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 0554f8d2a65b..8a72612b8b3e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -375,4 +375,8 @@ int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 
+#define EVLIST_ENABLED_MSG "Events enabled\n"
+#define EVLIST_DISABLED_MSG "Events disabled\n"
+
+
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b4fdfaa7f2c0..027b9dcd902f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -113,7 +113,7 @@ struct perf_stat_config {
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


