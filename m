Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D562C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB2121734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgBMJdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:33:09 -0500
Received: from mail.wangsu.com ([123.103.51.198]:60807 "EHLO wangsu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729526AbgBMJdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:33:09 -0500
X-Greylist: delayed 2197 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 04:33:00 EST
Received: from localhost.localdomain (unknown [218.107.205.217])
        by app1 (Coremail) with SMTP id xjNnewA3PcEYD0VekhoTAA--.21715S2;
        Thu, 13 Feb 2020 16:56:00 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        ak@linux.intel.com, liuqi115@hisilicon.com
Cc:     linux-kernel@vger.kernel.org, Lin Feng <linf@wangsu.com>
Subject: [PATCH] Perf stat: Fix the ratio comments of cache miss-events
Date:   Thu, 13 Feb 2020 16:55:40 +0800
Message-Id: <20200213085540.14998-1-linf@wangsu.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: xjNnewA3PcEYD0VekhoTAA--.21715S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr4fXrW3JFW8GFWrGFy3Jwb_yoWxJFWDpa
        yfGrn3CF4kXF1rAa1UAryxuryrJrZxJF12g3yqya1q9F1Fy34Y9F1qgwnFyr18ArZ8Ja13
        AFZYka12yrsxAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUga1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
        F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F4
        0EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Gr4lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl42
        xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
        UjIFyTuYvjfUxZjjDUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
iTLB cache and LL-cache, while the comments for them seem a bit
misleading. Take L1-dcache for example, its miss ratio
is caculated as "L1-dcache-load-misses/L1-dcache-loads". So "of all
L1-dcache hits" is unsuitable to describe it, and "of all L1-dcache
accesses/references" seems better.

 285,132,521 cache-misses            #   53.696 % of all cache refs     [83.34%]
 531,015,219 cache-references                                           [83.20%]
 220,465,183 LLC-load-misses         #   72.33% of all LL-cache miss    [83.44%]
                                                                  ^^^^
 304,787,745 LLC-loads                                                  [66.60%]

There is an old patch here https://lkml.org/lkml/2019/11/16/37, but
seems not upstreamed yet. This patch follows suggestions by Arnaldo.
But one difference is using "refs" to follow the convention because
there is comment also for cache-misses event which uses
"of all cache refs".
The comments of L1-icache, dTLB cache, iTLB cache and LL-cache are
fixed in the same way.

P.S. Liu and Andi if you don't mind this patch adds your Reviewed-by
and Signed-off-by, thanks.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Qi Liu <liuqi115@hisilicon.com>
Signed-off-by: Lin Feng <linf@wangsu.com>
---
 tools/perf/util/stat-shadow.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47f6f83..070e9749e934 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -506,7 +506,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
 
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache refs", ratio);
 }
 
 static void print_l1_icache_misses(struct perf_stat_config *config,
@@ -527,7 +527,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache refs", ratio);
 }
 
 static void print_dtlb_cache_misses(struct perf_stat_config *config,
@@ -547,7 +547,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache refs", ratio);
 }
 
 static void print_itlb_cache_misses(struct perf_stat_config *config,
@@ -567,7 +567,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache refs", ratio);
 }
 
 static void print_ll_cache_misses(struct perf_stat_config *config,
@@ -587,7 +587,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;
 
 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache refs", ratio);
 }
 
 /*
@@ -872,7 +872,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
 			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache refs", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
@@ -882,7 +882,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
 			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all L1-icache refs", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
@@ -892,7 +892,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
 			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache refs", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
@@ -902,7 +902,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
 			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache refs", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
@@ -912,7 +912,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
 			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all LL-cache refs", 0);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
 		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
 
-- 
2.20.1

