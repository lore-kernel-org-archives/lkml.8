Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C76C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5B420714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZj9lyZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGWHty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWHtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:49:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4518AC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s189so2658660pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x/km7mgDbJXIYaMWCyJ3YkoTJJc8gYFxyZlip+EPAcI=;
        b=VZj9lyZJphVJvmiWmMbxbSbRxIBQTdhWuwF2+Gt4QuWV+HVnZAg6CG25f5qkTIT0EM
         /vzTGj1n51ZceEemZz2rcJBss9HEios9DGkGrpE5q2fFZlBedYXqluFggQP3CEZIc0Zm
         4md1wtlEKkweHkRRUWEHUEMQcApGrF+jRyJyHKZ5qTDwfJosxGZ5dynUH476wmYv46mF
         KeE9vSHSy+Iti9SXAXTtwgQZDSMWcZvGyK4ZJr/NIxnv5XSi0Qgi/MkCsZ883/5XQCEK
         mBjEofY5IzVWvaHhkYJEqVItOWqDg59cKlQyRqL/NRqiylWFKEFAaxlh7wqhtj5UBThd
         B6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x/km7mgDbJXIYaMWCyJ3YkoTJJc8gYFxyZlip+EPAcI=;
        b=XTRaAb2+MbTAvNmrqhLZIyOCScYys5CQE/b+VcHIwf7z+ATe3aWhkSZ/4WVQ3lBcQz
         pVM7kpD5EybxkuIdGGA3ocqGYaju2L3i/uhojweDegG81jzPVmJWCM+FjjKcqqzJPsYk
         A0hnn/VssxlOMdkaY73oRUZD3aLs/NaXD0MWm7eR+9HWm1AbCcZGrAxp864nPErVnrIc
         oNhOMXMwUT/GuK+F4WBGKU5vca9nGudRBsbvCxFHpqYdHVgBzqDfnDDBswZkwbWCo+bc
         1bD5htyTuCkb2T+1zf1oI6bqXdj4Lzliy4G6z/0NyF6UJO9btpEgL+DRL1qDDs+wOZIU
         BevQ==
X-Gm-Message-State: AOAM530C0/dJEdiL5iTXsz3y/E2kK9Lsn6iQi8vHMITkVApfPBg5i1rV
        uyzeUOpGuT5XbJFgal3RNZs=
X-Google-Smtp-Source: ABdhPJx3qGLhzpu9c9r6KiQh3xC+l6KbpPMe54G3ggrDKw3Iq5RDFibido+r9b9gzhVw8dqdwHsI7Q==
X-Received: by 2002:a65:63d4:: with SMTP id n20mr3270504pgv.213.1595490592760;
        Thu, 23 Jul 2020 00:49:52 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id f71sm9164879pje.0.2020.07.23.00.49.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:49:51 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v7 4/6] mm/swapcache: support to handle the shadow entries
Date:   Thu, 23 Jul 2020 16:49:18 +0900
Message-Id: <1595490560-15117-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Workingset detection for anonymous page will be implemented in the
following patch and it requires to store the shadow entries into the
swapcache. This patch implements an infrastructure to store the shadow
entry in the swapcache.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h | 17 ++++++++++++----
 mm/shmem.c           |  3 ++-
 mm/swap_state.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++++------
 mm/swapfile.c        |  2 ++
 mm/vmscan.c          |  2 +-
 5 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 51ec9cd..8a4c592 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -414,9 +414,13 @@ extern struct address_space *swapper_spaces[];
 extern unsigned long total_swapcache_pages(void);
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
-extern int add_to_swap_cache(struct page *, swp_entry_t, gfp_t);
-extern void __delete_from_swap_cache(struct page *, swp_entry_t entry);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
+			gfp_t gfp, void **shadowp);
+extern void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow);
 extern void delete_from_swap_cache(struct page *);
+extern void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				unsigned long end);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
 extern struct page *lookup_swap_cache(swp_entry_t entry,
@@ -570,13 +574,13 @@ static inline int add_to_swap(struct page *page)
 }
 
 static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
-							gfp_t gfp_mask)
+					gfp_t gfp_mask, void **shadowp)
 {
 	return -1;
 }
 
 static inline void __delete_from_swap_cache(struct page *page,
-							swp_entry_t entry)
+					swp_entry_t entry, void *shadow)
 {
 }
 
@@ -584,6 +588,11 @@ static inline void delete_from_swap_cache(struct page *page)
 {
 }
 
+static inline void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				unsigned long end)
+{
+}
+
 static inline int page_swapcount(struct page *page)
 {
 	return 0;
diff --git a/mm/shmem.c b/mm/shmem.c
index 89b357a..85ed46f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1434,7 +1434,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		list_add(&info->swaplist, &shmem_swaplist);
 
 	if (add_to_swap_cache(page, swap,
-			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN) == 0) {
+			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
+			NULL) == 0) {
 		spin_lock_irq(&info->lock);
 		shmem_recalc_inode(inode);
 		info->swapped++;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 66e750f..13d8d66 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -110,12 +110,14 @@ void show_swap_cache_info(void)
  * add_to_swap_cache resembles add_to_page_cache_locked on swapper_space,
  * but sets SwapCache flag and private instead of mapping and index.
  */
-int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
+int add_to_swap_cache(struct page *page, swp_entry_t entry,
+			gfp_t gfp, void **shadowp)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE_ORDER(xas, &address_space->i_pages, idx, compound_order(page));
 	unsigned long i, nr = thp_nr_pages(page);
+	void *old;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
@@ -125,16 +127,25 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 	SetPageSwapCache(page);
 
 	do {
+		unsigned long nr_shadows = 0;
+
 		xas_lock_irq(&xas);
 		xas_create_range(&xas);
 		if (xas_error(&xas))
 			goto unlock;
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
+			old = xas_load(&xas);
+			if (xa_is_value(old)) {
+				nr_shadows++;
+				if (shadowp)
+					*shadowp = old;
+			}
 			set_page_private(page + i, entry.val + i);
 			xas_store(&xas, page);
 			xas_next(&xas);
 		}
+		address_space->nrexceptional -= nr_shadows;
 		address_space->nrpages += nr;
 		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
 		ADD_CACHE_INFO(add_total, nr);
@@ -154,7 +165,8 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
  * This must be called only on pages that have
  * been verified to be in the swap cache.
  */
-void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
+void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	int i, nr = thp_nr_pages(page);
@@ -166,12 +178,14 @@ void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
 	VM_BUG_ON_PAGE(PageWriteback(page), page);
 
 	for (i = 0; i < nr; i++) {
-		void *entry = xas_store(&xas, NULL);
+		void *entry = xas_store(&xas, shadow);
 		VM_BUG_ON_PAGE(entry != page, entry);
 		set_page_private(page + i, 0);
 		xas_next(&xas);
 	}
 	ClearPageSwapCache(page);
+	if (shadow)
+		address_space->nrexceptional += nr;
 	address_space->nrpages -= nr;
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
 	ADD_CACHE_INFO(del_total, nr);
@@ -208,7 +222,7 @@ int add_to_swap(struct page *page)
 	 * Add it to the swap cache.
 	 */
 	err = add_to_swap_cache(page, entry,
-			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
+			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
 	if (err)
 		/*
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
@@ -246,13 +260,44 @@ void delete_from_swap_cache(struct page *page)
 	struct address_space *address_space = swap_address_space(entry);
 
 	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(page, entry);
+	__delete_from_swap_cache(page, entry, NULL);
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_page(page, entry);
 	page_ref_sub(page, thp_nr_pages(page));
 }
 
+void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				unsigned long end)
+{
+	unsigned long curr = begin;
+	void *old;
+
+	for (;;) {
+		unsigned long nr_shadows = 0;
+		swp_entry_t entry = swp_entry(type, curr);
+		struct address_space *address_space = swap_address_space(entry);
+		XA_STATE(xas, &address_space->i_pages, curr);
+
+		xa_lock_irq(&address_space->i_pages);
+		xas_for_each(&xas, old, end) {
+			if (!xa_is_value(old))
+				continue;
+			xas_store(&xas, NULL);
+			nr_shadows++;
+		}
+		address_space->nrexceptional -= nr_shadows;
+		xa_unlock_irq(&address_space->i_pages);
+
+		/* search the next swapcache until we meet end */
+		curr >>= SWAP_ADDRESS_SPACE_SHIFT;
+		curr++;
+		curr <<= SWAP_ADDRESS_SPACE_SHIFT;
+		if (curr > end)
+			break;
+	}
+}
+
 /* 
  * If we are the only user, then try to free up the swap cache. 
  * 
@@ -429,7 +474,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	__SetPageSwapBacked(page);
 
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK)) {
+	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, NULL)) {
 		put_swap_page(page, entry);
 		goto fail_unlock;
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6bd9b4c..3dba9be 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -696,6 +696,7 @@ static void add_to_avail_list(struct swap_info_struct *p)
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			    unsigned int nr_entries)
 {
+	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 
@@ -722,6 +723,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
+	clear_shadow_from_swap_cache(si->type, begin, end);
 }
 
 static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6dda5b2..b9b543e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -896,7 +896,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
 		mem_cgroup_swapout(page, swap);
-		__delete_from_swap_cache(page, swap);
+		__delete_from_swap_cache(page, swap, NULL);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
 		workingset_eviction(page, target_memcg);
-- 
2.7.4

