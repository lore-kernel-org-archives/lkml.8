Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23128C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73CF207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnKfKujo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgFQF05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFQF0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:26:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435EDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so487118pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lFkuSuUp5TYSJoojYtE5bRpFMA9GIu0QTze8kgGtVS0=;
        b=EnKfKujoKQOlNwyGBGhvACo6Hiy3EHRsb8UziRI3Pg0rCyC3Bo9TavEt+QyTzTuAZs
         LkOMEwzMYe0fDGfMBo7Gr1IP+G0a5ow7RmAbAObaIskfkNBvaf/OSShU/TO/1jTgiuhH
         s3GpvI6IoHp6i7cFa5f9PKZZbTuOi1URqjjycsl8MePCXp9RvpZOkqnn9wKlYaFv9uEJ
         juf6+gm/AUJs57CDEzoWr5kBi/+KUBK94mN7LZDZI7DptsgzXu5WlVqWtEyI9vKm4yyL
         EobT2rmCiKxA9mRg5c4UfWlaisBn102ghKvg9A6mBqz+erOLQNya6d6SxWz1PDMPMe81
         jN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lFkuSuUp5TYSJoojYtE5bRpFMA9GIu0QTze8kgGtVS0=;
        b=cRQIaFq8TdhrEVp25NAUcSdRVuD0It+yO3RezMtyJ1+Vhf0mei8k7pNyZnHYoN+jpt
         iNNh6wgOhb4MSchuAcc/N36nxily9F9HXcYJex0mOgVtv7Zh4fCwUDMBr7FXkZbmEDIv
         EIJl7L+wjcMtMpwsTMcP5h9yF/b/m1H56Wl9eTwxMTKtiG9YjAWBtZsoJR2EnP8qK4lB
         4DkczaFtdDPYLMjnFl6ckqyQrH2esVJVvxWkOGZn6f47wucoCHNfG6YvbYX5of4QhYN5
         GmYGZlmkNY6nbTJkZIogSGmon19uxuavB6I6geJLffqk0xvMqI8Hg1wdDB8KogNn4Q6m
         QWyQ==
X-Gm-Message-State: AOAM5313ccieTFej/XFY3TLrrcROdhXEgGoWuwrklVSynBa82IMb4Tvj
        8+KYwshOp1NQaZ0cytc1SGI=
X-Google-Smtp-Source: ABdhPJxN7f5QRTmVFREoHWEZWboIAFqlsGa1WlYMkDPSQKGxMiPZvXW4bz4YPSQ+AFIt3S96SLXWAg==
X-Received: by 2002:a17:90a:36cf:: with SMTP id t73mr6605699pjb.100.1592371612725;
        Tue, 16 Jun 2020 22:26:52 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id d184sm8830068pfd.85.2020.06.16.22.26.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 22:26:52 -0700 (PDT)
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
Subject: [PATCH v6 4/6] mm/swapcache: support to handle the exceptional entries in swapcache
Date:   Wed, 17 Jun 2020 14:26:21 +0900
Message-Id: <1592371583-30672-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Swapcache doesn't handle the exceptional entries since there is no case
using it. In the following patch, workingset detection for anonymous
page will be implemented and it stores the shadow entries as exceptional
entries into the swapcache. So, we need to handle the exceptional entries
and this patch implements it.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h | 17 ++++++++++++----
 mm/shmem.c           |  3 ++-
 mm/swap_state.c      | 56 ++++++++++++++++++++++++++++++++++++++++++++++------
 mm/swapfile.c        |  2 ++
 mm/vmscan.c          |  2 +-
 5 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f4f5f94..901da54 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -416,9 +416,13 @@ extern struct address_space *swapper_spaces[];
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
@@ -572,13 +576,13 @@ static inline int add_to_swap(struct page *page)
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
 
@@ -586,6 +590,11 @@ static inline void delete_from_swap_cache(struct page *page)
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
index a0dbe62..e9a99a2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1374,7 +1374,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		list_add(&info->swaplist, &shmem_swaplist);
 
 	if (add_to_swap_cache(page, swap,
-			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN) == 0) {
+			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
+			NULL) == 0) {
 		spin_lock_irq(&info->lock);
 		shmem_recalc_inode(inode);
 		info->swapped++;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1050fde..43c4e3a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -110,12 +110,15 @@ void show_swap_cache_info(void)
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
 	unsigned long i, nr = hpage_nr_pages(page);
+	unsigned long nrexceptional = 0;
+	void *old;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
@@ -131,10 +134,17 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 			goto unlock;
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
+			old = xas_load(&xas);
+			if (xa_is_value(old)) {
+				nrexceptional++;
+				if (shadowp)
+					*shadowp = old;
+			}
 			set_page_private(page + i, entry.val + i);
 			xas_store(&xas, page);
 			xas_next(&xas);
 		}
+		address_space->nrexceptional -= nrexceptional;
 		address_space->nrpages += nr;
 		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
 		ADD_CACHE_INFO(add_total, nr);
@@ -154,7 +164,8 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
  * This must be called only on pages that have
  * been verified to be in the swap cache.
  */
-void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
+void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	int i, nr = hpage_nr_pages(page);
@@ -166,12 +177,14 @@ void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
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
@@ -208,7 +221,7 @@ int add_to_swap(struct page *page)
 	 * Add it to the swap cache.
 	 */
 	err = add_to_swap_cache(page, entry,
-			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
+			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
 	if (err)
 		/*
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
@@ -246,13 +259,44 @@ void delete_from_swap_cache(struct page *page)
 	struct address_space *address_space = swap_address_space(entry);
 
 	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(page, entry);
+	__delete_from_swap_cache(page, entry, NULL);
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_page(page, entry);
 	page_ref_sub(page, hpage_nr_pages(page));
 }
 
+void clear_shadow_from_swap_cache(int type, unsigned long begin,
+				unsigned long end)
+{
+	unsigned long curr;
+	void *old;
+	swp_entry_t entry = swp_entry(type, begin);
+	struct address_space *address_space = swap_address_space(entry);
+	XA_STATE(xas, &address_space->i_pages, begin);
+
+retry:
+	xa_lock_irq(&address_space->i_pages);
+	for (curr = begin; curr <= end; curr++) {
+		entry = swp_entry(type, curr);
+		if (swap_address_space(entry) != address_space) {
+			xa_unlock_irq(&address_space->i_pages);
+			address_space = swap_address_space(entry);
+			begin = curr;
+			xas_set(&xas, begin);
+			goto retry;
+		}
+
+		old = xas_load(&xas);
+		if (!xa_is_value(old))
+			continue;
+		xas_store(&xas, NULL);
+		address_space->nrexceptional--;
+		xas_next(&xas);
+	}
+	xa_unlock_irq(&address_space->i_pages);
+}
+
 /* 
  * If we are the only user, then try to free up the swap cache. 
  * 
@@ -429,7 +473,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	__SetPageSwapBacked(page);
 
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL)) {
+	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL, NULL)) {
 		put_swap_page(page, entry);
 		goto fail_unlock;
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 38f6433..4630db1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -696,6 +696,7 @@ static void add_to_avail_list(struct swap_info_struct *p)
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			    unsigned int nr_entries)
 {
+	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 
@@ -721,6 +722,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
+	clear_shadow_from_swap_cache(si->type, begin, end);
 }
 
 static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3caa35f..37943bf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -901,7 +901,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
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

