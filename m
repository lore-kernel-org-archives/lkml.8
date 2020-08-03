Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1303C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FD2206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r9iSe8H9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHCGSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:18:13 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28141 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgHCGSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:18:12 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200803061809epoutp03788f6ee8d9e728c2dcf3952ada485697~nrZ56WbxA1231412314epoutp03i
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 06:18:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200803061809epoutp03788f6ee8d9e728c2dcf3952ada485697~nrZ56WbxA1231412314epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596435489;
        bh=sBQQV1zc+/XN0an+6gyZV8R+R/n2qAGEr6Yhvwyjgc8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=r9iSe8H90F0YSEFVVNBZ1sVJ4l9XBCiBzxE1ydu5ObFGZJvHnOyzefL/wE5G5Y6Vb
         rcgGmErAr6nNYwvhBz7xdTNuleugsmbEFG8E6SG4jT1sq44S0eKEvof7TB+c9jDAoA
         66loxUYfMlPMka+LM/MPSrZGv6jxVCnbk3AszIm8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200803061808epcas2p1950fb226fea8ff305417c71570bb7c3e~nrZ5qTUOC1725317253epcas2p1d;
        Mon,  3 Aug 2020 06:18:08 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.187]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BKnkQ3xhlzMqYkp; Mon,  3 Aug
        2020 06:18:06 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.FE.18874.D1CA72F5; Mon,  3 Aug 2020 15:18:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561~nrZ2GWhB82259622596epcas2p2c;
        Mon,  3 Aug 2020 06:18:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200803061804epsmtrp144b9cdec6419938030c89441190f526b~nrZ2Fr5yz0137501375epsmtrp1Q;
        Mon,  3 Aug 2020 06:18:04 +0000 (GMT)
X-AuditID: b6c32a46-519ff700000049ba-e2-5f27ac1d0b7a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.75.08303.C1CA72F5; Mon,  3 Aug 2020 15:18:04 +0900 (KST)
Received: from KEI.dsn.sec.samsung.com (unknown [12.36.155.227]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200803061804epsmtip2decaee693c1e6801f5e59bfc92a18a71~nrZ15L-Zs0690806908epsmtip2x;
        Mon,  3 Aug 2020 06:18:04 +0000 (GMT)
From:   pullip.cho@samsung.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hyesoo.yu@samsung.com, janghyuck.kim@samsung.com,
        Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH] mm: sort freelist by rank number
Date:   Mon,  3 Aug 2020 15:10:31 +0900
Message-Id: <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7bCmha7sGvV4g6N95hZz1q9hs/jbeYHV
        YvOcYovLu+awWdxb85/V4l/vQUYHNo9Nnyaxe5yY8ZvFo2/LKkaPz5vkAliicmwyUhNTUosU
        UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
        9O1sivJLS1IVMvKLS2yVUgtScgoMDQv0ihNzi0vz0vWS83OtDA0MjEyBKhNyMq5vKylYGVRx
        /s1ZlgbGg85djJwcEgImEku2vGbtYuTiEBLYwSixsP8nO4TziVFi2ffFTBDOZ0aJt03n2GBa
        lt28zA5iCwnsYpTYc9kVwv7KKPHqqQaIzSYgIzH14UVWEFtEQFZi6t/zLCCDmAX6GCWeTPjH
        CJIQFjCUeLB4DzOIzSKgKtG5aRFQnIODV8BN4uTTDIhdchI3z3Uyg/RKCCxil5gw8R4rRMJF
        YvuDNVC2sMSr41vYIWwpiZf9bewQDdMZJd7NPwR19WZGiW+7BSFsY4lZz9rBljELaEqs36UP
        YkoIKEscucUCUsEswCfRcfgvO0SYV6KjTQiiUUVi59RrLDCb+vbegLI9JNqfdIOVCwnESjyZ
        nTiBUXYWwvgFjIyrGMVSC4pz01OLjQqMkGNoEyM4MWm57WCc8vaD3iFGJg7GQ4wSHMxKIrx/
        /ynHC/GmJFZWpRblxxeV5qQWH2I0BYbWRGYp0eR8YGrMK4k3NDUyMzOwNLUwNTOyUBLnrVe8
        ECckkJ5YkpqdmlqQWgTTx8TBKdXAxBKv9zlFbt7LP7ZiMTK/fAWjpdfzSYo9tvmtf5Xtk8Te
        y4vUdZh543Z9z285nCvy7dornUWJt0QSS38XFs0wj+ZLzdxg7XnIekJm3Lf7G6cqrA2XS3WZ
        ueDdbfub0vM852xRuzFtceTej8dXs2y+JdQpa2vEeku1pvrkWxH+p1bBf6Vij+nLVv14MqGQ
        13Bb4skym4pco+WzA6Zr20dprlvYfVWpLnRJjYT8/f0Xis4/XeN0PP7VH+aFBg0Hd89lmK3V
        WibuaByxLE138/Erk+zPr65s0+hmYd2zyaY/c4/Yubb3O3pN77iv2WGqwJZd/3GLSij7jC1J
        HXrLlmfpH0+VndBlfK/ZIkXw9BF+JZbijERDLeai4kQA5mAJWdUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJMWRmVeSWpSXmKPExsWy7bCSvK7MGvV4g9tfTS3mrF/DZvG38wKr
        xeY5xRaXd81hs7i35j+rxb/eg4wObB6bPk1i9zgx4zeLR9+WVYwenzfJBbBEcdmkpOZklqUW
        6dslcGVc31ZSsDKo4vybsywNjAeduxg5OSQETCSW3bzM3sXIxSEksINR4tj8jawQCSmJed1r
        mSBsYYn7LUdYIYo+M0psmbUaLMEmICMx9eFFsAYRAVmJqX/Ps4AUMQtMYZRo2f+WBSQhLGAo
        8WDxHmYQm0VAVaJz0yLGLkYODl4BN4mTTzMgFshJ3DzXyTyBkWcBI8MqRsnUguLc9NxiwwKj
        vNRyveLE3OLSvHS95PzcTYzgcNHS2sG4Z9UHvUOMTByMhxglOJiVRHj//lOOF+JNSaysSi3K
        jy8qzUktPsQozcGiJM77ddbCOCGB9MSS1OzU1ILUIpgsEwenVAOT607l/mmTvPJeXas+biew
        OyB5zanwCXsa1p2Sm6Z2536MHpelOqd8jbWxCCO7SddDD+GvDMtf1J0OOXy51uyknsquzTNT
        gyouHnwXz7LyR2TQ1tj45RzLXote++PEK+LdkmbC0lS2fz+DcU9mqsz+hBXqEq0/2J+cy3Fv
        DFTJyW+/lfrx5OGLiouP3r3nze7/xN+j9MkDltQHrTsCJQojpbT7ZpevkVLv82bvjg9bddz4
        cY3wZoVzyxyif7EcXHEvWl1IxWfRuy/rxZkPM+x5lur6fXk537d5Sxn43FfIfdKVs/bLFbxv
        u2/FtU18J3ZsE3Hl+zHt3heP2Q53JyeI5JYUXn6je0fg2ZnAo8pKLMUZiYZazEXFiQCiHtj/
        hgIAAA==
X-CMS-MailID: 20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cho KyongHo <pullip.cho@samsung.com>

LPDDR5 introduces rank switch delay. If three successive DRAM accesses
happens and the first and the second ones access one rank and the last
access happens on the other rank, the latency of the last access will
be longer than the second one.
To address this panelty, we can sort the freelist so that a specific
rank is allocated prior to another rank. We expect the page allocator
can allocate the pages from the same rank successively with this
change. It will hopefully improves the proportion of the consecutive
memory accesses to the same rank.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 mm/Kconfig      |  23 +++++++++++
 mm/compaction.c |   6 +--
 mm/internal.h   |  11 ++++++
 mm/page_alloc.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 mm/shuffle.h    |   6 ++-
 5 files changed, 144 insertions(+), 21 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 6c97488..789c02b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -868,4 +868,27 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config RANK_SORTED_FREELIST
+	bool "Prefer allocating free pages in a half of DRAM ranks"
+
+	help
+	  Rank switch delay in DRAM access become larger in LPDDR5 than before.
+	  If two successive memory accesses happen on different ranks in LPDDR5,
+	  the latency of the second access becomes longer due to the rank switch
+	  overhead. This is a power-performance tradeoff achieved in LPDDR5.
+	  By default, sorting freelist by rank number is disabled even though
+	  RANK_SORTED_FREELIST is set to y. To enable, set "dram_rank_granule"
+	  boot argument to a larger or an equal value to pageblock_nr_pages. The
+	  values should be the exact the rank interleaving granule that your
+	  system is using. The rank interleaving granule is 2^(the lowest CS bit
+	  number). CS stands for Chip Select and is also called SS which stands
+	  for Slave Select.
+	  This is not beneficial to single rank memory system. Also this is not
+	  necessary to quad rank and octal rank memory systems because they are
+	  not in LPDDR5 specifications.
+
+	  This is marked experimental because this disables freelist shuffling
+	  (SHUFFLE_PAGE_ALLOCATOR). Also you should set the correct rank
+	  interleaving granule.
+
 endmenu
diff --git a/mm/compaction.c b/mm/compaction.c
index 061dacf..bee9567 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1218,8 +1218,7 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
 
 	if (!list_is_last(freelist, &freepage->lru)) {
 		list_cut_before(&sublist, freelist, &freepage->lru);
-		if (!list_empty(&sublist))
-			list_splice_tail(&sublist, freelist);
+		freelist_splice_tail(&sublist, freelist);
 	}
 }
 
@@ -1236,8 +1235,7 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
 
 	if (!list_is_first(freelist, &freepage->lru)) {
 		list_cut_position(&sublist, freelist, &freepage->lru);
-		if (!list_empty(&sublist))
-			list_splice_tail(&sublist, freelist);
+		freelist_splice_tail(&sublist, freelist);
 	}
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 10c6776..c945b3d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -266,6 +266,17 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 
 #endif
 
+#ifdef CONFIG_RANK_SORTED_FREELIST
+void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist);
+#else
+#include <linux/list.h>
+static inline
+void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist)
+{
+	if (!list_empty(sublist))
+		list_splice_tail(sublist, freelist);
+}
+#endif
 /*
  * This function returns the order of a free page in the buddy system. In
  * general, page_zone(page)->lock must be held by the caller to prevent the
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2824e116..7823a3b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -854,6 +854,69 @@ compaction_capture(struct capture_control *capc, struct page *page,
 }
 #endif /* CONFIG_COMPACTION */
 
+#ifdef CONFIG_RANK_SORTED_FREELIST
+static unsigned long dram_rank_nr_pages __read_mostly;
+
+static inline bool preferred_rank_enabled(void)
+{
+	return dram_rank_nr_pages >= pageblock_nr_pages;
+}
+
+static int __init dram_rank_granule(char *buf)
+{
+	unsigned long val = (unsigned long)(memparse(buf, NULL) / PAGE_SIZE);
+
+	if (val < pageblock_nr_pages) {
+		pr_err("too small rank granule %lu\n", val);
+		return -EINVAL;
+	}
+
+	dram_rank_nr_pages = val;
+
+	return 0;
+}
+
+early_param("dram_rank_granule", dram_rank_granule);
+
+static inline bool __preferred_rank(struct page *page)
+{
+	return !(page_to_pfn(page) & dram_rank_nr_pages);
+}
+
+static inline bool preferred_rank(struct page *page)
+{
+	return !preferred_rank_enabled() || __preferred_rank(page);
+}
+
+void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist)
+{
+	while (!list_empty(sublist)) {
+		struct page *page;
+
+		page = list_first_entry(sublist, struct page, lru);
+		if (!preferred_rank_enabled() || !__preferred_rank(page))
+			list_move_tail(&page->lru, freelist);
+		else
+			list_move(&page->lru, freelist);
+	}
+}
+#else
+static inline bool __preferred_rank(struct page *page)
+{
+	return true;
+}
+
+static inline bool preferred_rank(struct page *page)
+{
+	return true;
+}
+
+static inline bool preferred_rank_enabled(void)
+{
+	return false;
+}
+#endif
+
 /* Used for pages not on another list */
 static inline void add_to_free_list(struct page *page, struct zone *zone,
 				    unsigned int order, int migratetype)
@@ -880,7 +943,10 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_move(&page->lru, &area->free_list[migratetype]);
+	if (preferred_rank(page))
+		list_move(&page->lru, &area->free_list[migratetype]);
+	else
+		list_move_tail(&page->lru, &area->free_list[migratetype]);
 }
 
 static inline void del_page_from_free_list(struct page *page, struct zone *zone,
@@ -1029,7 +1095,9 @@ static inline void __free_one_page(struct page *page,
 done_merging:
 	set_page_order(page, order);
 
-	if (is_shuffle_order(order))
+	if (preferred_rank_enabled())
+		to_tail = !__preferred_rank(page);
+	else if (is_shuffle_order(order))
 		to_tail = shuffle_pick_tail();
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
@@ -2257,20 +2325,29 @@ static __always_inline
 struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 						int migratetype)
 {
+	int retry = preferred_rank_enabled() ? 2 : 1;
 	unsigned int current_order;
 	struct free_area *area;
 	struct page *page;
 
-	/* Find a page of the appropriate size in the preferred list */
-	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = &(zone->free_area[current_order]);
-		page = get_page_from_free_area(area, migratetype);
-		if (!page)
-			continue;
-		del_page_from_free_list(page, zone, current_order);
-		expand(zone, page, order, current_order, migratetype);
-		set_pcppage_migratetype(page, migratetype);
-		return page;
+	while (retry-- > 0) {
+		/* Find a page of the appropriate size in the preferred list */
+		for (current_order = order; current_order < MAX_ORDER; ++current_order) {
+			area = &zone->free_area[current_order];
+			page = get_page_from_free_area(area, migratetype);
+			if (!page)
+				continue;
+			/*
+			 * In the first try, search for a page in the preferred
+			 * rank upward even though a free page is found.
+			 */
+			if (retry > 0 && !preferred_rank(page))
+				continue;
+			del_page_from_free_list(page, zone, current_order);
+			expand(zone, page, order, current_order, migratetype);
+			set_pcppage_migratetype(page, migratetype);
+			return page;
+		}
 	}
 
 	return NULL;
@@ -2851,8 +2928,14 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * head, thus also in the physical page order. This is useful
 		 * for IO devices that can merge IO requests if the physical
 		 * pages are ordered properly.
+		 * However, preferred_rank_enabled() is true, we always sort
+		 * freelists in the buddy and the pcp in the order of rank
+		 * number for the performance reason.
 		 */
-		list_add_tail(&page->lru, list);
+		if (preferred_rank_enabled() && __preferred_rank(page))
+			list_add(&page->lru, list);
+		else
+			list_add_tail(&page->lru, list);
 		alloced++;
 		if (is_migrate_cma(get_pcppage_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
@@ -3136,7 +3219,10 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 	}
 
 	pcp = &this_cpu_ptr(zone->pageset)->pcp;
-	list_add(&page->lru, &pcp->lists[migratetype]);
+	if (preferred_rank(page))
+		list_add(&page->lru, &pcp->lists[migratetype]);
+	else
+		list_add_tail(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
 	if (pcp->count >= pcp->high) {
 		unsigned long batch = READ_ONCE(pcp->batch);
@@ -8813,7 +8899,10 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			continue;
 
 		if (current_buddy != target) {
-			add_to_free_list(current_buddy, zone, high, migratetype);
+			if (preferred_rank(current_buddy))
+				add_to_free_list(current_buddy, zone, high, migratetype);
+			else
+				add_to_free_list_tail(current_buddy, zone, high, migratetype);
 			set_page_order(current_buddy, high);
 			page = next_page;
 		}
diff --git a/mm/shuffle.h b/mm/shuffle.h
index 71b784f..59cbfde 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -12,7 +12,8 @@ extern void __shuffle_free_memory(pg_data_t *pgdat);
 extern bool shuffle_pick_tail(void);
 static inline void shuffle_free_memory(pg_data_t *pgdat)
 {
-	if (!static_branch_unlikely(&page_alloc_shuffle_key))
+	if (!static_branch_unlikely(&page_alloc_shuffle_key) ||
+	    preferred_rank_enabled())
 		return;
 	__shuffle_free_memory(pgdat);
 }
@@ -20,7 +21,8 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
 extern void __shuffle_zone(struct zone *z);
 static inline void shuffle_zone(struct zone *z)
 {
-	if (!static_branch_unlikely(&page_alloc_shuffle_key))
+	if (!static_branch_unlikely(&page_alloc_shuffle_key) ||
+	    preferred_rank_enabled())
 		return;
 	__shuffle_zone(z);
 }
-- 
2.7.4

