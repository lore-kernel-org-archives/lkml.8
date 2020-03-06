Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F59DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACCF206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCFWGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:06:55 -0500
Received: from shelob.surriel.com ([96.67.55.147]:43026 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCFWGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:06:54 -0500
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jAL7H-0002Ia-Sx; Fri, 06 Mar 2020 17:06:47 -0500
Date:   Fri, 6 Mar 2020 17:06:47 -0500
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH] mm,cma: remove pfn_range_valid_contig
Message-ID: <20200306170647.455a2db3@imladris.surriel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function pfn_range_valid_contig checks whether all memory in the
target area is free. This causes unnecessary CMA failures, since
alloc_contig_range will migrate movable memory out of a target range,
and has its own sanity check early on in has_unmovable_pages, which
is called from start_isolate_page_range & set_migrate_type_isolate.

Relying on that has_unmovable_pages call simplifies the CMA code and
results in an increased success rate of CMA allocations.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/page_alloc.c | 47 +++--------------------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0fb3c1719625..75e84907d8c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8539,32 +8539,6 @@ static int __alloc_contig_pages(unsigned long start_pfn,
 				  gfp_mask);
 }
 
-static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
-				   unsigned long nr_pages)
-{
-	unsigned long i, end_pfn = start_pfn + nr_pages;
-	struct page *page;
-
-	for (i = start_pfn; i < end_pfn; i++) {
-		page = pfn_to_online_page(i);
-		if (!page)
-			return false;
-
-		if (page_zone(page) != z)
-			return false;
-
-		if (PageReserved(page))
-			return false;
-
-		if (page_count(page) > 0)
-			return false;
-
-		if (PageHuge(page))
-			return false;
-	}
-	return true;
-}
-
 static bool zone_spans_last_pfn(const struct zone *zone,
 				unsigned long start_pfn, unsigned long nr_pages)
 {
@@ -8605,28 +8579,13 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 	zonelist = node_zonelist(nid, gfp_mask);
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
-		spin_lock_irqsave(&zone->lock, flags);
-
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
 		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
-			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
-				/*
-				 * We release the zone lock here because
-				 * alloc_contig_range() will also lock the zone
-				 * at some point. If there's an allocation
-				 * spinning on this lock, it may win the race
-				 * and cause alloc_contig_range() to fail...
-				 */
-				spin_unlock_irqrestore(&zone->lock, flags);
-				ret = __alloc_contig_pages(pfn, nr_pages,
-							gfp_mask);
-				if (!ret)
-					return pfn_to_page(pfn);
-				spin_lock_irqsave(&zone->lock, flags);
-			}
+			ret = __alloc_contig_pages(pfn, nr_pages, gfp_mask);
+			if (!ret)
+				return pfn_to_page(pfn);
 			pfn += nr_pages;
 		}
-		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 	return NULL;
 }
-- 
2.24.1

