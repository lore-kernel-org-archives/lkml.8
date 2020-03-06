Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C984C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2A820709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFUBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:01:11 -0500
Received: from shelob.surriel.com ([96.67.55.147]:42834 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:01:10 -0500
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jAJ9b-0007hU-10; Fri, 06 Mar 2020 15:01:03 -0500
Date:   Fri, 6 Mar 2020 15:01:02 -0500
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>,
        Qian Cai <cai@lca.pw>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH]  mm,page_alloc,cma: conditionally prefer cma pageblocks for
 movable allocations
Message-ID: <20200306150102.3e77354b@imladris.surriel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posting this one for Roman so I can deal with any upstream feedback and
create a v2 if needed, while scratching my head over the next piece of
this puzzle :)

---8<---

From: Roman Gushchin <guro@fb.com>

Currently a cma area is barely used by the page allocator because
it's used only as a fallback from movable, however kswapd tries
hard to make sure that the fallback path isn't used.

This results in a system evicting memory and pushing data into swap,
while lots of CMA memory is still available. This happens despite the
fact that alloc_contig_range is perfectly capable of moving any movable
allocations out of the way of an allocation.

To effectively use the cma area let's alter the rules: if the zone
has more free cma pages than the half of total free pages in the zone,
use cma pageblocks first and fallback to movable blocks in the case of
failure.

Signed-off-by: Rik van Riel <riel@surriel.com>
Co-developed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/page_alloc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..0fb3c1719625 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2711,6 +2711,18 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 {
 	struct page *page;
 
+	/*
+	 * Balance movable allocations between regular and CMA areas by
+	 * allocating from CMA when over half of the zone's free memory
+	 * is in the CMA area.
+	 */
+	if (migratetype == MIGRATE_MOVABLE &&
+	    zone_page_state(zone, NR_FREE_CMA_PAGES) >
+	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
+		page = __rmqueue_cma_fallback(zone, order);
+		if (page)
+			return page;
+	}
 retry:
 	page = __rmqueue_smallest(zone, order, migratetype);
 	if (unlikely(!page)) {
-- 
2.24.1


