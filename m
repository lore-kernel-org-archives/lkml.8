Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD887C2BA1B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A70320719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ+U8Nje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbgDCFlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:41:21 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50575 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCFlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:41:20 -0400
Received: by mail-pj1-f67.google.com with SMTP id v13so2534594pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wr+FSE2GllaKl6JcJYYLALxEM/oEZ+LsQ95X4jpTpac=;
        b=PZ+U8NjeIMa95lW9a/5kYOYKQJ2/US/yXbPIkEmG2uA0OjfNL+RTd/UJoPt6Y0rlPO
         osYPUDZExOHeEWd0oGUQLAnfxYoy0RWeaZalAtY6l4hsSOU0J1TfNxvAKxDBymPhhOCr
         JI8HUsqDRJAELcO2yklUp+uO1ATFbc6JPsbeu5uDZYd70eedOh2tp3FUBsrEcxMgcEYi
         FepThKp7qf8y6lnfRwQwBmxEDjoeEH2V7wNy3jYJ9RdKhiI7cuUQb162Pmtjlanq3+jn
         n5Peqtk5MIA0XBwSaMHIkWp4PC+tQpymtDR+Hvo5UWiUOidKYcdVISBIrjobcfUGc+KS
         i29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wr+FSE2GllaKl6JcJYYLALxEM/oEZ+LsQ95X4jpTpac=;
        b=h6ngvDoliYtM/BT7kUszj3m1OXaCOBDUj41BdHP6HIXZYOus1du3Ux1AdYeZdFEkF1
         Kchu0Z88ocop+jHagCtgxTOncd8eHIFT4Avt0qGU42srdsEKPxJWGSYgxmbpSp74HROV
         gco42w7qGjyEUcWULCsKjBceoi3UR0ASia7/TuGGzEZ0VxoyDL7eVRs2t0MUtwF8FxlX
         NSLeYSWfiOg/5H/zgw0ND1vVbsNgvV32HFm2QSVrcBH0SZN3gYlaOhMaYDJabGEdyDQw
         bQOchNjnkuiBZjVkaSjkN0jNSbfhCppODWJP3tzRuBpGhXmvRGGZ4XXGe5Fj8QUOVmLU
         nwag==
X-Gm-Message-State: AGi0PuYFSghdtqbyaqUWKWyylitASTNk1dbn3u2nAcvL0MkQXDVAzW9e
        FpwR0aI0y0yxb3n6HKSp2FE=
X-Google-Smtp-Source: APiQypIxOmYseKqYJnT71lY4qm9gnYAXXhSmgPVUGx9GTKZYcdT05tlTUvh4zgJx/qGCul+zJyxfTA==
X-Received: by 2002:a17:90a:d0c3:: with SMTP id y3mr7905624pjw.128.1585892479741;
        Thu, 02 Apr 2020 22:41:19 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e6sm4568295pgu.44.2020.04.02.22.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:41:19 -0700 (PDT)
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
Subject: [PATCH v5 04/10] mm/swapcache: support to handle the exceptional entries in swapcache
Date:   Fri,  3 Apr 2020 14:40:42 +0900
Message-Id: <1585892447-32059-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index aad3ba7..9e34b4e 100644
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
index 7196ccc..d46e3e5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -895,7 +895,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
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

