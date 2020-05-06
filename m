Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECDEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACF320747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgEFSU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:20:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:45742 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729757AbgEFSU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:20:58 -0400
IronPort-SDR: 1ns3Uh9GibrGlVxCBfZ3PkZ0OQUV86FZfLNGaFY7uebvmVwlwJKOv27niAtS1+ZXDGA00NmRoX
 C/6x1O274Y0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:20:57 -0700
IronPort-SDR: HCPTaO2Hwj49m6PtKDn0xkScq8UN+38Fy94ZSIF4qlGOEofq+QuFwChFSp2Epl3v4hcmO0OSaQ
 Ozn36vM3hKzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="263650013"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 06 May 2020 11:20:57 -0700
Received: from [10.249.228.227] (abudanko-mobl.ccr.corp.intel.com [10.249.228.227])
        by linux.intel.com (Postfix) with ESMTP id 531B258043A;
        Wed,  6 May 2020 11:20:55 -0700 (PDT)
Subject: [PATCH v2 04/11] perf stat: extend -D,--delay option with -1 value
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
Message-ID: <df2ffd5b-dcd6-40ea-8053-74feef07724f@linux.intel.com>
Date:   Wed, 6 May 2020 21:20:54 +0300
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


Extend -D,--delay option with -1 value to start monitoring with
events disabled to be enabled later by enable command provided
via control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 18 ++++++++++++++----
 tools/perf/util/evlist.h  |  3 +++
 tools/perf/util/stat.h    |  2 +-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9775b0905146..bda777ca0420 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -383,16 +383,26 @@ static bool print_interval_and_stop(struct perf_stat_config *config, int *times)
 
 static void enable_counters(void)
 {
-	if (stat_config.initial_delay)
+	if (stat_config.initial_delay < 0) {
+		pr_info(PERF_EVLIST__DISABLED_MSG);
+		return;
+	}
+
+	if (stat_config.initial_delay > 0) {
+		pr_info(PERF_EVLIST__DISABLED_MSG);
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
+			pr_info(PERF_EVLIST__ENABLED_MSG);
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
index 84386850c290..874ecf068ac9 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -366,6 +366,9 @@ enum evlist_ctl_cmd {
 	CTL_CMD_ACK = 'a'
 };
 
+#define PERF_EVLIST__ENABLED_MSG "Events enabled\n"
+#define PERF_EVLIST__DISABLED_MSG "Events disabled\n"
+
 int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int perf_evlist__finalize_ctlfd(struct evlist *evlist);
 int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
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


