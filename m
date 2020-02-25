Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C748C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740EA218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgBYOPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:15:42 -0500
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:36838 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729411AbgBYOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:15:38 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 6B8ADC0ACD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:15:36 +0000 (GMT)
Received: (qmail 1897 invoked from network); 25 Feb 2020 14:15:36 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 25 Feb 2020 14:15:36 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Ivan Babrou <ivan@cloudflare.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/3] mm, page_alloc: Disable boosted watermark based reclaim on low-memory systems
Date:   Tue, 25 Feb 2020 14:15:32 +0000
Message-Id: <20200225141534.5044-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200225141534.5044-1-mgorman@techsingularity.net>
References: <20200225141534.5044-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An off-list bug report indicated that watermark boosting was affecting a
very small memory system and causing excessive reclaim. Watermark boosting
is intended to reduce the mixing of page mobility types within pageblocks
for high-order allocations. If the system has so little memory that pages
are not even grouped by mobility, then watermark boosting should also
be disabled.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h   | 6 +++++-
 mm/page_alloc.c | 6 ++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..439561cc90d9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -534,10 +534,14 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_KSWAPD		0x200 /* allow waking of kswapd */
 
+static inline void disable_watermark_boosting(void)
+{
+	watermark_boost_factor = 0;
+}
+
 enum ttu_flags;
 struct tlbflush_unmap_batch;
 
-
 /*
  * only for MM internal work items which do not depend on
  * any allocations or locks which might depend on allocations
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..c5c05b6dc459 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5810,10 +5810,12 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 	 * made on memory-hotadd so a system can start with mobility
 	 * disabled and enable it later
 	 */
-	if (vm_total_pages < (pageblock_nr_pages * MIGRATE_TYPES))
+	if (vm_total_pages < (pageblock_nr_pages * MIGRATE_TYPES)) {
 		page_group_by_mobility_disabled = 1;
-	else
+		disable_watermark_boosting();
+	} else {
 		page_group_by_mobility_disabled = 0;
+	}
 
 	pr_info("Built %u zonelists, mobility grouping %s.  Total pages: %ld\n",
 		nr_online_nodes,
-- 
2.16.4

