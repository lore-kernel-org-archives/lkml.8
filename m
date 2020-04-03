Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2BC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B77D20757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXozujAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbgDCFl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:41:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36217 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCFl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:41:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id n10so2969385pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r0eqQQzZVYAMWaAaTkdQtsZg27mNRhKCEc6TANrTfaA=;
        b=JXozujAGQkPd4kgBdldmVTzgaNe1zR6cVnfCViutp2v9858lEmz01PgLE6+Yu6EVPE
         hGl9lvCWkTWDtgRBk8Mi1hIp1dkx3AD8TqiHnbZUVq6jxf8GG198U9z37UmRimox96fq
         cEJWj3xMyPdQF42XjWnvjVngzIYkF1hAeX7k1lomOBLZ66uvaUzfljePjPVYReqhDD2W
         oZVp4HWmOWA4XWg/OV+y86jvJfk7/VNi/sV+gEZaiN1llXj4iH78UZHkOCRKwXgX2uIK
         2/SudWyF18GvYGXgx2isXsZEcPrtA1lYeqOWh84Sd2yU11cXLnA9y2Eny6HOn/rLOrZq
         R4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r0eqQQzZVYAMWaAaTkdQtsZg27mNRhKCEc6TANrTfaA=;
        b=c8h/DLDr65pCiuJ+I/edLJG7+cKipiGLlSNa3OVvK1+ptxAhx4xO7f52C2jY1nSdFY
         qH5WBsb0xGdSb+H4VozsHOCOXEqUaV0/gPY+Bm2SUQpbWlfdZ1tzIRjDbvcijiB1R4jb
         Lw8wJWnSHFpN75/GLdxZksEMMvIV6biT85j+rQ6bVeWC7DO6x14tegomgrGKYN+ZNqoI
         0/MiQ5c4uYrCB1qEx3QyZvoAAg3zTt21sVFKH29LZEW8796YgzdUCKhlEB5wyJfHrAAn
         +2EyA4F23Ja3RekVTcp+t6ZkuY4rmH8NjNTqRZzQG6V2JxgG/lEX5snSl3GGyhkGXG1i
         mK3w==
X-Gm-Message-State: AGi0PuYYLZumbv0LF7Dfbc2cjVvZJFyVvu3YMW9PNY7NNdN8gTzKanZf
        0D7t4widcYTteDTn49ow5Ns=
X-Google-Smtp-Source: APiQypKsze6uFGavVeFNzGhQQ7RUuyHnOXlOVv3DMBcutQlQbGOnmSxG64O1Zt8mRJoPmTgg6IVLig==
X-Received: by 2002:a62:1b12:: with SMTP id b18mr6827791pfb.258.1585892486656;
        Thu, 02 Apr 2020 22:41:26 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e6sm4568295pgu.44.2020.04.02.22.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:41:26 -0700 (PDT)
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
Subject: [PATCH v5 06/10] mm/swap: implement workingset detection for anonymous LRU
Date:   Fri,  3 Apr 2020 14:40:44 +0900
Message-Id: <1585892447-32059-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
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
 mm/memory.c          |  8 ++++++++
 mm/swap.c            |  3 +--
 mm/swap_state.c      | 22 ++++++++++++++++++++--
 mm/vmscan.c          |  7 +++++--
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index eea0700..97e8a2e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -408,6 +408,7 @@ extern struct address_space *swapper_spaces[];
 extern unsigned long total_swapcache_pages(void);
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
+extern void *get_shadow_from_swap_cache(swp_entry_t entry);
 extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
 			struct vm_area_struct *vma, gfp_t gfp, void **shadowp);
 extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
@@ -566,6 +567,11 @@ static inline int add_to_swap(struct page *page)
 	return 0;
 }
 
+static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
+{
+	return NULL;
+}
+
 static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
 			struct vm_area_struct *vma, gfp_t gfp, void **shadowp)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 127379a..9effb23 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2945,6 +2945,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	int locked;
 	int exclusive = 0;
 	vm_fault_t ret = 0;
+	void *shadow = NULL;
 
 	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
 		goto out;
@@ -2983,6 +2984,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				__SetPageLocked(page);
 				__SetPageSwapBacked(page);
 				set_page_private(page, entry.val);
+				shadow = get_shadow_from_swap_cache(entry);
 				lru_cache_add_anon(page);
 				swap_readpage(page, true);
 			}
@@ -3099,6 +3101,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		mem_cgroup_commit_charge(page, memcg, true, false);
 	}
 
+	if (shadow) {
+		workingset_refault(page, shadow);
+		if (PageActive(page) && PageLRU(page))
+			activate_page(page);
+	}
+
 	swap_free(entry);
 	if (mem_cgroup_swap_full(page) ||
 	    (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
diff --git a/mm/swap.c b/mm/swap.c
index d14a2fd..d9f2005 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -394,8 +394,7 @@ void mark_page_accessed(struct page *page)
 		else
 			__lru_cache_activate_page(page);
 		ClearPageReferenced(page);
-		if (page_is_file_cache(page))
-			workingset_activation(page);
+		workingset_activation(page);
 	}
 	if (page_is_idle(page))
 		clear_page_idle(page);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1db73a2..de994f9 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -107,6 +107,20 @@ void show_swap_cache_info(void)
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
@@ -393,6 +407,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	struct page *found_page = NULL, *new_page = NULL;
 	struct swap_info_struct *si;
 	int err;
+	void *shadow;
 	*new_page_allocated = false;
 
 	do {
@@ -448,12 +463,15 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/* May fail (-ENOMEM) if XArray node allocation failed. */
 		__SetPageLocked(new_page);
 		__SetPageSwapBacked(new_page);
+		shadow = NULL;
 		err = add_to_swap_cache(new_page, entry, vma,
-				gfp_mask & GFP_KERNEL, NULL);
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
index d46e3e5..d8aa42a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -853,6 +853,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 {
 	unsigned long flags;
 	int refcount;
+	void *shadow = NULL;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(mapping != page_mapping(page));
@@ -895,12 +896,13 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
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
@@ -1462,6 +1464,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			SetPageActive(page);
 			stat->nr_activate[type] += nr_pages;
 			count_memcg_page_event(page, PGACTIVATE);
+			workingset_activation(page);
 		}
 keep_locked:
 		unlock_page(page);
-- 
2.7.4

