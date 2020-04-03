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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C98DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA2520757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ0EgjL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbgDCFli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:41:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40323 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCFlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:41:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so2989990pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=arPVINAquHOrQTYxjkMSixrP6l4IMqUoaA/voICx/gM=;
        b=JJ0EgjL/ArF/0owiScoWRKbKKzI8c2hVuqZjAi2A3jp+G59qjHUZtFAX46JT1HrDzf
         u164YmbHIJ5VHvYsMNcB0x2bo6ol/SpttjvkWGSSqC7aat35CFg5DsOjO1ffIjs4ZeYP
         cjn6t0IhfJL1CrChB7gQ/nc2RewXMar3KmHDS964P/+gXy0ub+Z9Dkksxq4yEo3wMXrN
         blnEuefCC4OLBUzT54hdZ4KBrcSzKGfQ3hLVckV/0XiEsPADVUGom8Io2aqKMN5TuDDO
         kOZaMmuH6+gIEyso8yJR6Alx5xFKpGf6Ey+Dly6GoIVhf/Fj00UbIlDoSnlWpyJOerEV
         EjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=arPVINAquHOrQTYxjkMSixrP6l4IMqUoaA/voICx/gM=;
        b=F72fCjHRueSZ3lq40dv2lb2dARXz5b6n+Dyzybcxt6wmQzmAzV72kH3ySbbQtgd9ye
         xp3HUpG7XVsp9SOl/kjwhCrWBrPx7GXfqttJlUveJamzkklVKMLFxRmLv+DcjMQm+571
         EqLMFZ0RIvW/WPvSRGMt1ka0kQ1/V7u9zjjhyuu3ezElZwMvCznZ5M2htBx9ztYIAWIV
         Tajg2YdHYM7mFFAnkm3RfAiHCCfe3BMzHRcY6AkyRG1izoVNX/szswjRAIU5h+dEii5X
         AXBwq1gyEgRTmSOwOUf2poHnxnBvRv+DfEjE0rikhbP6bpMMuLfBR+sZ7+eW8Ikc1KOn
         X8RQ==
X-Gm-Message-State: AGi0PuZnMxr7d6rh1rfqECbauvvewB3Zn9KanLDYuItITfh2RNRFKNcW
        gpX50E/Be/5K5PyaIlGrILE=
X-Google-Smtp-Source: APiQypL16pgnaoR8b66cc6YctRq8plkJZCj4N7vo3jkD6z1e//vBa+HwO+xyHZ7FtaNdy/exxXKREw==
X-Received: by 2002:a63:510d:: with SMTP id f13mr692837pgb.395.1585892493955;
        Thu, 02 Apr 2020 22:41:33 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e6sm4568295pgu.44.2020.04.02.22.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:41:33 -0700 (PDT)
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
Subject: [PATCH v5 08/10] mm/swap: do not readahead if the previous owner of the swap entry isn't me
Date:   Fri,  3 Apr 2020 14:40:46 +0900
Message-Id: <1585892447-32059-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

To implement workingset detection for anonymous page, the page that is
swapped-in by readahead but not yet touched in the swap cache is also
charged to the memcg. However, if these readahead pages are not ours,
these pages are wrongly charged to us and our memcg could be wrongly
pressured.

To solve the problem, this patch implements to avoid readahead if the
previous owner of the swap entry isn't me. With this patch, readahead
only happens for mine and then there is no wrongly memcg pressure issue.

The purpose of the readahead is to improve the performance by using
locality of the swap space. If the entry isn't mine, there is no locality.
Therefore, it's safe to avoid readahead.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h |  9 ++++++---
 mm/shmem.c           |  2 +-
 mm/swap_state.c      | 34 ++++++++++++++++++++++++++--------
 mm/workingset.c      | 16 ++++++++++++++++
 mm/zswap.c           |  2 +-
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 97e8a2e..d204cc7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -307,6 +307,7 @@ struct vma_swap_readahead {
 };
 
 /* linux/mm/workingset.c */
+bool shadow_from_memcg(void *shadow, struct mem_cgroup *memcg);
 void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
 void workingset_refault(struct page *page, void *shadow);
 void workingset_activation(struct page *page);
@@ -410,7 +411,8 @@ extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
 extern void *get_shadow_from_swap_cache(swp_entry_t entry);
 extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
-			struct vm_area_struct *vma, gfp_t gfp, void **shadowp);
+			struct vm_area_struct *vma, gfp_t gfp,
+			void **shadowp, bool readahead);
 extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
 extern void __delete_from_swap_cache(struct page *page,
 			swp_entry_t entry, void *shadow);
@@ -425,7 +427,7 @@ extern struct page *read_swap_cache_async(swp_entry_t, gfp_t,
 			bool do_poll);
 extern struct page *__read_swap_cache_async(swp_entry_t, gfp_t,
 			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated);
+			bool *new_page_allocated, bool readahead);
 extern struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				struct vm_fault *vmf);
 extern struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
@@ -573,7 +575,8 @@ static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
 }
 
 static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
-			struct vm_area_struct *vma, gfp_t gfp, void **shadowp)
+				struct vm_area_struct *vma, gfp_t gfp,
+				void **shadowp, bool readahead)
 {
 	return -1;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 8e28c1f..483c32d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1371,7 +1371,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 
 	if (add_to_swap_cache(page, swap, NULL,
 			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
-			NULL) == 0) {
+			NULL, false) == 0) {
 		spin_lock_irq(&info->lock);
 		shmem_recalc_inode(inode);
 		info->swapped++;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index de994f9..9bf0251f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -126,7 +126,8 @@ void *get_shadow_from_swap_cache(swp_entry_t entry)
  * but sets SwapCache flag and private instead of mapping and index.
  */
 int add_to_swap_cache(struct page *page, swp_entry_t entry,
-			struct vm_area_struct *vma, gfp_t gfp, void **shadowp)
+			struct vm_area_struct *vma, gfp_t gfp,
+			void **shadowp, bool readahead)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swp_offset(entry);
@@ -143,6 +144,23 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
 	VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
 
+	if (readahead) {
+		void *shadow = get_shadow_from_swap_cache(entry);
+
+		/*
+		 * In readahead case, check the memcgid of the shadow entry
+		 * in order to stop to readahead other's page
+		 */
+		if (shadow) {
+			memcg = get_mem_cgroup_from_mm(mm);
+			if (memcg && !shadow_from_memcg(shadow, memcg)) {
+				mem_cgroup_put(memcg);
+				return -EINVAL;
+			}
+			mem_cgroup_put(memcg);
+		}
+	}
+
 	page_ref_add(page, nr);
 	/* PageSwapCache() prevent the page from being re-charged */
 	SetPageSwapCache(page);
@@ -253,7 +271,7 @@ int add_to_swap(struct page *page)
 	 * Add it to the swap cache.
 	 */
 	err = add_to_swap_cache(page, entry, NULL,
-			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
+			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL, false);
 	if (err)
 		/*
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
@@ -402,7 +420,7 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated)
+			bool *new_page_allocated, bool readahead)
 {
 	struct page *found_page = NULL, *new_page = NULL;
 	struct swap_info_struct *si;
@@ -465,7 +483,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		__SetPageSwapBacked(new_page);
 		shadow = NULL;
 		err = add_to_swap_cache(new_page, entry, vma,
-				gfp_mask & GFP_KERNEL, &shadow);
+				gfp_mask & GFP_KERNEL, &shadow, readahead);
 		if (likely(!err)) {
 			/* Initiate read into locked page */
 			SetPageWorkingset(new_page);
@@ -481,7 +499,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * clear SWAP_HAS_CACHE flag.
 		 */
 		put_swap_page(new_page, entry);
-	} while (err != -ENOMEM);
+	} while (err != -ENOMEM && err != -EINVAL);
 
 	if (new_page)
 		put_page(new_page);
@@ -499,7 +517,7 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 {
 	bool page_was_allocated;
 	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
-			vma, addr, &page_was_allocated);
+			vma, addr, &page_was_allocated, false);
 
 	if (page_was_allocated)
 		swap_readpage(retpage, do_poll);
@@ -624,7 +642,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
 			swp_entry(swp_type(entry), offset),
-			gfp_mask, vma, addr, &page_allocated);
+			gfp_mask, vma, addr, &page_allocated, true);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -796,7 +814,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		if (unlikely(non_swap_entry(entry)))
 			continue;
 		page = __read_swap_cache_async(entry, gfp_mask, vma,
-					       vmf->address, &page_allocated);
+					vmf->address, &page_allocated, true);
 		if (!page)
 			continue;
 		if (page_allocated) {
diff --git a/mm/workingset.c b/mm/workingset.c
index 871b867..1fa46cf 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -231,6 +231,22 @@ static void unpack_shadow(void *shadow, int *memcgidp, int *page_memcg_tagp,
 	*workingsetp = workingset;
 }
 
+bool shadow_from_memcg(void *shadow, struct mem_cgroup *memcg)
+{
+	int memcgid, page_memcg_tag;
+	struct pglist_data *pgdat;
+	unsigned long eviction;
+	bool workingset;
+	int memcg_tag;
+
+	unpack_shadow(shadow, &memcgid, &page_memcg_tag,
+			&pgdat, &eviction, &workingset);
+	memcg_tag = mem_cgroup_id(memcg);
+	memcg_tag &= (1UL << PAGE_MEMCG_TAG_SHIFT) - 1;
+
+	return memcg_tag == page_memcg_tag;
+}
+
 static void advance_inactive_age(struct mem_cgroup *memcg, pg_data_t *pgdat,
 				bool file)
 {
diff --git a/mm/zswap.c b/mm/zswap.c
index 55094e6..92f1463 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -848,7 +848,7 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
 	bool page_was_allocated;
 
 	*retpage = __read_swap_cache_async(entry, GFP_KERNEL,
-			NULL, 0, &page_was_allocated);
+			NULL, 0, &page_was_allocated, false);
 	if (page_was_allocated)
 		return ZSWAP_SWAPCACHE_NEW;
 	if (!*retpage)
-- 
2.7.4

