Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E150C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1455020780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgF2XtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:49:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:23042 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgF2Xsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:48:40 -0400
IronPort-SDR: 8IxnQugQfyJDLeaYdmvHPfxO886dcwcP+cgIcVQ5zNcGCSRKdVU8ERzBfJI7LvE+nHgh76Zez1
 WwVzdg+MyIdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="207619657"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="207619657"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:48:40 -0700
IronPort-SDR: rCyOsg2HbthsYWqbWWTk+YsX5FV72qvaomAdJ0MvVZkfyMoI9ssBhKfhC6nn4RVe1WzlrUeLA0
 DLzER6PemvbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="480965753"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 16:48:39 -0700
Subject: [RFC][PATCH 7/8] mm/vmscan: never demote for memcg reclaim
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 29 Jun 2020 16:45:15 -0700
References: <20200629234503.749E5340@viggo.jf.intel.com>
In-Reply-To: <20200629234503.749E5340@viggo.jf.intel.com>
Message-Id: <20200629234515.B11A021E@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Global reclaim aims to reduce the amount of memory used on
a given node or set of nodes.  Migrating pages to another
node serves this purpose.

memcg reclaim is different.  Its goal is to reduce the
total memory consumption of the entire memcg, across all
nodes.  Migration does not assist memcg reclaim because
it just moves page contents between nodes rather than
actually reducing memory consumption.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/mm/vmscan.c |   61 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff -puN mm/vmscan.c~never-demote-for-memcg-reclaim mm/vmscan.c
--- a/mm/vmscan.c~never-demote-for-memcg-reclaim	2020-06-29 16:34:44.018312591 -0700
+++ b/mm/vmscan.c	2020-06-29 16:34:44.023312591 -0700
@@ -289,7 +289,8 @@ static bool writeback_throttling_sane(st
 #endif
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-					  int node_id)
+					  int node_id,
+					  struct scan_control *sc)
 {
 	/* Always age anon pages when we have swap */
 	if (memcg == NULL) {
@@ -300,8 +301,14 @@ static inline bool can_reclaim_anon_page
 			return true;
 	}
 
-	/* Also age anon pages if we can auto-migrate them */
-	if (next_demotion_node(node_id) >= 0)
+	/*
+	 * Also age anon pages if we can auto-migrate them.
+	 *
+	 * Migrating a page does not reduce comsumption of a
+	 * memcg so should not be performed when in memcg
+	 * reclaim.
+	 */
+	if ((sc && cgroup_reclaim(sc)) && (next_demotion_node(node_id) >= 0))
 		return true;
 
 	/* No way to reclaim anon pages */
@@ -319,7 +326,7 @@ unsigned long zone_reclaimable_pages(str
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -1084,6 +1091,32 @@ static void page_check_dirty_writeback(s
 		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
 }
 
+
+static int shrink_do_demote_mapping(struct page *page,
+				    struct list_head *page_list,
+				    struct scan_control *sc)
+{
+	int rc;
+
+	/* It is pointless to do demotion in memcg reclaim */
+	if (cgroup_reclaim(sc))
+		return -ENOTSUPP;
+
+	rc = migrate_demote_mapping(page);
+	/*
+	 * -ENOMEM on a THP may indicate either migration is
+	 * unsupported or there was not enough contiguous
+	 * space. Split the THP into base pages and retry the
+	 * head immediately. The tail pages will be considered
+	 * individually within the current loop's page list.
+	 */
+	if (rc == -ENOMEM && PageTransHuge(page) &&
+	    !split_huge_page_to_list(page, page_list))
+		rc = migrate_demote_mapping(page);
+
+	return rc;
+}
+
 /*
  * shrink_page_list() returns the number of reclaimed pages
  */
@@ -1251,17 +1284,7 @@ static unsigned long shrink_page_list(st
 			; /* try to reclaim the page below */
 		}
 
-		rc = migrate_demote_mapping(page);
-		/*
-		 * -ENOMEM on a THP may indicate either migration is
-		 * unsupported or there was not enough contiguous
-		 * space. Split the THP into base pages and retry the
-		 * head immediately. The tail pages will be considered
-		 * individually within the current loop's page list.
-		 */
-		if (rc == -ENOMEM && PageTransHuge(page) &&
-		    !split_huge_page_to_list(page, page_list))
-			rc = migrate_demote_mapping(page);
+		rc = shrink_do_demote_mapping(page, page_list, sc);
 
 		if (rc == MIGRATEPAGE_SUCCESS) {
 			unlock_page(page);
@@ -2287,7 +2310,7 @@ static void get_scan_count(struct lruvec
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2593,7 +2616,7 @@ static void shrink_lruvec(struct lruvec
 	 * rebalance the anon lru active/inactive ratio.
 	 */
 	if (can_reclaim_anon_pages(lruvec_memcg(lruvec),
-			       lruvec_pgdat(lruvec)->node_id) &&
+			       lruvec_pgdat(lruvec)->node_id, sc) &&
 	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
@@ -2664,7 +2687,7 @@ static inline bool should_continue_recla
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, pgdat->node_id))
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
@@ -3417,7 +3440,7 @@ static void age_active_anon(struct pglis
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	if (!can_reclaim_anon_pages(NULL, pgdat->node_id))
+	if (!can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		return;
 
 	lruvec = mem_cgroup_lruvec(NULL, pgdat);
_
