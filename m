Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D3C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE892089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="jb+DE776"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgETX0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgETX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CCDC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:17 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c24so4078745qtw.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdQ80xB6Sy/rgHokK0g8aS6vKa88in/XYXLkOFHRciw=;
        b=jb+DE776l/fyNxlCw/JBI42y3UT/XNmb/p3gRaRWiZqQ5FyHxhCQ/vBiaUOO2VQ2fY
         Y0a7fZNRsgF5KVEvf4Q69PO2/duToOYwm4yZ1PGocFY1ceo4s0necEwOH/quwvnGhnIq
         aA8q6JP7sv/8yR1o8kLmioTB3hhVUxNa4+ui4/qPtiS1tWfdZsrQdeLFe01oM+WxrBw4
         GElDns84HC4jqVoG+fhY4Imj6Z4N/IdpI787FPyDiQJVVvJTe1zmVh1EzSdcsGk6Jr9Q
         5QV4/lE4N89Q/ptxpSRIF9GEhDPfA2b2Jef0Q3GY7eBBUOIX7ko4fqKo62C3bDtjL9rj
         hXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdQ80xB6Sy/rgHokK0g8aS6vKa88in/XYXLkOFHRciw=;
        b=He1wZZ8ltGe5S22WWpYawNFlHvD2Xtctul5BxGh4svxl+/KHJKTDftd7+guBGguMFc
         ivhuJ4dyD7CzmAyv/mDDcL/oDyxEwa6jI6vT2chwCdaaISj1L1poPAvCnvZo7CliKfzh
         N5gNX+16KDGczr4xGzR+Yrazj7GPmXYLaut1sTfPAirD+/oeqiqzBn04+Q2WTvNEeYYf
         iA1oQHgDBJYDoUA6gFj5EIjPvLgYgmtshdtQgesT9kAKmGU/GRjHtASvnzMFfyw6f5Zj
         H3i18h4bqqE/1CHwCChY1DHO1b/wGDAdwhEp/0ZC+4QBmkA91b/iRjxqh8FKvYHwhVIG
         JUoA==
X-Gm-Message-State: AOAM531F8m0XJd25284gjVDEiC1QxpoqoTjLO0FtlMB9JD4xfODDLDYa
        F6MK2RgqGixLi9tqIT7+14B/5A==
X-Google-Smtp-Source: ABdhPJyxwfsHIlUpPMQ1Jzk7Pe13S07SClFnhyqM3GLDO8dPNWkEqRjEquSRuwmK5MchEuMc6VTH2Q==
X-Received: by 2002:aed:35a1:: with SMTP id c30mr8075822qte.228.1590017176929;
        Wed, 20 May 2020 16:26:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id o18sm3869649qtb.7.2020.05.20.16.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:16 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/14] mm: balance LRU lists based on relative thrashing
Date:   Wed, 20 May 2020 19:25:22 -0400
Message-Id: <20200520232525.798933-12-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the LRUs were split into anon and file lists, the VM has been
balancing between page cache and anonymous pages based on per-list
ratios of scanned vs. rotated pages. In most cases that tips page
reclaim towards the list that is easier to reclaim and has the fewest
actively used pages, but there are a few problems with it:

1. Refaults and LRU rotations are weighted the same way, even though
   one costs IO and the other costs a bit of CPU.

2. The less we scan an LRU list based on already observed rotations,
   the more we increase the sampling interval for new references, and
   rotations become even more likely on that list. This can enter a
   death spiral in which we stop looking at one list completely until
   the other one is all but annihilated by page reclaim.

Since commit a528910e12ec ("mm: thrash detection-based file cache
sizing") we have refault detection for the page cache. Along with
swapin events, they are good indicators of when the file or anon list,
respectively, is too small for its workingset and needs to grow.

For example, if the page cache is thrashing, the cache pages need more
time in memory, while there may be colder pages on the anonymous list.
Likewise, if swapped pages are faulting back in, it indicates that we
reclaim anonymous pages too aggressively and should back off.

Replace LRU rotations with refaults and swapins as the basis for
relative reclaim cost of the two LRUs. This will have the VM target
list balances that incur the least amount of IO on aggregate.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/swap.h |  3 +--
 mm/swap.c            | 11 +++++++----
 mm/swap_state.c      |  5 +++++
 mm/vmscan.c          | 39 ++++++++++-----------------------------
 mm/workingset.c      |  4 ++++
 5 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5ace6d8a33bd..818a94b41d82 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -333,8 +333,7 @@ extern unsigned long nr_free_pagecache_pages(void);
 
 
 /* linux/mm/swap.c */
-extern void lru_note_cost(struct lruvec *lruvec, bool file,
-			  unsigned int nr_pages);
+extern void lru_note_cost(struct page *);
 extern void lru_cache_add(struct page *);
 extern void lru_add_page_tail(struct page *page, struct page *page_tail,
 			 struct lruvec *lruvec, struct list_head *head);
diff --git a/mm/swap.c b/mm/swap.c
index d7912bfb597f..2ff91656dea2 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -262,12 +262,15 @@ void rotate_reclaimable_page(struct page *page)
 	}
 }
 
-void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
+void lru_note_cost(struct page *page)
 {
-	if (file)
-		lruvec->file_cost += nr_pages;
+	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+
+	/* Record new data point */
+	if (page_is_file_lru(page))
+		lruvec->file_cost++;
 	else
-		lruvec->anon_cost += nr_pages;
+		lruvec->anon_cost++;
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b5e08ff00e1e..8b902897a867 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -430,6 +430,11 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL))
 		goto fail_delete;
 
+	/* XXX: Move to lru_cache_add() when it supports new vs putback */
+	spin_lock_irq(&page_pgdat(page)->lru_lock);
+	lru_note_cost(page);
+	spin_unlock_irq(&page_pgdat(page)->lru_lock);
+
 	/* Initiate read into locked page */
 	SetPageWorkingset(page);
 	lru_cache_add(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2c3fb8dd1159..e7e6868bcbf7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1958,12 +1958,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	move_pages_to_lru(lruvec, &page_list);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	/*
-	 * Rotating pages costs CPU without actually
-	 * progressing toward the reclaim goal.
-	 */
-	lru_note_cost(lruvec, 0, stat.nr_activate[0]);
-	lru_note_cost(lruvec, 1, stat.nr_activate[1]);
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
@@ -2079,11 +2073,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	 * Move pages back to the lru list.
 	 */
 	spin_lock_irq(&pgdat->lru_lock);
-	/*
-	 * Rotating pages costs CPU without actually
-	 * progressing toward the reclaim goal.
-	 */
-	lru_note_cost(lruvec, file, nr_rotated);
 
 	nr_activate = move_pages_to_lru(lruvec, &l_active);
 	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
@@ -2298,22 +2287,23 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	scan_balance = SCAN_FRACT;
 
 	/*
-	 * With swappiness at 100, anonymous and file have the same priority.
-	 * This scanning priority is essentially the inverse of IO cost.
+	 * Calculate the pressure balance between anon and file pages.
+	 *
+	 * The amount of pressure we put on each LRU is inversely
+	 * proportional to the cost of reclaiming each list, as
+	 * determined by the share of pages that are refaulting, times
+	 * the relative IO cost of bringing back a swapped out
+	 * anonymous page vs reloading a filesystem page (swappiness).
+	 *
+	 * With swappiness at 100, anon and file have equal IO cost.
 	 */
 	anon_prio = swappiness;
 	file_prio = 200 - anon_prio;
 
 	/*
-	 * OK, so we have swap space and a fair amount of page cache
-	 * pages.  We use the recently rotated / recently scanned
-	 * ratios to determine how valuable each cache is.
-	 *
 	 * Because workloads change over time (and to avoid overflow)
 	 * we keep these statistics as a floating average, which ends
-	 * up weighing recent references more than old ones.
-	 *
-	 * anon in [0], file in [1]
+	 * up weighing recent refaults more than old ones.
 	 */
 
 	anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES) +
@@ -2328,15 +2318,6 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		lruvec->file_cost /= 2;
 		totalcost /= 2;
 	}
-
-	/*
-	 * The amount of pressure on anon vs file pages is inversely
-	 * proportional to the assumed cost of reclaiming each list,
-	 * as determined by the share of pages that are likely going
-	 * to refault or rotate on each list (recently referenced),
-	 * times the relative IO cost of bringing back a swapped out
-	 * anonymous page vs reloading a filesystem page (swappiness).
-	 */
 	ap = anon_prio * (totalcost + 1);
 	ap /= lruvec->anon_cost + 1;
 
diff --git a/mm/workingset.c b/mm/workingset.c
index e69865739539..a6a2a740ed0b 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -365,6 +365,10 @@ void workingset_refault(struct page *page, void *shadow)
 	/* Page was active prior to eviction */
 	if (workingset) {
 		SetPageWorkingset(page);
+		/* XXX: Move to lru_cache_add() when it supports new vs putback */
+		spin_lock_irq(&page_pgdat(page)->lru_lock);
+		lru_note_cost(page);
+		spin_unlock_irq(&page_pgdat(page)->lru_lock);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
 	}
 out:
-- 
2.26.2

