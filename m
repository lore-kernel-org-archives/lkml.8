Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D35C761A1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7681024654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBSVpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:45:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:59618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbgBSVpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:45:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13A39AF2D;
        Wed, 19 Feb 2020 21:45:17 +0000 (UTC)
Date:   Wed, 19 Feb 2020 21:45:13 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200219214513.GL3420@suse.de>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200219204220.GA3488@sultan-book.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:42:20PM -0800, Sultan Alsawaf wrote:
> > Again, do you have more details about the workload and what was the
> > cause of responsiveness issues? Because I would expect that the
> > situation would be quite opposite because it is usually the direct
> > reclaim that is a source of stalls visible from userspace. Or is this
> > about a single CPU situation where kswapd saturates the single CPU and
> > all other tasks are just not getting enough CPU cycles?
> 
> The workload was having lots of applications open at once. At a certain point
> when memory ran low, my system became sluggish and kswapd CPU usage skyrocketed.
> I added printks into kswapd with this patch, and my premature exit in kswapd
> kicked in quite often.
> 

This could be watermark boosting run wild again. Can you test with
sysctl vm.watermark_boost_factor=0 or the following patch? (preferably
both to compare and contrast).

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
