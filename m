Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0591C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1D520757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/C66VSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbgDCFpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:45:32 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37831 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgDCFpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:45:32 -0400
Received: by mail-pj1-f66.google.com with SMTP id k3so2481703pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/N4HpzCWOAjScytagW8R+OVkkG6fFjWaa4WpbnJjAY=;
        b=T/C66VSa9ReAAcuf6M21GVdQylEnb+ylsvpRbxPAoyGRFA5aCJVpkWsbUVfahvexxy
         1AOoxK2+zlcoi6tr3L5dmopshSQLu5qzGyLAcP3jEAwYiZaNg/uYyIswkbtiQH+Ey7wI
         +5fUUTLh8hqs9n7+YwHSySDoC1A/nkGXbsnRiK/WkVld7kh6SNzh6eQtp8lsgIkZ/67L
         ZPBEVVPtA+Ne2ivUHyd4ju1XUntm55pTc7xOkt6tLAVv9+Ca4rdnt8elUkYHr9JaUP0n
         rAWRCcPzoFaRBXIxvvbTqR2mSG2hU2WrOGOjShRiaMTGF2b4ftS0Hk+QA7+Virj9boRh
         iUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/N4HpzCWOAjScytagW8R+OVkkG6fFjWaa4WpbnJjAY=;
        b=IMjqpi6bTqXS2nHdgkCgb09Ls5Uslu1SVG7QBUNFSTuRLey7g+g++WU75KuEDf/r5h
         d/KJeFzNqKEyuzN6ksBhhOnvPEuLM6guV9KzBsgw0TGwzCDgYtyZ7jNEMQSTSyjnR4d2
         w86ukJLgvWlMvosTfuSC40ZFmx1cizTUdjFagLVT+ESpHeCg4WqWrwiPPS1C80aiYKuf
         eE7+gDnQRsDxcCL/9bY7KHVVBdxDspCv/JKS37M6VvhOpW2kx82Sz/aZ3IIU4dJn9Xjt
         HxOe7/ziZoc5ky5AceW2vfLRcJ6k1JjJTHgR5JWtVeYhX8Q/xg1rOB/AByxSSMSa896Y
         wzvg==
X-Gm-Message-State: AGi0PuanrLWRehP3epPebROGaSaGVqt49rV+RkUYKBsYCKo0kXHgCrVL
        lEq8c+7g1bE0sEdHwbIDJng=
X-Google-Smtp-Source: APiQypKMFW0JwXgtEB/rsbLT2LanJVycbMlvhrvLkkx7vKpQppDPgYBX5zJ52TSL+puV/KE0LyfN4w==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr6253289plt.184.1585892729839;
        Thu, 02 Apr 2020 22:45:29 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y131sm5003365pfg.25.2020.04.02.22.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:45:29 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v5 10/10] mm/swap: reinforce the reclaim_stat changed by anon LRU algorithm change
Date:   Fri,  3 Apr 2020 14:45:10 +0900
Message-Id: <1585892710-3214-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

reclaim_stat's scanned/rotated is used for controlling the ratio of
scanning page between file and anonymous LRU. On the patch, protecting
anonymous pages on active LRU, LRU management algorithm for anonymous
page is changed. Due to this change, the reclaim_stat is affected and
it cause a regression on kernel build workload.

There are three cases that affect to the reclaim_stat.

First, before the patch, all new anonymous pages are counted for
rotated since they are attached to the active LRU. However, after the
patch, they are not counted since they are attached to the inactive LRU.

Second, before the patch, faulted-in once swapped page is activated and
then counted for rotated, but, it isn't now.

Lastly, reclaim checks the reference of the page and activates the page
when first reference found. Also, it is counted for rotated. However,
now, activation and counting needs two references found.

These affects reclaim_stat's scanned/rotated and more scanning for
anonymous LRU is observed due to it on kernel build workload. Then,
it leads to performance regression. Since there would be many system
that is optimized for previous file/anon scan ratio, it is better
to maintain previous scan ratio even if LRU management algorithm is
changed.

For this purpose, this patch counts reclaim_stat's rotated at the
previous counting places. Although it is non-logical to count the
reclaim_stat's rotate here in current algorithm, reducing
the regression would be more important.

I found this regression on kernel-build test and it is roughly 2~5%
performance degradation. With this workaround, performance is completely
restored.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/pagevec.h       |  2 +-
 include/linux/swap.h          |  1 +
 include/linux/vmstat.h        |  2 +-
 include/trace/events/vmscan.h |  3 +-
 mm/memory.c                   |  6 +++
 mm/mlock.c                    |  2 +-
 mm/swap.c                     | 89 ++++++++++++++++++++++++++++++++++++++-----
 mm/vmscan.c                   | 12 ++++--
 8 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934..7090c38 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -24,7 +24,7 @@ struct pagevec {
 };
 
 void __pagevec_release(struct pagevec *pvec);
-void __pagevec_lru_add(struct pagevec *pvec);
+void __pagevec_lru_add(struct pagevec *pvec, bool new_anon);
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 				struct address_space *mapping,
 				pgoff_t start, unsigned nr_entries,
diff --git a/include/linux/swap.h b/include/linux/swap.h
index d204cc7..1023d4a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -334,6 +334,7 @@ extern void lru_cache_add_anon(struct page *page);
 extern void lru_cache_add_file(struct page *page);
 extern void lru_add_page_tail(struct page *page, struct page *page_tail,
 			 struct lruvec *lruvec, struct list_head *head);
+extern void update_anon_page_reclaim_stat(struct page *page);
 extern void activate_page(struct page *);
 extern void mark_page_accessed(struct page *);
 extern void lru_add_drain(void);
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 292485f..104ea36 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -27,7 +27,7 @@ struct reclaim_stat {
 	unsigned nr_writeback;
 	unsigned nr_immediate;
 	unsigned nr_activate[2];
-	unsigned nr_ref_keep;
+	unsigned nr_ref_keep[2];
 	unsigned nr_unmap_fail;
 };
 
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a5ab297..b42825f 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -366,7 +366,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_immediate = stat->nr_immediate;
 		__entry->nr_activate0 = stat->nr_activate[0];
 		__entry->nr_activate1 = stat->nr_activate[1];
-		__entry->nr_ref_keep = stat->nr_ref_keep;
+		__entry->nr_ref_keep = stat->nr_ref_keep[0] +
+					stat->nr_ref_keep[1];
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
 		__entry->priority = priority;
 		__entry->reclaim_flags = trace_reclaim_flags(file);
diff --git a/mm/memory.c b/mm/memory.c
index 9effb23..fe30b02 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3099,6 +3099,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 		mem_cgroup_commit_charge(page, memcg, true, false);
+
+		/*
+		 * To reduce difference of the reclaim ratio caused by LRU
+		 * algorithm change, update reclaim_stat manually.
+		 */
+		update_anon_page_reclaim_stat(page);
 	}
 
 	if (shadow) {
diff --git a/mm/mlock.c b/mm/mlock.c
index a72c1ee..c70d0734 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -273,7 +273,7 @@ static void __putback_lru_fast(struct pagevec *pvec, int pgrescued)
 	 *__pagevec_lru_add() calls release_pages() so we don't call
 	 * put_page() explicitly
 	 */
-	__pagevec_lru_add(pvec);
+	__pagevec_lru_add(pvec, false);
 	count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index d9f2005..9dd1cb5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -45,6 +45,7 @@
 int page_cluster;
 
 static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
+static DEFINE_PER_CPU(struct pagevec, lru_add_new_anon_pvec);
 static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
@@ -272,6 +273,23 @@ static void update_page_reclaim_stat(struct lruvec *lruvec,
 		reclaim_stat->recent_rotated[file]++;
 }
 
+void update_anon_page_reclaim_stat(struct page *page)
+{
+	pg_data_t *pgdat;
+	struct lruvec *lruvec;
+	struct zone_reclaim_stat *reclaim_stat;
+
+	page = compound_head(page);
+	pgdat = page_pgdat(page);
+	spin_lock_irq(&pgdat->lru_lock);
+	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
+		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		reclaim_stat = &lruvec->reclaim_stat;
+		update_page_reclaim_stat(lruvec, 0, 1);
+	}
+	spin_unlock_irq(&pgdat->lru_lock);
+}
+
 static void __activate_page(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
@@ -333,9 +351,8 @@ void activate_page(struct page *page)
 }
 #endif
 
-static void __lru_cache_activate_page(struct page *page)
+static bool lookup_activate_page(struct pagevec *pvec, struct page *page)
 {
-	struct pagevec *pvec = &get_cpu_var(lru_add_pvec);
 	int i;
 
 	/*
@@ -352,12 +369,35 @@ static void __lru_cache_activate_page(struct page *page)
 		struct page *pagevec_page = pvec->pages[i];
 
 		if (pagevec_page == page) {
-			SetPageActive(page);
-			break;
+			return true;
 		}
 	}
+	return false;
+}
+
+static void __lru_cache_activate_page(struct page *page)
+{
+	struct pagevec *pvec;
+	bool ret;
 
+	pvec = &get_cpu_var(lru_add_pvec);
+	ret = lookup_activate_page(pvec, page);
 	put_cpu_var(lru_add_pvec);
+
+	if (ret) {
+		SetPageActive(page);
+		return;
+	}
+
+	if (!PageSwapBacked(page))
+		return;
+
+	pvec = &get_cpu_var(lru_add_new_anon_pvec);
+	ret = lookup_activate_page(pvec, page);
+	put_cpu_var(lru_add_new_anon_pvec);
+
+	if (ret)
+		SetPageActive(page);
 }
 
 /*
@@ -407,7 +447,17 @@ static void __lru_cache_add(struct page *page)
 
 	get_page(page);
 	if (!pagevec_add(pvec, page) || PageCompound(page))
-		__pagevec_lru_add(pvec);
+		__pagevec_lru_add(pvec, false);
+	put_cpu_var(lru_add_pvec);
+}
+
+static void __lru_cache_add_new_anon(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(lru_add_new_anon_pvec);
+
+	get_page(page);
+	if (!pagevec_add(pvec, page) || PageCompound(page))
+		__pagevec_lru_add(pvec, true);
 	put_cpu_var(lru_add_pvec);
 }
 
@@ -474,6 +524,11 @@ void lru_cache_add_inactive_or_unevictable(struct page *page,
 				    hpage_nr_pages(page));
 		count_vm_event(UNEVICTABLE_PGMLOCKED);
 	}
+
+	if (PageSwapBacked(page) && !unevictable) {
+		__lru_cache_add_new_anon(page);
+		return;
+	}
 	lru_cache_add(page);
 }
 
@@ -596,7 +651,11 @@ void lru_add_drain_cpu(int cpu)
 	struct pagevec *pvec = &per_cpu(lru_add_pvec, cpu);
 
 	if (pagevec_count(pvec))
-		__pagevec_lru_add(pvec);
+		__pagevec_lru_add(pvec, false);
+
+	pvec = &per_cpu(lru_add_new_anon_pvec, cpu);
+	if (pagevec_count(pvec))
+		__pagevec_lru_add(pvec, true);
 
 	pvec = &per_cpu(lru_rotate_pvecs, cpu);
 	if (pagevec_count(pvec)) {
@@ -744,6 +803,7 @@ void lru_add_drain_all(void)
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
 		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
+		    pagevec_count(&per_cpu(lru_add_new_anon_pvec, cpu)) ||
 		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
@@ -928,6 +988,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 {
 	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
+	bool new_anon = (bool)arg;
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
@@ -962,8 +1023,18 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 
 	if (page_evictable(page)) {
 		lru = page_lru(page);
+		/*
+		 * Count new_anon page for rotation due to performance reason.
+		 * Previous LRU management algorithm for anonymous page attaches
+		 * a new anonymous page to the active list and it is counted as
+		 * rotation. However, current one attaches a new anonymous page
+		 * to the inactive list so rotation isn't counted. This count
+		 * difference results in difference of file/anon reclaim ratio
+		 * and then performance regression. To workaround it, new_anon
+		 * is counted for rotation here.
+		 */
 		update_page_reclaim_stat(lruvec, page_is_file_cache(page),
-					 PageActive(page));
+					 PageActive(page) | new_anon);
 		if (was_unevictable)
 			count_vm_event(UNEVICTABLE_PGRESCUED);
 	} else {
@@ -982,9 +1053,9 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
  * Add the passed pages to the LRU, then drop the caller's refcount
  * on them.  Reinitialises the caller's pagevec.
  */
-void __pagevec_lru_add(struct pagevec *pvec)
+void __pagevec_lru_add(struct pagevec *pvec, bool new_anon)
 {
-	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, (void *)new_anon);
 }
 EXPORT_SYMBOL(__pagevec_lru_add);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c5d20c..45eede0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1088,11 +1088,13 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		enum page_references references = PAGEREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		int file;
 
 		cond_resched();
 
 		page = lru_to_page(page_list);
 		list_del(&page->lru);
+		file = page_is_file_cache(page);
 
 		if (!trylock_page(page))
 			goto keep;
@@ -1223,7 +1225,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		case PAGEREF_ACTIVATE:
 			goto activate_locked;
 		case PAGEREF_KEEP:
-			stat->nr_ref_keep += nr_pages;
+			stat->nr_ref_keep[file] += nr_pages;
 			goto keep_locked;
 		case PAGEREF_RECLAIM:
 		case PAGEREF_RECLAIM_CLEAN:
@@ -1316,7 +1318,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			 * the rest of the LRU for clean pages and see
 			 * the same dirty pages again (PageReclaim).
 			 */
-			if (page_is_file_cache(page) &&
+			if (file &&
 			    (!current_is_kswapd() || !PageReclaim(page) ||
 			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
 				/*
@@ -1460,9 +1462,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			try_to_free_swap(page);
 		VM_BUG_ON_PAGE(PageActive(page), page);
 		if (!PageMlocked(page)) {
-			int type = page_is_file_cache(page);
 			SetPageActive(page);
-			stat->nr_activate[type] += nr_pages;
+			stat->nr_activate[file] += nr_pages;
 			count_memcg_page_event(page, PGACTIVATE);
 			workingset_activation(page);
 		}
@@ -1955,6 +1956,9 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
 	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
 
+	/* to mitigate impact on scan ratio due to LRU algorithm change */
+	reclaim_stat->recent_rotated[0] += stat.nr_ref_keep[0];
+
 	move_pages_to_lru(lruvec, &page_list);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-- 
2.7.4

