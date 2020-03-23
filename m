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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BDEC54FD1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B6620714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoK9TGay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCWFwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:52:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44401 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCWFwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:52:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so5454467plr.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8BKTKeS86EzAAVAM7E7CqauMkIwqwO+JtvB/TRaImBU=;
        b=RoK9TGaySXHN1OlYzFQBROE5RbaQWaFK2mNV/EaBD4a5/kfEW/c7qJyIkkUuWWsxhh
         P7Xdetk+EgpULzPhTk4qxQkgzm9GbAKOf9OnOFSaLv9G4h0mnNWHYIB1O9meSHUZybol
         H2iZgraxKYQ451dlIIWdGTDJXQJYcsP6IAf6mP6t8v7t/TTcCMnh7R5jD9tOO52JuQ5W
         tBKnItUR8Os5uEWS9AKaKv/hQ1XyDJ9shXNtmIQtjdG2c3TA0ooqTOETR+FGT5g++9jY
         +v+S0ZmpqTwT/ZXBbJXfgRL/ERQGnvi19/1OgL6rZGN5OUidSOFretMddCm2GUPHb3+e
         8tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8BKTKeS86EzAAVAM7E7CqauMkIwqwO+JtvB/TRaImBU=;
        b=JRSFyQXSyGj5mdaOy6RyXc2y2gUNJkA7fp13obcGiuxH1q6cBu/+JTCwb3dL7JIuqS
         op9+e0weIkOv09LtA6fzLJhG3l9BFHjMftRs+Qpf/7tMn4maV0BtLqZBlOVcm08IUoL5
         zLen3JteFF6WSI/LPwWeLs4oaKa7VRD05owajnRJz9t9zn3LfTG1cOzdDao91x8bWRtE
         vEwc/cuLaIQ76UlmgR2Zqhb/uwMbpVCPbIVS5zCxG8THHcYbvdKTAAcBVxIxhdl/3+gb
         4BesyAnFoSLHae+YT+s6Rij7790pFkoKm5UwXInd6Q4gewBwppbqCrDbH+bGZvHCj2DS
         v8IQ==
X-Gm-Message-State: ANhLgQ3VhMkXMcCmartPcrauPZ1kxoNZbO+Ef2GqQUrexOFO5T1mGefz
        ajz8QAhDLrCtgjjjpkEP7c0=
X-Google-Smtp-Source: ADFU+vvZLquJa8MhHFazV10Alh3WWus90SRxZ3uUpTHkON3UkFV9f9Ju1Y/jnbCYVMgb0iku1sML6w==
X-Received: by 2002:a17:90b:3711:: with SMTP id mg17mr24045432pjb.73.1584942762728;
        Sun, 22 Mar 2020 22:52:42 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y30sm12563058pff.67.2020.03.22.22.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 22:52:42 -0700 (PDT)
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
Subject: [PATCH v4 4/8] mm/swapcache: support to handle the exceptional entries in swapcache
Date:   Mon, 23 Mar 2020 14:52:08 +0900
Message-Id: <1584942732-2184-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
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

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h | 10 ++++++----
 mm/shmem.c           |  3 ++-
 mm/swap_state.c      | 26 ++++++++++++++++++++------
 mm/vmscan.c          |  2 +-
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 954e13e..273de48 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -408,9 +408,11 @@ extern struct address_space *swapper_spaces[];
 extern unsigned long total_swapcache_pages(void);
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
-extern int add_to_swap_cache(struct page *, swp_entry_t, gfp_t);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
+			gfp_t gfp, void **shadowp);
 extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
-extern void __delete_from_swap_cache(struct page *, swp_entry_t entry);
+extern void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow);
 extern void delete_from_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
@@ -565,13 +567,13 @@ static inline int add_to_swap(struct page *page)
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
index 8e7ce9a..f06af84 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -111,12 +111,15 @@ void show_swap_cache_info(void)
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
 	unsigned long i, nr = compound_nr(page);
+	unsigned long nrexceptional = 0;
+	void *old;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
@@ -132,10 +135,17 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
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
@@ -155,7 +165,8 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
  * This must be called only on pages that have
  * been verified to be in the swap cache.
  */
-void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
+void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	int i, nr = hpage_nr_pages(page);
@@ -167,12 +178,14 @@ void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
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
@@ -209,7 +222,7 @@ int add_to_swap(struct page *page)
 	 * Add it to the swap cache.
 	 */
 	err = add_to_swap_cache(page, entry,
-			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
+			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
 	if (err)
 		/*
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
@@ -247,7 +260,7 @@ void delete_from_swap_cache(struct page *page)
 	struct address_space *address_space = swap_address_space(entry);
 
 	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(page, entry);
+	__delete_from_swap_cache(page, entry, NULL);
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_page(page, entry);
@@ -418,7 +431,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/* May fail (-ENOMEM) if XArray node allocation failed. */
 		__SetPageLocked(new_page);
 		__SetPageSwapBacked(new_page);
-		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
+		err = add_to_swap_cache(new_page, entry,
+				gfp_mask & GFP_KERNEL, NULL);
 		if (likely(!err)) {
 			/* Initiate read into locked page */
 			SetPageWorkingset(new_page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0493c25..9871861 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -909,7 +909,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
 		mem_cgroup_swapout(page, swap);
-		__delete_from_swap_cache(page, swap);
+		__delete_from_swap_cache(page, swap, NULL);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
 	} else {
-- 
2.7.4

