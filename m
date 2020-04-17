Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E48D2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgDQAyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:54:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:14430 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgDQAyF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:54:05 -0400
IronPort-SDR: v7U9cyEAuUd4tpBLlTETgaDYiwR1Aw4cFkEe2n5hckkLU5EojOiNia2f1XVRmP2deqNGwHqvDr
 6dX7ISAGk7Fg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 17:54:04 -0700
IronPort-SDR: 9nrEFpP1p+k6NEwvNMf+6A30nG/noeLSahwQAPg1nLbSbDHwJC3beW6IcXWRudUHHd/vym74vE
 Tmgz4TiuNuDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="278199854"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 17:54:02 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Improve runtime stat for interval mode
Date:   Fri, 17 Apr 2020 08:51:54 +0800
Message-Id: <20200417005154.9024-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For interval mode, the metric is printed after # if it exists. But
it's not calculated by the counts generated in this interval. See
following examples,

 root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
 #           time             counts unit events
      1.000422803            764,809      inst_retired.any          #      2.9 CPI
      1.000422803          2,234,932      cycles
      2.001464585          1,960,061      inst_retired.any          #      1.6 CPI
      2.001464585          4,022,591      cycles

The second CPI should not be 1.6 (4,022,591/1,960,061 is 2.1)

 root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
 #           time             counts unit events
      1.000429493          2,869,311      cycles
      1.000429493            816,875      instructions              #    0.28  insn per cycle
      2.001516426          9,260,973      cycles
      2.001516426          5,250,634      instructions              #    0.87  insn per cycle

The second 'insn per cycle' should not be 0.87 (5,250,634/9,260,973 is 0.57).

The current code uses a global variable rt_stat for tracking and
updating the std dev of runtime stat. Unlike the counts, rt_stat is
not reset for interval. While the counts are reset for interval.

perf_stat_process_counter()
{
	if (config->interval)
		init_stats(ps->res_stats);
}

So for interval, the rt_stat should be reset either.

This patch resets rt_stat before read_counters, so the runtime
stat is only calculated by the counts generated in this interval.

With this patch,

 root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
 #           time             counts unit events
      1.000420924          2,408,818      inst_retired.any          #      2.1 CPI
      1.000420924          5,010,111      cycles
      2.001448579          2,798,407      inst_retired.any          #      1.6 CPI
      2.001448579          4,599,861      cycles

 root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
 #           time             counts unit events
      1.000428555          2,769,714      cycles
      1.000428555            774,462      instructions              #    0.28  insn per cycle
      2.001471562          3,595,904      cycles
      2.001471562          1,243,703      instructions              #    0.35  insn per cycle

Now the second 'insn per cycle' and CPI are calculated by the counts
generated in this interval.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 2 ++
 tools/perf/builtin-stat.c              | 1 +
 tools/perf/util/stat-shadow.c          | 5 +++++
 tools/perf/util/stat.h                 | 1 +
 4 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4d56586b2fb9..3fb5028aef08 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -176,6 +176,8 @@ Print count deltas every N milliseconds (minimum: 1ms)
 The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
 	example: 'perf stat -I 1000 -e cycles -a sleep 5'
 
+If the metric exists, it is calculated by the counts generated in this interval and the metric is printed after #.
+
 --interval-count times::
 Print count deltas for fixed number of times.
 This option should be used together with "-I" option.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ec053dc1e35c..d5c326ff46d0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -359,6 +359,7 @@ static void process_interval(void)
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
 
+	perf_stat__reset_rt_stat();
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 1ad5c5be7e97..c8f5ca6c8749 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -186,6 +186,11 @@ void perf_stat__reset_shadow_stats(void)
 	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
 }
 
+void perf_stat__reset_rt_stat(void)
+{
+	reset_stat(&rt_stat);
+}
+
 void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
 {
 	reset_stat(st);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b4fdfaa7f2c0..2975494166dd 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -176,6 +176,7 @@ void runtime_stat__init(struct runtime_stat *st);
 void runtime_stat__exit(struct runtime_stat *st);
 void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
+void perf_stat__reset_rt_stat(void);
 void perf_stat__reset_shadow_per_stat(struct runtime_stat *st);
 void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st);
-- 
2.17.1

