Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B9AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537FD20873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgETE3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:29:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:54957 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETE3o (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:29:44 -0400
IronPort-SDR: 7cT0D8+0oC+ez5uPIXzx89dkQH+fG+D73N8QcZUnapAY7hXLX1NQ3bwKn6Pi7mP181IuP72104
 GJt+pwBL/DhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 21:29:43 -0700
IronPort-SDR: DgGJec+UiF56OYM/PQVay8HxbOCNLl4zv10MVNFrOz1QxLMBS4w1T/ZykvjB4qGCNP4ReitugF
 a7vzIc8H9Ngg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="289217288"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 21:29:41 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 1/5] perf stat: Fix wrong per-thread runtime stat for interval mode
Date:   Wed, 20 May 2020 12:27:33 +0800
Message-Id: <20200520042737.24160-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520042737.24160-1-yao.jin@linux.intel.com>
References: <20200520042737.24160-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

root@kbl-ppc:~# perf stat --per-thread -e cycles,instructions -I1000 --interval-count 2
     1.004171683             perf-3696              8,747,311      cycles
        ...
     1.004171683             perf-3696                691,730      instructions              #    0.08  insn per cycle
        ...
     2.006490373             perf-3696              1,749,936      cycles
        ...
     2.006490373             perf-3696              1,484,582      instructions              #    0.28  insn per cycle
        ...

Let's see interval 2.006490373

perf-3696              1,749,936      cycles
perf-3696              1,484,582      instructions              #    0.28  insn per cycle

insn per cycle = 1,484,582 / 1,749,936 = 0.85.
But now it's 0.28, that's not correct.

stat_config.stats[] records the per-thread runtime stat. But for interval
mode, it should be reset for each interval.

So now, with this patch,

root@kbl-ppc:~# perf stat --per-thread -e cycles,instructions -I1000 --interval-count 2
     1.005818121             perf-8633              9,898,045      cycles
        ...
     1.005818121             perf-8633                693,298      instructions              #    0.07  insn per cycle
        ...
     2.007863743             perf-8633              1,551,619      cycles
        ...
     2.007863743             perf-8633              1,317,514      instructions              #    0.85  insn per cycle
        ...

Let's check interval 2.007863743.

insn per cycle = 1,317,514 / 1,551,619 = 0.85. It's correct.

This patch creates runtime_stat_reset, places it next to
untime_stat_new/runtime_stat_delete and moves all runtime_stat
functions before process_interval.

 v4:
 ---
 Create runtime_stat_reset.

Fixes: commit 14e72a21c783 ("perf stat: Update or print per-thread stats")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 70 +++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e0c1ad23c768..f3b3a59ac7d2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -351,6 +351,46 @@ static void read_counters(struct timespec *rs)
 	}
 }
 
+static int runtime_stat_new(struct perf_stat_config *config, int nthreads)
+{
+	int i;
+
+	config->stats = calloc(nthreads, sizeof(struct runtime_stat));
+	if (!config->stats)
+		return -1;
+
+	config->stats_num = nthreads;
+
+	for (i = 0; i < nthreads; i++)
+		runtime_stat__init(&config->stats[i]);
+
+	return 0;
+}
+
+static void runtime_stat_delete(struct perf_stat_config *config)
+{
+	int i;
+
+	if (!config->stats)
+		return;
+
+	for (i = 0; i < config->stats_num; i++)
+		runtime_stat__exit(&config->stats[i]);
+
+	zfree(&config->stats);
+}
+
+static void runtime_stat_reset(struct perf_stat_config *config)
+{
+	int i;
+
+	if (!config->stats)
+		return;
+
+	for (i = 0; i < config->stats_num; i++)
+		perf_stat__reset_shadow_per_stat(&config->stats[i]);
+}
+
 static void process_interval(void)
 {
 	struct timespec ts, rs;
@@ -359,6 +399,7 @@ static void process_interval(void)
 	diff_timespec(&rs, &ts, &ref_time);
 
 	perf_stat__reset_shadow_per_stat(&rt_stat);
+	runtime_stat_reset(&stat_config);
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
@@ -1737,35 +1778,6 @@ int process_cpu_map_event(struct perf_session *session,
 	return set_maps(st);
 }
 
-static int runtime_stat_new(struct perf_stat_config *config, int nthreads)
-{
-	int i;
-
-	config->stats = calloc(nthreads, sizeof(struct runtime_stat));
-	if (!config->stats)
-		return -1;
-
-	config->stats_num = nthreads;
-
-	for (i = 0; i < nthreads; i++)
-		runtime_stat__init(&config->stats[i]);
-
-	return 0;
-}
-
-static void runtime_stat_delete(struct perf_stat_config *config)
-{
-	int i;
-
-	if (!config->stats)
-		return;
-
-	for (i = 0; i < config->stats_num; i++)
-		runtime_stat__exit(&config->stats[i]);
-
-	zfree(&config->stats);
-}
-
 static const char * const stat_report_usage[] = {
 	"perf stat report [<options>]",
 	NULL,
-- 
2.17.1

