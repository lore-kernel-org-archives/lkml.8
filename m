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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E32C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218DC20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7YCPWss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGWHt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGWHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:49:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF96C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so2670936pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nMJaxT009VYfWfSDnZgpATklA3yQDr7DBKWPTY196gs=;
        b=R7YCPWssLYkFwfeNv++E63VyhosRbAta7GEpT410A48DocTsjm+U9spvC+FGC4GbG1
         DMmF5sa8+mV3XtZCLkSejYScLOj6ech5jTf5LXYtzkrACQAh0JROkFNHRUa9HK5d5WGi
         cu0ypSLgfpTlaS3wtHx429qp+D1GC65BhLjYrfJkQ7y7tN9PZ6uwzxode7IqjFTuHpxn
         0GeJKzopBE7D87FXts2ARy7PrWnjM+TdaumuJYXHzVYGYEi3BejRzKX/A2Ynh3JvgqrC
         a95dS4VNz/V4eksltGQ4VXYUQF0DqqPtIgawpQw70cxzRBsiUtIBKhETHenNMCWNXGAt
         mMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nMJaxT009VYfWfSDnZgpATklA3yQDr7DBKWPTY196gs=;
        b=BJ5QrmzLrBastmyH2GM//NcWez5G6exlG+YsJTGhaWEiW0+Ae6Fx15K0GXuFzDXEnV
         c5bSGmlA9t/qUsfTCW88umgDZljKjQlHkEW8nJff1UpWIzBOS8x4s8ameL/1Bfl8+KHu
         eS/oFVHjyWFT2SxHIw/BissB7e3nIJlkXrNCLPyPPn7pVlyGKbbzPpWul8Um/ZfyqWzE
         81az6yIlikIy4GLqWukOJ4rVbVsZYJjk+Vkf1Ru8+W0Svg3V6RRfjTbPc/l6cudOS1Me
         oRksFM6iIPdEPa/oxyUnD1Zt04hwHF2jvDs4BFHzQ5ClEIft7Rycl3dDnNU8zOawF5mK
         Dkaw==
X-Gm-Message-State: AOAM532jAND3ISNYGHZ8sxtfAWzh6hEofLu7fPGD2fIxLqJ/RyO0DIOv
        SKQ8Ht6cMHBt0SYh7vA+2tg=
X-Google-Smtp-Source: ABdhPJzp5KHRuQLAVPZV8wbiRpxdEWsbICYGtwOlPVfriVsHhXh60AgQSrA2aCyBYN0Q2Ax8ZXnJeg==
X-Received: by 2002:a63:e045:: with SMTP id n5mr3323394pgj.274.1595490596480;
        Thu, 23 Jul 2020 00:49:56 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id f71sm9164879pje.0.2020.07.23.00.49.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:49:56 -0700 (PDT)
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
Subject: [PATCH v7 5/6] mm/swap: implement workingset detection for anonymous LRU
Date:   Thu, 23 Jul 2020 16:49:19 +0900
Message-Id: <1595490560-15117-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patch implements workingset detection for anonymous LRU.
All the infrastructure is implemented by the previous patches so this
patch just activates the workingset detection by installing/retrieving
the shadow entry and adding refault calculation.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h |  6 ++++++
 mm/memory.c          | 11 ++++-------
 mm/swap_state.c      | 23 ++++++++++++++++++-----
 mm/vmscan.c          |  7 ++++---
 mm/workingset.c      | 15 +++++++++++----
 5 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8a4c592..6610469 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -414,6 +414,7 @@ extern struct address_space *swapper_spaces[];
 extern unsigned long total_swapcache_pages(void);
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
+extern void *get_shadow_from_swap_cache(swp_entry_t entry);
 extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
 			gfp_t gfp, void **shadowp);
 extern void __delete_from_swap_cache(struct page *page,
@@ -573,6 +574,11 @@ static inline int add_to_swap(struct page *page)
 	return 0;
 }
 
+static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
+{
+	return NULL;
+}
+
 static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
 					gfp_t gfp_mask, void **shadowp)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 25769b6..4934dbc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3100,6 +3100,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	int locked;
 	int exclusive = 0;
 	vm_fault_t ret = 0;
+	void *shadow = NULL;
 
 	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
 		goto out;
@@ -3151,13 +3152,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					goto out_page;
 				}
 
-				/*
-				 * XXX: Move to lru_cache_add() when it
-				 * supports new vs putback
-				 */
-				spin_lock_irq(&page_pgdat(page)->lru_lock);
-				lru_note_cost_page(page);
-				spin_unlock_irq(&page_pgdat(page)->lru_lock);
+				shadow = get_shadow_from_swap_cache(entry);
+				if (shadow)
+					workingset_refault(page, shadow);
 
 				lru_cache_add(page);
 				swap_readpage(page, true);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 13d8d66..146a86d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -106,6 +106,20 @@ void show_swap_cache_info(void)
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
+	if (page)
+		put_page(page);
+	return NULL;
+}
+
 /*
  * add_to_swap_cache resembles add_to_page_cache_locked on swapper_space,
  * but sets SwapCache flag and private instead of mapping and index.
@@ -406,6 +420,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 {
 	struct swap_info_struct *si;
 	struct page *page;
+	void *shadow = NULL;
 
 	*new_page_allocated = false;
 
@@ -474,7 +489,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	__SetPageSwapBacked(page);
 
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, NULL)) {
+	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow)) {
 		put_swap_page(page, entry);
 		goto fail_unlock;
 	}
@@ -484,10 +499,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		goto fail_unlock;
 	}
 
-	/* XXX: Move to lru_cache_add() when it supports new vs putback */
-	spin_lock_irq(&page_pgdat(page)->lru_lock);
-	lru_note_cost_page(page);
-	spin_unlock_irq(&page_pgdat(page)->lru_lock);
+	if (shadow)
+		workingset_refault(page, shadow);
 
 	/* Caller will initiate read into locked page */
 	SetPageWorkingset(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b9b543e..9d4e28c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -854,6 +854,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 {
 	unsigned long flags;
 	int refcount;
+	void *shadow = NULL;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(mapping != page_mapping(page));
@@ -896,13 +897,13 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
 		mem_cgroup_swapout(page, swap);
-		__delete_from_swap_cache(page, swap, NULL);
+		if (reclaimed && !mapping_exiting(mapping))
+			shadow = workingset_eviction(page, target_memcg);
+		__delete_from_swap_cache(page, swap, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
-		workingset_eviction(page, target_memcg);
 	} else {
 		void (*freepage)(struct page *);
-		void *shadow = NULL;
 
 		freepage = mapping->a_ops->freepage;
 		/*
diff --git a/mm/workingset.c b/mm/workingset.c
index 2d77e4d..92e6611 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -353,15 +353,22 @@ void workingset_refault(struct page *page, void *shadow)
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-	 * all the memory was available to the page cache. Whether
-	 * cache can compete with anon or not depends on having swap.
+	 * all the memory was available to the workingset. Whether
+	 * workingset competition needs to consider anon or not depends
+	 * on having swap.
 	 */
 	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
-	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
+	if (!file) {
 		workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_INACTIVE_ANON);
+						     NR_INACTIVE_FILE);
+	}
+	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
 		workingset_size += lruvec_page_state(eviction_lruvec,
 						     NR_ACTIVE_ANON);
+		if (file) {
+			workingset_size += lruvec_page_state(eviction_lruvec,
+						     NR_INACTIVE_ANON);
+		}
 	}
 	if (refault_distance > workingset_size)
 		goto out;
-- 
2.7.4

