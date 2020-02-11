Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ADCC3B188
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0933520848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgBKKQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:16:34 -0500
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:39715 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727937AbgBKKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:16:33 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 4AEDCFA80D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 10:16:30 +0000 (GMT)
Received: (qmail 14398 invoked from network); 11 Feb 2020 10:16:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Feb 2020 10:16:29 -0000
Date:   Tue, 11 Feb 2020 10:16:27 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Reclaim regression after 1c30844d2dfe
Message-ID: <20200211101627.GJ3466@techsingularity.net>
References: <CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 02:54:43PM -0800, Ivan Babrou wrote:
> This change from 5.5 times:
> 
> * https://github.com/torvalds/linux/commit/1c30844d2dfe
> 
> > mm: reclaim small amounts of memory when an external fragmentation event occurs
> 
> Introduced undesired effects in our environment.
> 
> * NUMA with 2 x CPU
> * 128GB of RAM
> * THP disabled
> * Upgraded from 4.19 to 5.4
> 
> Before we saw free memory hover at around 1.4GB with no spikes. After
> the upgrade we saw some machines decide that they need a lot more than
> that, with frequent spikes above 10GB, often only on a single numa
> node.
> 
> We can see kswapd quite active in balance_pgdat (it didn't look like
> it slept at all):
> 
> $ ps uax | fgrep kswapd
> root       1850 23.0  0.0      0     0 ?        R    Jan30 1902:24 [kswapd0]
> root       1851  1.8  0.0      0     0 ?        S    Jan30 152:16 [kswapd1]
> 
> This in turn massively increased pressure on page cache, which did not
> go well to services that depend on having a quick response from a
> local cache backed by solid storage.
> 
> Here's how it looked like when I zeroed vm.watermark_boost_factor:
> 
> * https://imgur.com/a/6IZWicU
> 
> IO subsided from 100% busy in page cache population at 300MB/s on a
> single SATA drive down to under 100MB/s.
> 
> This sort of regression doesn't seem like a good thing.

It is not a good thing, so thanks for the report. Obviously I have not
seen something similar or least not severe enough to show up on my radar.
I'd seen some increases with reclaim activity affecting benchmarks that
rely on use-twice data remaining resident but nothing severe enough to
warrant action.

Can you tell me if it is *always* node 0 that shows crazy activity? I
ask because some conditions would have to be met for the boost to always
apply. It's already a per-zone attribute but it is treated indirectly as a
pgdat property. What I'm thinking is that on node 0, the DMA32 or DMA zone
gets boosted but vmscan then reclaims from higher zones until the boost is
removed. That would excessively reclaim memory but be specific to node 0.

I've cc'd Rik as he says he saw something similar even on single node
systems. The boost applying to lower zones would still affect single
node systems but NUMA machines always getting impacted by boost would
show that the boost really needs to be a per-node flag. Sure, we *could*
apply the reclaim to just the lower zones but that potentially means a
*lot* of scan activity -- potentially 124G of pages before a lower zone
page is found on Ivan's machine. That might be the very situation being
encountered here.

An alternative is that boosting is only ever applied to the highest
populated zone in a system. The intent of the patch was primarily about
THP which can use any zone to reduce their allocaation latency. While
it's possible that there are cases where the latency of other orders
matter *and* they require lower zones, I think it's unlikely and that
this would be a safer option overall.

However, overall I think the simpliest is to abort the boosting if
reclaim is reaching higher priorities without being able to clear
the boost. The boost is best-effort to reduce allocation latency in
the future. This approach still has some overhead as there is a reclaim
pass but kswapd will abort and go to sleep if the normal watermarks
are met.

This is build tested only. Ideally someone on the cc has a test case
that can reproduce this specific problem of excessive kswapd activity.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 572fb17c6273..71dd47172cef 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3462,6 +3462,25 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
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
@@ -3654,9 +3673,17 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
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
@@ -3738,18 +3765,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
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
