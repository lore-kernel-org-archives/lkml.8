Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6007C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC62207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAE70EED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFQF1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFQF04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:26:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA07C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so405389plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/q7PqyUFq8ro73/rjx7hpg/m6AeXPnwJqUXUOXyFoLA=;
        b=bAE70EEDpb3cKJ1GELlSXkWCL8XQVe6CoN5lpbF5YGQhMIe/bL3I0mqhSboaJRMsOo
         VoHzLZ+k25b2gOJBUps5N4La65d1NgxMVAht52cGB2+Vmnbkd0PqynlpvXI+6nSRcxq5
         M9fUbdwMUAbKIU8pRnF5Uw0/9Phr06jE6/skkjSjnWTnlGu6ZN8C5Atzm5z5/3F4b3qw
         5+WRke53BMP38aQihn81I20yvea/e4l+nW9J0xuI5yV7EkVM1eVnVAvXhCeGF71Wfmkl
         8opHUw/SfLehNQuT0AG1E3JIpzIIOQwr5fQHXrAjToNc2lyITg6jMWw7BxLDqeD5APk/
         gtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/q7PqyUFq8ro73/rjx7hpg/m6AeXPnwJqUXUOXyFoLA=;
        b=S8/YKZyV9ntsF1cpW/N366F+fpG8OQ+BSdAaY5eFUx/RiOJYEODW9m0O/B/Jv2lMLa
         hFL+5n+4nfhp7PKUqVzD67rUDqjpob958iL7Tb+GZC90NxGoDUjY7h8mEUa7FX/h+Drz
         obvZM4xEvotS3Y+CkCsAZ6tQAi5MmcZNWeMz/NbPbr0POnPrBbt+ONEL391GMmQG/+5F
         kfpGr7FAQxG12HN5c52TgMk9gC4uZyAmr8Qcf89njWHPG9HOBXE9Otmd9//qnisLRFNA
         TJZEZ6TwuhBtviiJhfJdGQNyDBNP8KBQWDkfx2+5QDNTnwGnQJ6URR6g0Ma+PffIRLUG
         c8bw==
X-Gm-Message-State: AOAM531aC3Wd9uKJyB6BATOse8x7dLZZGABHT4JqA1n6MiB+2TqIycPM
        /tJWWC4PToEzdUyMSV+mtS/8gXr1q5A=
X-Google-Smtp-Source: ABdhPJxdKduDz+SWZBN478mAlpjDGDY5E3e4SOkTSwjz3zhCrsfKYWjei2KBsHQlYtORk6BWGK4H1Q==
X-Received: by 2002:a17:90a:a897:: with SMTP id h23mr6411895pjq.90.1592371615912;
        Tue, 16 Jun 2020 22:26:55 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id d184sm8830068pfd.85.2020.06.16.22.26.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 22:26:55 -0700 (PDT)
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
Subject: [PATCH v6 5/6] mm/swap: implement workingset detection for anonymous LRU
Date:   Wed, 17 Jun 2020 14:26:22 +0900
Message-Id: <1592371583-30672-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
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
 include/linux/swap.h |  6 ++++++
 mm/memory.c          | 11 ++++-------
 mm/swap_state.c      | 23 ++++++++++++++++++-----
 mm/vmscan.c          |  7 ++++---
 mm/workingset.c      |  5 +++--
 5 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 901da54..9ee78b8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -416,6 +416,7 @@ extern struct address_space *swapper_spaces[];
 extern unsigned long total_swapcache_pages(void);
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
+extern void *get_shadow_from_swap_cache(swp_entry_t entry);
 extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
 			gfp_t gfp, void **shadowp);
 extern void __delete_from_swap_cache(struct page *page,
@@ -575,6 +576,11 @@ static inline int add_to_swap(struct page *page)
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
index f221f96..2411cf57 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3094,6 +3094,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	int locked;
 	int exclusive = 0;
 	vm_fault_t ret = 0;
+	void *shadow = NULL;
 
 	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
 		goto out;
@@ -3143,13 +3144,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				if (err)
 					goto out_page;
 
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
index 43c4e3a..90c5bd1 100644
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
@@ -405,6 +419,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 {
 	struct swap_info_struct *si;
 	struct page *page;
+	void *shadow = NULL;
 
 	*new_page_allocated = false;
 
@@ -473,7 +488,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	__SetPageSwapBacked(page);
 
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL, NULL)) {
+	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL, &shadow)) {
 		put_swap_page(page, entry);
 		goto fail_unlock;
 	}
@@ -483,10 +498,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
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
index 37943bf..eb02d18 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -859,6 +859,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 {
 	unsigned long flags;
 	int refcount;
+	void *shadow = NULL;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(mapping != page_mapping(page));
@@ -901,13 +902,13 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
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
index 8395e60..3769ae6 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -353,8 +353,9 @@ void workingset_refault(struct page *page, void *shadow)
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-	 * all the memory was available to the page cache. Whether
-	 * cache can compete with anon or not depends on having swap.
+	 * all the memory was available to the workingset. Whether
+	 * workingset competetion need to consider anon or not depends
+	 * on having swap.
 	 */
 	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
 	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
-- 
2.7.4

