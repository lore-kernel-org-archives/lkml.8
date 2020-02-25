Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C90C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A506D20732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgBYOPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:15:46 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:57477 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729065AbgBYOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:15:39 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 743991636
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:15:37 +0000 (GMT)
Received: (qmail 2025 invoked from network); 25 Feb 2020 14:15:37 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 25 Feb 2020 14:15:37 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Ivan Babrou <ivan@cloudflare.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/3] mm, vmscan: Do not reclaim for boosted watermarks at high priority
Date:   Tue, 25 Feb 2020 14:15:34 +0000
Message-Id: <20200225141534.5044-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200225141534.5044-1-mgorman@techsingularity.net>
References: <20200225141534.5044-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Babrou reported the following (slightly paraphrased)

	Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when
	an external fragmentation event occurs") introduced undesired
	effects in our environment.

	  * NUMA with 2 x CPU
	  * 128GB of RAM
	  * THP disabled
	  * Upgraded from 4.19 to 5.4

	Before we saw free memory hover at around 1.4GB with no
	spikes. After the upgrade we saw some machines decide that they
	need a lot more than that, with frequent spikes above 10GB,
	often only on a single numa node.

	We can see kswapd quite active in balance_pgdat (it didn't look
	like it slept at all):

	$ ps uax | fgrep kswapd
	root       1850 23.0  0.0      0     0 ?        R    Jan30 1902:24 [kswapd0]
	root       1851  1.8  0.0      0     0 ?        S    Jan30 152:16 [kswapd1]

	This in turn massively increased pressure on page cache, which did not
	go well to services that depend on having a quick response from a
	local cache backed by solid storage.

Rik van Riel indicated that he had observed something similar. Details
are sparse but the bulk of the excessive reclaim activity appears to
be on node 0. My belief is that on node 0, a DMA32 or DMA zone can get
boosted but vmscan then reclaims from higher zones until the boost is
removed. While we could apply the reclaim to just the lower zones, it
would result in a lot of pages skipped during scanning.

Watermark boosting is inherently optimisitc and is only applied to
reduce the possibility of pageblocks being mixed further in the future so
high-order allocations are both more likely to succeed and be allocated
with lower latency. It was not intended that it reclaim the world ever.

This patch limits watermark boosting. If reclaim reaches a higher priority
then reclaim based on watermark boosting is aborted. Unfortunately,
the bug reporters are not in the position to actually test this but it
makes sense that watermark boosting be aborted quickly when reclaim is
not making progress given that boosting was never intended to reclaim or
scan excessively.

While I could not reproduce the problem locally, this was compared against
a vanilla kernel and one with watermark boosting disabled. The test results
still indicate that this helps the workloads addressed by 1c30844d2dfe
("mm: reclaim small amounts of memory when an external fragmentation event
occurs") although the behaviour of THP allocation has changed since making
a direct comparison problematic. At worst, this patch will mitigate a
problem when watermarks are persistently boosted.

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmscan.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 876370565455..40c9e48dc542 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3449,6 +3449,25 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
 	return false;
 }
 
+static void acct_boosted_reclaim(pg_data_t *pgdat, int classzone_idx,
+				unsigned long *zone_boosts)
+{
+	struct zone *zone;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i <= classzone_idx; i++) {
+		if (!zone_boosts[i])
+			continue;
+
+		/* Increments are under the zone lock */
+		zone = pgdat->node_zones + i;
+		spin_lock_irqsave(&zone->lock, flags);
+		zone->watermark_boost -= min(zone->watermark_boost, zone_boosts[i]);
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+}
+
 /* Clear pgdat state for congested, dirty or under writeback. */
 static void clear_pgdat_congested(pg_data_t *pgdat)
 {
@@ -3641,9 +3660,17 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 		if (!nr_boost_reclaim && balanced)
 			goto out;
 
-		/* Limit the priority of boosting to avoid reclaim writeback */
-		if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
-			raise_priority = false;
+		/*
+		 * Abort boosting if reclaiming at higher priority is not
+		 * working to avoid excessive reclaim due to lower zones
+		 * being boosted.
+		 */
+		if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2) {
+			acct_boosted_reclaim(pgdat, classzone_idx, zone_boosts);
+			boosted = false;
+			nr_boost_reclaim = 0;
+			goto restart;
+		}
 
 		/*
 		 * Do not writeback or swap pages for boosted reclaim. The
@@ -3725,18 +3752,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 out:
 	/* If reclaim was boosted, account for the reclaim done in this pass */
 	if (boosted) {
-		unsigned long flags;
-
-		for (i = 0; i <= classzone_idx; i++) {
-			if (!zone_boosts[i])
-				continue;
-
-			/* Increments are under the zone lock */
-			zone = pgdat->node_zones + i;
-			spin_lock_irqsave(&zone->lock, flags);
-			zone->watermark_boost -= min(zone->watermark_boost, zone_boosts[i]);
-			spin_unlock_irqrestore(&zone->lock, flags);
-		}
+		acct_boosted_reclaim(pgdat, classzone_idx, zone_boosts);
 
 		/*
 		 * As there is now likely space, wakeup kcompact to defragment
-- 
2.16.4

