Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48901C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4222078D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgHRSsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:48:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:14585 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgHRSsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:48:14 -0400
IronPort-SDR: qckqU148Bc4unFFDP3ZHKMOPecISgffAWXYPj7GC5QVq21iDk7ZcVuTzsKCoxl6xtd7rRir8jj
 rMHfBGjghkLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135055388"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="135055388"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:48:13 -0700
IronPort-SDR: CFKzc41RqOknL9qNzcBrLCtWyBWi7cvyNLr5POQVD3AyW5HzfqBiIl7H/q5gDlyX5gvWYgfQQ1
 Zo9MzINiv2FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="279475967"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2020 11:48:13 -0700
Subject: [RFC][PATCH 7/9] mm/vmscan: Consider anonymous pages without swap
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, kbusch@kernel.org,
        vishal.l.verma@intel.com, yang.shi@linux.alibaba.com,
        rientjes@google.com, ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 18 Aug 2020 11:41:34 -0700
References: <20200818184122.29C415DF@viggo.jf.intel.com>
In-Reply-To: <20200818184122.29C415DF@viggo.jf.intel.com>
Message-Id: <20200818184134.C0C0E2E9@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Keith Busch <kbusch@kernel.org>

Age and reclaim anonymous pages if a migration path is available. The
node has other recourses for inactive anonymous pages beyond swap,

#Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Keith Busch <kbusch@kernel.org>
[vishal: fixup the migration->demotion rename]
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>

--

Changes from Dave 06/2020:
 * rename reclaim_anon_pages()->can_reclaim_anon_pages()

Note: Keith's Intel SoB is commented out because he is no
longer at Intel and his @intel.com mail will bouncee
---

 b/include/linux/node.h |    9 +++++++++
 b/mm/vmscan.c          |   33 ++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff -puN include/linux/node.h~0009-mm-vmscan-Consider-anonymous-pages-without-swap include/linux/node.h
--- a/include/linux/node.h~0009-mm-vmscan-Consider-anonymous-pages-without-swap	2020-08-18 11:36:55.284583173 -0700
+++ b/include/linux/node.h	2020-08-18 11:36:55.290583173 -0700
@@ -180,4 +180,13 @@ static inline void register_hugetlbfs_wi
 
 #define to_node(device) container_of(device, struct node, dev)
 
+#ifdef CONFIG_MIGRATION
+extern int next_demotion_node(int node);
+#else
+static inline int next_demotion_node(int node)
+{
+	return NUMA_NO_NODE;
+}
+#endif
+
 #endif /* _LINUX_NODE_H_ */
diff -puN mm/vmscan.c~0009-mm-vmscan-Consider-anonymous-pages-without-swap mm/vmscan.c
--- a/mm/vmscan.c~0009-mm-vmscan-Consider-anonymous-pages-without-swap	2020-08-18 11:36:55.286583173 -0700
+++ b/mm/vmscan.c	2020-08-18 11:36:55.292583173 -0700
@@ -295,6 +295,26 @@ static bool writeback_throttling_sane(st
 }
 #endif
 
+static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
+					  int node_id)
+{
+	/* Always age anon pages when we have swap */
+	if (memcg == NULL) {
+		if (get_nr_swap_pages() > 0)
+			return true;
+	} else {
+		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
+			return true;
+	}
+
+	/* Also age anon pages if we can auto-migrate them */
+	if (next_demotion_node(node_id) >= 0)
+		return true;
+
+	/* No way to reclaim anon pages */
+	return false;
+}
+
 /*
  * This misses isolated pages which are not accounted for to save counters.
  * As the data only determines if reclaim or compaction continues, it is
@@ -306,7 +326,7 @@ unsigned long zone_reclaimable_pages(str
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -2338,6 +2358,7 @@ enum scan_balance {
 static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			   unsigned long *nr)
 {
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
 	int swappiness = mem_cgroup_swappiness(memcg);
@@ -2348,7 +2369,7 @@ static void get_scan_count(struct lruvec
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2631,7 +2652,9 @@ static void shrink_lruvec(struct lruvec
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
+	if (can_reclaim_anon_pages(lruvec_memcg(lruvec),
+			       lruvec_pgdat(lruvec)->node_id) &&
+	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
@@ -2701,7 +2724,7 @@ static inline bool should_continue_recla
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
@@ -3462,7 +3485,7 @@ static void age_active_anon(struct pglis
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	if (!total_swap_pages)
+	if (!can_reclaim_anon_pages(NULL, pgdat->node_id))
 		return;
 
 	lruvec = mem_cgroup_lruvec(NULL, pgdat);
_
