Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB149C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F852075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgEGHAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:00:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:18356 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGHA1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:00:27 -0400
IronPort-SDR: kNyEyZe8xEq8uKMckz9BxS38bk9hAjUGI6ffpHElqF6ENDidnd0CLUsBrVoJG01foO2Wf0fsln
 ofd/bCss6Xwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 00:00:27 -0700
IronPort-SDR: Q//iwPQJInuUFkbbb4hY0VVLOavA/Jv1JtZINKfvc6FMgJjATo9Cn4OmBtfLYnIPDRXtkOAc+h
 Ta81sKCOgMVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="370026087"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 00:00:23 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 1/4] perf stat: Fix wrong per-thread runtime stat for interval mode
Date:   Thu,  7 May 2020 14:58:19 +0800
Message-Id: <20200507065822.8255-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507065822.8255-1-yao.jin@linux.intel.com>
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
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

Fixes: commit 14e72a21c783 ("perf stat: Update or print per-thread stats")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e0c1ad23c768..97ee941649e6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -351,6 +351,16 @@ static void read_counters(struct timespec *rs)
 	}
 }
 
+static void thread_stats_reset(struct perf_stat_config *config)
+{
+	int i;
+
+	if (config->stats) {
+		for (i = 0; i < config->stats_num; i++)
+			perf_stat__reset_shadow_per_stat(&config->stats[i]);
+	}
+}
+
 static void process_interval(void)
 {
 	struct timespec ts, rs;
@@ -359,6 +369,7 @@ static void process_interval(void)
 	diff_timespec(&rs, &ts, &ref_time);
 
 	perf_stat__reset_shadow_per_stat(&rt_stat);
+	thread_stats_reset(&stat_config);
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
-- 
2.17.1

