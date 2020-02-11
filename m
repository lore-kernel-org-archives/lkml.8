Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B03C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D402168B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaRN70Br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgBKGUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:20:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34226 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgBKGUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:20:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so4977099pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AenkQkksoc/yFcCBODnk1JaW8ZbQido5XpjljiUkdfE=;
        b=LaRN70Br295UBvIZS20z+DmvixdCgfh1IgpHn9+dH2zda9bmelLvX11gdIH+c3r46j
         XKp3Oc4OaIvTMVr9mxvrVPIadb0TdyFK1OvB4i6S+IlqSkSPs8XUtMMVG/VyphGxgnt6
         2DAVoZ0pgARGTiXWl8Pzm1/rcILKOUbUa7IN9LdUr8rrhM8cbsogqvbuaO+27QGhUzxc
         hjR5IV/ugR0BVfH7I4Kfg6DDqBKGT4JGW9rtHl3dRleNER1DtYOLmmwhA3h7HjHo/t3b
         UsMc+m9SBQLZcYtDwlkpthsty3krEWA3XDp457KSYJfV8egKKdC3YGQWsDJ1h3Q2NfGI
         9TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AenkQkksoc/yFcCBODnk1JaW8ZbQido5XpjljiUkdfE=;
        b=ggFXzrQ2laO1k4GS3NwjTHOALkeKCcfXWZlEDi427WfWpw9Zyyzr8wqYy5DufROCuz
         QMvCldXRZrqqej8eWwKm1BFTTgRwk4rfKJ1rt0li6JremXtPoS0kwELWId72bqN/6FIw
         f5gXgHcCd1tze62FSbljEsYJeuDLVXw8BZjdBqlnSUTo6BrJsvzsMsfC/m4d4RU7IoOL
         P7wZCBGGZlX9HX8ZZSJrptTR5hMUziUkxdJhHQH4rJ9PNtZYwloojmmFy26/ydr4tT+v
         q6POrc1k31H5LdLSHUPcXjBPVJiYtt/JUBZiBKe/+VCd37ubNLvhQn07iXEMkuVXPONI
         cQZQ==
X-Gm-Message-State: APjAAAVFDhZ27FYUHZCOTPi9pNybt0HshMGW2mQJVf5gm2C98DdinFb5
        vEgIL5olyOKflIhPwXUNgNE=
X-Google-Smtp-Source: APXvYqzGxv7knBrtLZts0NFu0AAUKXXT4QT5aUdNTD1EOrPWSq4qin6AKKkr1DGB2iunM7LqWiPX0g==
X-Received: by 2002:a62:1594:: with SMTP id 142mr4914620pfv.18.1581402031874;
        Mon, 10 Feb 2020 22:20:31 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x197sm2578696pfc.1.2020.02.10.22.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 22:20:31 -0800 (PST)
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
Subject: [PATCH 7/9] mm/swap: implement workingset detection for anonymous LRU
Date:   Tue, 11 Feb 2020 15:19:51 +0900
Message-Id: <1581401993-20041-8-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patch implements workingset detection for anonymous LRU.
All the infrastructure is implemented by the previous patches so this patch
just activates the workingset detection by installing/retrieving
the shadow entry.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h | 11 +++++++++--
 mm/memory.c          |  7 ++++++-
 mm/shmem.c           |  3 ++-
 mm/swap_state.c      | 31 ++++++++++++++++++++++++++-----
 mm/vmscan.c          |  7 +++++--
 5 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0df8b3f..fb4772e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -408,7 +408,9 @@ extern struct address_space *swapper_spaces[];
 extern unsigned long total_swapcache_pages(void);
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
-extern int add_to_swap_cache(struct page *, swp_entry_t, gfp_t);
+extern void *get_shadow_from_swap_cache(swp_entry_t entry);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
+			gfp_t gfp, void **shadowp);
 extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
 extern void __delete_from_swap_cache(struct page *page,
 			swp_entry_t entry, void *shadow);
@@ -565,8 +567,13 @@ static inline int add_to_swap(struct page *page)
 	return 0;
 }
 
+static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
+{
+	return NULL;
+}
+
 static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
-							gfp_t gfp_mask)
+					gfp_t gfp_mask, void **shadowp)
 {
 	return -1;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 5f7813a..91a2097 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2925,10 +2925,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
 							vmf->address);
 			if (page) {
+				void *shadow;
+
 				__SetPageLocked(page);
 				__SetPageSwapBacked(page);
 				set_page_private(page, entry.val);
-				lru_cache_add_anon(page);
+				shadow = get_shadow_from_swap_cache(entry);
+				if (shadow)
+					workingset_refault(page, shadow);
+				lru_cache_add(page);
 				swap_readpage(page, true);
 			}
 		} else {
diff --git a/mm/shmem.c b/mm/shmem.c
index 8793e8c..c6663ad 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1370,7 +1370,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		list_add(&info->swaplist, &shmem_swaplist);
 
 	if (add_to_swap_cache(page, swap,
-			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN) == 0) {
+			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
+			NULL) == 0) {
 		spin_lock_irq(&info->lock);
 		shmem_recalc_inode(inode);
 		info->swapped++;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3fbbe45..7f7cb19 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -107,11 +107,24 @@ void show_swap_cache_info(void)
 	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
 }
 
+void *get_shadow_from_swap_cache(swp_entry_t entry)
+{
+	struct address_space *address_space = swap_address_space(entry);
+	pgoff_t idx = swp_offset(entry);
+	struct page *page;
+
+	page = find_get_entry(address_space, idx);
+	if (xa_is_value(page))
+		return page;
+	return NULL;
+}
+
 /*
  * add_to_swap_cache resembles add_to_page_cache_locked on swapper_space,
  * but sets SwapCache flag and private instead of mapping and index.
  */
-int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
+int add_to_swap_cache(struct page *page, swp_entry_t entry,
+			gfp_t gfp, void **shadowp)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swp_offset(entry);
@@ -137,8 +150,11 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
 			old = xas_load(&xas);
-			if (xa_is_value(old))
+			if (xa_is_value(old)) {
 				nrexceptional++;
+				if (shadowp)
+					*shadowp = old;
+			}
 			set_page_private(page + i, entry.val + i);
 			xas_store(&xas, page);
 			xas_next(&xas);
@@ -226,7 +242,7 @@ int add_to_swap(struct page *page)
 	 * Add it to the swap cache.
 	 */
 	err = add_to_swap_cache(page, entry,
-			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
+			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
 	if (err)
 		/*
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
@@ -380,6 +396,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	struct page *found_page = NULL, *new_page = NULL;
 	struct swap_info_struct *si;
 	int err;
+	void *shadow;
 	*new_page_allocated = false;
 
 	do {
@@ -435,11 +452,15 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/* May fail (-ENOMEM) if XArray node allocation failed. */
 		__SetPageLocked(new_page);
 		__SetPageSwapBacked(new_page);
-		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
+		shadow = NULL;
+		err = add_to_swap_cache(new_page, entry,
+				gfp_mask & GFP_KERNEL, &shadow);
 		if (likely(!err)) {
 			/* Initiate read into locked page */
 			SetPageWorkingset(new_page);
-			lru_cache_add_anon(new_page);
+			if (shadow)
+				workingset_refault(new_page, shadow);
+			lru_cache_add(new_page);
 			*new_page_allocated = true;
 			return new_page;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99588ba..a1892e7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -867,6 +867,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 {
 	unsigned long flags;
 	int refcount;
+	void *shadow = NULL;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(mapping != page_mapping(page));
@@ -909,12 +910,13 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
 		mem_cgroup_swapout(page, swap);
-		__delete_from_swap_cache(page, swap, NULL);
+		if (reclaimed && !mapping_exiting(mapping))
+			shadow = workingset_eviction(page, target_memcg);
+		__delete_from_swap_cache(page, swap, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
 	} else {
 		void (*freepage)(struct page *);
-		void *shadow = NULL;
 
 		freepage = mapping->a_ops->freepage;
 		/*
@@ -1485,6 +1487,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			SetPageActive(page);
 			stat->nr_activate[type] += nr_pages;
 			count_memcg_page_event(page, PGACTIVATE);
+			workingset_activation(page);
 		}
 keep_locked:
 		unlock_page(page);
-- 
2.7.4

