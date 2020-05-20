Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91FC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE5120899
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="hp4okOv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgETX0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgETX0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17853C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so5450902qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkkZFxGQtrhNG1PgEmdhJKjLbxi3YgXFndmhvMvqYPA=;
        b=hp4okOv4daPRreoCjYfITe0+iUReKpLCO9iyhpD3ButmC+bwcqlyAV7n5gwd9lP3+v
         XsJD22sp4pK+D85AJiTQ3GEDuy/5R3iI+5fVpVRryXDZl0DevboUf9O2tc4nP3P5JF9H
         7rJ0FlSVRxn/eo+JJtLOlBusyBrWnjYfcDPewhHycXcKLx+2k/zF8S9EK3r3rQwJzhdj
         wtbjaEYUmlwtVv2KEJIpPPfjdIyp7CdJx1aKSJw5X6a813793jCv7RUGWaP7GYU8QqaK
         LyO7RbGbdjK1kCFNJvh9TcQ3wcFVD/GKGgNvCAjzObX+slL9kg7oNNVAcjVSho85brD2
         8k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkkZFxGQtrhNG1PgEmdhJKjLbxi3YgXFndmhvMvqYPA=;
        b=SKDVQ2GCQ1dO1f4IxAltioz9e3sfvyyE48j7BxG1kR5AxCDczFYYuxmgQa22csB7zI
         8rZkgc1PutCIVOtHZVCGZs400Lw1jQLs0uH+iURu3Y1MtrcrYOn8a210x98aZxsi9KVH
         5ghRqTRBIAErUWdxexwYMl3pUGhHxyn047lG+3OO1UwcZvtyXCedujJpeR6PnQB5E3lr
         SCKwkp9BvKdNy4KY7K7Qn+Fi38Y2CRJM6SSWfdvlketbo20bKtskPgPzVBl42dPbSf//
         zyH1KLTEFIgcRYWw1V9LXsqd68lHO901+UkX0LKFdzZLA5XpdfM5BNLRjotvVAwO8Dj2
         LAZg==
X-Gm-Message-State: AOAM532lKpV6rtskCdSESJvqHXddXnlUWv6Db8bjstMosA2iPic/2iXZ
        jg++FdDNjxrqGJ4FwEQfsCHo6w==
X-Google-Smtp-Source: ABdhPJwZc53QAG9TAKYABqAnp0YJ74dnlPkNRmmm5h7nXgJbpaqqzzcAsZiZQXedAqpzltfNzwczdg==
X-Received: by 2002:a37:d245:: with SMTP id f66mr6480773qkj.452.1590017172223;
        Wed, 20 May 2020 16:26:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id n35sm3624325qte.55.2020.05.20.16.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:11 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/14] mm: base LRU balancing on an explicit cost model
Date:   Wed, 20 May 2020 19:25:19 -0400
Message-Id: <20200520232525.798933-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, scan pressure between the anon and file LRU lists is
balanced based on a mixture of reclaim efficiency and a somewhat vague
notion of "value" of having certain pages in memory over others. That
concept of value is problematic, because it has caused us to count any
event that remotely makes one LRU list more or less preferrable for
reclaim, even when these events are not directly comparable and impose
very different costs on the system. One example is referenced file
pages that we still deactivate and referenced anonymous pages that we
actually rotate back to the head of the list.

There is also conceptual overlap with the LRU algorithm itself. By
rotating recently used pages instead of reclaiming them, the algorithm
already biases the applied scan pressure based on page value. Thus,
when rebalancing scan pressure due to rotations, we should think of
reclaim cost, and leave assessing the page value to the LRU algorithm.

Lastly, considering both value-increasing as well as value-decreasing
events can sometimes cause the same type of event to be counted twice,
i.e. how rotating a page increases the LRU value, while reclaiming it
succesfully decreases the value. In itself this will balance out fine,
but it quietly skews the impact of events that are only recorded once.

The abstract metric of "value", the murky relationship with the LRU
algorithm, and accounting both negative and positive events make the
current pressure balancing model hard to reason about and modify.

This patch switches to a balancing model of accounting the concrete,
actually observed cost of reclaiming one LRU over another. For now,
that cost includes pages that are scanned but rotated back to the list
head. Subsequent patches will add consideration for IO caused by
refaulting of recently evicted pages.

Replace struct zone_reclaim_stat with two cost counters in the lruvec,
and make everything that affects cost go through a new lru_note_cost()
function.

v2: remove superfluous cost denominator (Minchan Kim)
    improve cost variable naming (Michal Hocko)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/mmzone.h | 21 +++++++-------------
 include/linux/swap.h   |  2 ++
 mm/memcontrol.c        | 18 ++++++-----------
 mm/swap.c              | 19 ++++++++----------
 mm/vmscan.c            | 44 +++++++++++++++++++++---------------------
 5 files changed, 45 insertions(+), 59 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c1fbda9ddd1f..e959602140b4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -240,19 +240,6 @@ static inline bool is_active_lru(enum lru_list lru)
 	return (lru == LRU_ACTIVE_ANON || lru == LRU_ACTIVE_FILE);
 }
 
-struct zone_reclaim_stat {
-	/*
-	 * The pageout code in vmscan.c keeps track of how many of the
-	 * mem/swap backed and file backed pages are referenced.
-	 * The higher the rotated/scanned ratio, the more valuable
-	 * that cache is.
-	 *
-	 * The anon LRU stats live in [0], file LRU stats in [1]
-	 */
-	unsigned long		recent_rotated[2];
-	unsigned long		recent_scanned[2];
-};
-
 enum lruvec_flags {
 	LRUVEC_CONGESTED,		/* lruvec has many dirty pages
 					 * backed by a congested BDI
@@ -261,7 +248,13 @@ enum lruvec_flags {
 
 struct lruvec {
 	struct list_head		lists[NR_LRU_LISTS];
-	struct zone_reclaim_stat	reclaim_stat;
+	/*
+	 * These track the cost of reclaiming one LRU - file or anon -
+	 * over the other. As the observed cost of reclaiming one LRU
+	 * increases, the reclaim scan balance tips toward the other.
+	 */
+	unsigned long			anon_cost;
+	unsigned long			file_cost;
 	/* Evictions & activations on the inactive file list */
 	atomic_long_t			inactive_age;
 	/* Refaults at the time of last reclaim cycle */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 30fd4641890e..5ace6d8a33bd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -333,6 +333,8 @@ extern unsigned long nr_free_pagecache_pages(void);
 
 
 /* linux/mm/swap.c */
+extern void lru_note_cost(struct lruvec *lruvec, bool file,
+			  unsigned int nr_pages);
 extern void lru_cache_add(struct page *);
 extern void lru_add_page_tail(struct page *page, struct page *page_tail,
 			 struct lruvec *lruvec, struct list_head *head);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fe4f4d96ae3e..3e000a316b59 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3790,23 +3790,17 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 	{
 		pg_data_t *pgdat;
 		struct mem_cgroup_per_node *mz;
-		struct zone_reclaim_stat *rstat;
-		unsigned long recent_rotated[2] = {0, 0};
-		unsigned long recent_scanned[2] = {0, 0};
+		unsigned long anon_cost = 0;
+		unsigned long file_cost = 0;
 
 		for_each_online_pgdat(pgdat) {
 			mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
-			rstat = &mz->lruvec.reclaim_stat;
 
-			recent_rotated[0] += rstat->recent_rotated[0];
-			recent_rotated[1] += rstat->recent_rotated[1];
-			recent_scanned[0] += rstat->recent_scanned[0];
-			recent_scanned[1] += rstat->recent_scanned[1];
+			anon_cost += mz->lruvec.anon_cost;
+			file_cost += mz->lruvec.file_cost;
 		}
-		seq_printf(m, "recent_rotated_anon %lu\n", recent_rotated[0]);
-		seq_printf(m, "recent_rotated_file %lu\n", recent_rotated[1]);
-		seq_printf(m, "recent_scanned_anon %lu\n", recent_scanned[0]);
-		seq_printf(m, "recent_scanned_file %lu\n", recent_scanned[1]);
+		seq_printf(m, "anon_cost %lu\n", anon_cost);
+		seq_printf(m, "file_cost %lu\n", file_cost);
 	}
 #endif
 
diff --git a/mm/swap.c b/mm/swap.c
index 3b8c81bc93cd..5d62c5a0c651 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -262,15 +262,12 @@ void rotate_reclaimable_page(struct page *page)
 	}
 }
 
-static void update_page_reclaim_stat(struct lruvec *lruvec,
-				     int file, int rotated,
-				     unsigned int nr_pages)
+void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 {
-	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
-
-	reclaim_stat->recent_scanned[file] += nr_pages;
-	if (rotated)
-		reclaim_stat->recent_rotated[file] += nr_pages;
+	if (file)
+		lruvec->file_cost += nr_pages;
+	else
+		lruvec->anon_cost += nr_pages;
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec,
@@ -518,7 +515,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 
 	if (active)
 		__count_vm_event(PGDEACTIVATE);
-	update_page_reclaim_stat(lruvec, file, 0, hpage_nr_pages(page));
+	lru_note_cost(lruvec, !file, hpage_nr_pages(page));
 }
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
@@ -534,7 +531,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 		add_page_to_lru_list(page, lruvec, lru);
 
 		__count_vm_events(PGDEACTIVATE, hpage_nr_pages(page));
-		update_page_reclaim_stat(lruvec, file, 0, hpage_nr_pages(page));
+		lru_note_cost(lruvec, !file, hpage_nr_pages(page));
 	}
 }
 
@@ -559,7 +556,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGLAZYFREE, hpage_nr_pages(page));
 		count_memcg_page_event(page, PGLAZYFREE);
-		update_page_reclaim_stat(lruvec, 1, 0, hpage_nr_pages(page));
+		lru_note_cost(lruvec, 0, hpage_nr_pages(page));
 	}
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6cd1029ea9d4..6ff63906a288 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1916,7 +1916,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	bool file = is_file_lru(lru);
 	enum vm_event_item item;
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
-	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 	bool stalled = false;
 
 	while (unlikely(too_many_isolated(pgdat, file, sc))) {
@@ -1940,7 +1939,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 				     &nr_scanned, sc, lru);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
-	reclaim_stat->recent_scanned[file] += nr_taken;
 	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
@@ -1960,8 +1958,12 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	move_pages_to_lru(lruvec, &page_list);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
-	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
+	/*
+	 * Rotating pages costs CPU without actually
+	 * progressing toward the reclaim goal.
+	 */
+	lru_note_cost(lruvec, 0, stat.nr_activate[0]);
+	lru_note_cost(lruvec, 1, stat.nr_activate[1]);
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
@@ -2013,7 +2015,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	LIST_HEAD(l_active);
 	LIST_HEAD(l_inactive);
 	struct page *page;
-	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 	unsigned nr_deactivate, nr_activate;
 	unsigned nr_rotated = 0;
 	int file = is_file_lru(lru);
@@ -2027,7 +2028,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
 				     &nr_scanned, sc, lru);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
-	reclaim_stat->recent_scanned[file] += nr_taken;
 
 	__count_vm_events(PGREFILL, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
@@ -2085,7 +2085,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	 * helps balance scan pressure between file and anonymous pages in
 	 * get_scan_count.
 	 */
-	reclaim_stat->recent_rotated[file] += nr_rotated;
+	lru_note_cost(lruvec, file, nr_rotated);
 
 	nr_activate = move_pages_to_lru(lruvec, &l_active);
 	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
@@ -2242,13 +2242,13 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 {
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	int swappiness = mem_cgroup_swappiness(memcg);
-	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 	u64 fraction[2];
 	u64 denominator = 0;	/* gcc */
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	unsigned long anon_prio, file_prio;
 	enum scan_balance scan_balance;
 	unsigned long anon, file;
+	unsigned long totalcost;
 	unsigned long ap, fp;
 	enum lru_list lru;
 
@@ -2324,26 +2324,26 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
 
 	spin_lock_irq(&pgdat->lru_lock);
-	if (unlikely(reclaim_stat->recent_scanned[0] > anon / 4)) {
-		reclaim_stat->recent_scanned[0] /= 2;
-		reclaim_stat->recent_rotated[0] /= 2;
-	}
-
-	if (unlikely(reclaim_stat->recent_scanned[1] > file / 4)) {
-		reclaim_stat->recent_scanned[1] /= 2;
-		reclaim_stat->recent_rotated[1] /= 2;
+	totalcost = lruvec->anon_cost + lruvec->file_cost;
+	if (unlikely(totalcost > (anon + file) / 4)) {
+		lruvec->anon_cost /= 2;
+		lruvec->file_cost /= 2;
+		totalcost /= 2;
 	}
 
 	/*
 	 * The amount of pressure on anon vs file pages is inversely
-	 * proportional to the fraction of recently scanned pages on
-	 * each list that were recently referenced and in active use.
+	 * proportional to the assumed cost of reclaiming each list,
+	 * as determined by the share of pages that are likely going
+	 * to refault or rotate on each list (recently referenced),
+	 * times the relative IO cost of bringing back a swapped out
+	 * anonymous page vs reloading a filesystem page (swappiness).
 	 */
-	ap = anon_prio * (reclaim_stat->recent_scanned[0] + 1);
-	ap /= reclaim_stat->recent_rotated[0] + 1;
+	ap = anon_prio * (totalcost + 1);
+	ap /= lruvec->anon_cost + 1;
 
-	fp = file_prio * (reclaim_stat->recent_scanned[1] + 1);
-	fp /= reclaim_stat->recent_rotated[1] + 1;
+	fp = file_prio * (totalcost + 1);
+	fp /= lruvec->file_cost + 1;
 	spin_unlock_irq(&pgdat->lru_lock);
 
 	fraction[0] = ap;
-- 
2.26.2

