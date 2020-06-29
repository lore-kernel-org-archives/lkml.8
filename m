Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7657DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFE320780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgF2Xsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:48:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:21990 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgF2Xsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:48:41 -0400
IronPort-SDR: h+2MZG9WJiNYYh0AnKudOwUvq/KX2paBzCYFtCdoQ3txuKVK2C1wgRJUULEaeEelCGQT+z9yXf
 WZIkJpp4926w==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="146090786"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="146090786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:48:38 -0700
IronPort-SDR: /t+O+/a6MlfHp1Yhr63Ua5EIAvxtCgHMVPfSkKC9m/M6gZKNX+1/r3YK55jrVWUvxVE2tUMyxg
 h20fXVfiF8/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="266329045"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2020 16:48:37 -0700
Subject: [RFC][PATCH 6/8] mm/vmscan: Consider anonymous pages without swap
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        kbusch@kernel.org, vishal.l.verma@intel.com,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 29 Jun 2020 16:45:14 -0700
References: <20200629234503.749E5340@viggo.jf.intel.com>
In-Reply-To: <20200629234503.749E5340@viggo.jf.intel.com>
Message-Id: <20200629234514.CE5BA063@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Keith Busch <keith.busch@intel.com>

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

---

 b/include/linux/node.h |    9 +++++++++
 b/mm/vmscan.c          |   32 +++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff -puN include/linux/node.h~0009-mm-vmscan-Consider-anonymous-pages-without-swap include/linux/node.h
--- a/include/linux/node.h~0009-mm-vmscan-Consider-anonymous-pages-without-swap	2020-06-29 16:34:42.861312594 -0700
+++ b/include/linux/node.h	2020-06-29 16:34:42.867312594 -0700
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
--- a/mm/vmscan.c~0009-mm-vmscan-Consider-anonymous-pages-without-swap	2020-06-29 16:34:42.863312594 -0700
+++ b/mm/vmscan.c	2020-06-29 16:34:42.868312594 -0700
@@ -288,6 +288,26 @@ static bool writeback_throttling_sane(st
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
@@ -299,7 +319,7 @@ unsigned long zone_reclaimable_pages(str
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -2267,7 +2287,7 @@ static void get_scan_count(struct lruvec
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2572,7 +2592,9 @@ static void shrink_lruvec(struct lruvec
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
@@ -2642,7 +2664,7 @@ static inline bool should_continue_recla
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
@@ -3395,7 +3417,7 @@ static void age_active_anon(struct pglis
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	if (!total_swap_pages)
+	if (!can_reclaim_anon_pages(NULL, pgdat->node_id))
 		return;
 
 	lruvec = mem_cgroup_lruvec(NULL, pgdat);
_
