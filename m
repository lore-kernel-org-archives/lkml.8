Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11373C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96DA20775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgDTO4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:56:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:55088 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgDTO4M (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:56:12 -0400
IronPort-SDR: LRdVV/8qFANDV0iSqrq5Q1M347U/WHuIZ+7fRqWvM/4Qcs4HY3acEAEBF1XANhZ0cW0vjp5xzN
 AAvmMxFsdSzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 07:56:11 -0700
IronPort-SDR: eSXRQPXmQQnzrAvjhoStN59burVeMlFfZw0/ehq/K0n+InVZGMqL5lNSIrthuecCCqfKahQMD9
 jPd528WghEEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="273202981"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2020 07:56:09 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf stat: Improve runtime stat for interval mode
Date:   Mon, 20 Apr 2020 22:54:17 +0800
Message-Id: <20200420145417.6864-1-yao.jin@linux.intel.com>
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

 v2:
 ---
 Use just existing perf_stat__reset_shadow_per_stat(&rt_stat).
 We don't need to define new function perf_stat__reset_rt_stat.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 2 ++
 tools/perf/builtin-stat.c              | 1 +
 2 files changed, 3 insertions(+)

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
index 9207b6c45475..3f050d85c277 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -359,6 +359,7 @@ static void process_interval(void)
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
 
+	perf_stat__reset_shadow_per_stat(&rt_stat);
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
-- 
2.17.1

