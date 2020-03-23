Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95075C54FD3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBC420714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0fCVVFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCWFwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:52:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33705 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgCWFwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:52:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so6074770pgo.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PA58IeGELp7GsoJt+UjQP9iD9gs1mWgVhDSyVyxp9eY=;
        b=b0fCVVFFvGUde3UoRxe5Hn/eOXfRswcrwmv5eQI0g7DBF3RqDkmM8/wMGHKhToO4BO
         VALj/+Np3QDwTxyxi5hpGau0EIq2dKJvTg5SSuxYvrV45nT12HKGTRQIiw7LFWI99AoH
         xoMN6RwQp9a9aGchGQ7kJDqDk+rM9GGLCFIzphcojz/HmIN3h6LD27NMLSX5o2I4uKZL
         qQK+1qAiQiEeFY6i+1uuQLJ4eoWuQeBpZpHg6ovlWoBqIcP0G4EzUFHvjw9eRwclzN7w
         +NUEwSQFa48scVZ7ZQZiyjlg53+viYmtgG1bEFcU2FaGG90iVaB0XE+62qexHT03Inv1
         GBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PA58IeGELp7GsoJt+UjQP9iD9gs1mWgVhDSyVyxp9eY=;
        b=bwZeTfrhMtsOXN0UhymgFcqoSgfwuR5bkLvdf5S+GowqUUtUjZEQ5oo0UQC4mbk4mH
         RGzbX0eJcdCkxusJXMh7f5QFhdVlxbEDk5sU3yjNo1ZKw/ZkovFXAeT75Tre8bGB8LsK
         KRZOwIi4BHk/rVkO3ELI1rSjj7/YyI47KyWqjoT1FwD6CUCieGoTHLU609Y/74m8WC+y
         fV5agpTG9q+PK6w+r775p7HP7uZ3yClSO2e10PU1+lFTthqinlpDMQ60oHwyX3BxybBY
         KsxFeA+Nfk3HI703V3uHuAWZ722CcSJo14yYM0uE5NEPeEkpBBaCLdypyEl0nFqcEZ4Z
         D/yA==
X-Gm-Message-State: ANhLgQ3PP1OgcMB7ieClPIoSLxNdCO7GWgm7kJF+TWNN7A8HRZXUNHx2
        EwX6Qzk0U6/d2J6z2f4rvDg=
X-Google-Smtp-Source: ADFU+vuGliCxHPs66TbnySCtCClvxORBH+oMz63p8tvjnSznatR+XfNrRr0tDX/2ia3Rivrmbn7xOQ==
X-Received: by 2002:a62:8247:: with SMTP id w68mr23302803pfd.146.1584942769827;
        Sun, 22 Mar 2020 22:52:49 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y30sm12563058pff.67.2020.03.22.22.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 22:52:49 -0700 (PDT)
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
Subject: [PATCH v4 6/8] mm/swap: implement workingset detection for anonymous LRU
Date:   Mon, 23 Mar 2020 14:52:10 +0900
Message-Id: <1584942732-2184-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
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
 mm/memory.c          |  7 ++++++-
 mm/swap_state.c      | 20 ++++++++++++++++++--
 mm/vmscan.c          |  7 +++++--
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 273de48..fb4772e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -408,6 +408,7 @@ extern struct address_space *swapper_spaces[];
 extern unsigned long total_swapcache_pages(void);
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
+extern void *get_shadow_from_swap_cache(swp_entry_t entry);
 extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
 			gfp_t gfp, void **shadowp);
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
 					gfp_t gfp_mask, void **shadowp)
 {
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
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f06af84..f996455 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -107,6 +107,18 @@ void show_swap_cache_info(void)
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
@@ -376,6 +388,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	struct page *found_page = NULL, *new_page = NULL;
 	struct swap_info_struct *si;
 	int err;
+	void *shadow;
 	*new_page_allocated = false;
 
 	do {
@@ -431,12 +444,15 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/* May fail (-ENOMEM) if XArray node allocation failed. */
 		__SetPageLocked(new_page);
 		__SetPageSwapBacked(new_page);
+		shadow = NULL;
 		err = add_to_swap_cache(new_page, entry,
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
index 9871861..b37cc26 100644
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
@@ -1476,6 +1478,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			SetPageActive(page);
 			stat->nr_activate[type] += nr_pages;
 			count_memcg_page_event(page, PGACTIVATE);
+			workingset_activation(page);
 		}
 keep_locked:
 		unlock_page(page);
-- 
2.7.4

