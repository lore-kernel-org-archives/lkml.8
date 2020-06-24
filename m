Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B56C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BDE2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLG1GV1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404256AbgFXPC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404241AbgFXPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19748C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so1552936pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kHsJMTyrzGs/lMla3mx1ITOEfxJev53X7nb3oA+rEkM=;
        b=CLG1GV1DsEigRZMeWoVq0PQGyE0P9pnkkp16DsSuPJjTZ88qosmUXKaw/UshA2rUin
         JjGRjRUDlBDaoZTCkWmQsQWwD+h2so/vHqeeBb2uFauv+K6JOl2EQDewJK83Af5xy3Mt
         WzyidjOLhJW72hE82Ikbsi9mbzF7uQ9xtWwJgO/CQySQcZ99GGTL+IdtzmFR039pZbxq
         8gJhvt+A0agagm2CqrO92jbJwhhgPLExL8dR0XEpUkcZe9JfIgYFTKELV3m4i4hi8/ng
         oH20Mg5hMUp4HcVl6yP0pCV3yHtqWSxj4izzU3s0uX8mbYoOPSt0Q9tnGRYMN50vtRwS
         y6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kHsJMTyrzGs/lMla3mx1ITOEfxJev53X7nb3oA+rEkM=;
        b=m4PHie/aHREWk8uYIHGcRSHnGDXTubyYAlbsYEd64gmdxoik8wIsRrvMnViLNZhvUr
         n/RYgZ1MAa9+5o5HEiI60zo39Lp9VasZlDw1ZWSyW8d1w/R0NwXSlpE1YRJNh+bVjrDZ
         06mX2/OH3srRSUdw8DjY0hLRgb1nh1DBqaSdPG78VNzyh5Kh7Bh8jRMScgZnU/MhM7K2
         mMIV5I5GQaDz7fYGVog2kZcNwXBJEgztR8/sGkQAMUxorqzOQR5Or1D24gyeLEh0Pbzw
         BnM4mkCEJpkhyiLFcswYu24DObpO/bPUC7EjWqyV8c980X3HudDijfybZ8LqCUtEVB14
         dccg==
X-Gm-Message-State: AOAM530e+v2cTvSz2ykGiWVeiDFuremts1fps/6sU4saJ47qfKcW3OMF
        9hkoL7cnKt/8B/pLSN+ejw==
X-Google-Smtp-Source: ABdhPJyVcH1CLgJOJlA115WQq27melIISXx96Q/p3lqjSymZwNPjBcIAe1+YUVrGwwbNsRcL4r3PXg==
X-Received: by 2002:a65:4807:: with SMTP id h7mr22759246pgs.123.1593010942497;
        Wed, 24 Jun 2020 08:02:22 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:22 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
Date:   Wed, 24 Jun 2020 15:01:35 +0000
Message-Id: <20200624150137.7052-14-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Merging soft_offline_huge_page and __soft_offline_page let us get rid of
quite some duplicated code, and makes the code much easier to follow.

Now, __soft_offline_page will handle both normal and hugetlb pages.

Note that move put_page() block to the beginning of page_handle_poison()
with drain_all_pages() in order to make sure that the target page is
freed and sent into free list to make take_page_off_buddy() work properly.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog v2 -> v3:
- use page_is_file_lru() instead of page_is_file_cache(),
- add description about put_page() and drain_all_pages().
- fix coding style warnings by checkpatch.pl
---
 mm/memory-failure.c | 185 ++++++++++++++++++++------------------------
 1 file changed, 86 insertions(+), 99 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index f744eb90c15c..22c904f6d17a 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -78,14 +78,36 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_dev_minor);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_mask);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
 
-static void page_handle_poison(struct page *page, bool release)
+static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
 {
+	if (release) {
+		put_page(page);
+		drain_all_pages(page_zone(page));
+	}
+
+	if (hugepage_or_freepage) {
+		/*
+		 * Doing this check for free pages is also fine since dissolve_free_huge_page
+		 * returns 0 for non-hugetlb pages as well.
+		 */
+		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
+		/*
+		 * The hugetlb page can end up being enqueued back into
+		 * the freelists by means of:
+		 * unmap_and_move_huge_page
+		 *  putback_active_hugepage
+		 *   put_page->free_huge_page
+		 *    enqueue_huge_page
+		 * If this happens, we might lose the race against an allocation.
+		 */
+			return false;
+	}
 
 	SetPageHWPoison(page);
-	if (release)
-		put_page(page);
 	page_ref_inc(page);
 	num_poisoned_pages_inc();
+
+	return true;
 }
 
 static int hwpoison_filter_dev(struct page *p)
@@ -1718,63 +1740,52 @@ static int get_any_page(struct page *page, unsigned long pfn)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page)
+static bool isolate_page(struct page *page, struct list_head *pagelist)
 {
-	int ret;
-	unsigned long pfn = page_to_pfn(page);
-	struct page *hpage = compound_head(page);
-	LIST_HEAD(pagelist);
+	bool isolated = false;
+	bool lru = PageLRU(page);
+
+	if (PageHuge(page)) {
+		isolated = isolate_huge_page(page, pagelist);
+	} else {
+		if (lru)
+			isolated = !isolate_lru_page(page);
+		else
+			isolated = !isolate_movable_page(page, ISOLATE_UNEVICTABLE);
+
+		if (isolated)
+			list_add(&page->lru, pagelist);
 
-	/*
-	 * This double-check of PageHWPoison is to avoid the race with
-	 * memory_failure(). See also comment in __soft_offline_page().
-	 */
-	lock_page(hpage);
-	if (PageHWPoison(hpage)) {
-		unlock_page(hpage);
-		put_page(hpage);
-		pr_info("soft offline: %#lx hugepage already poisoned\n", pfn);
-		return -EBUSY;
 	}
-	unlock_page(hpage);
 
-	ret = isolate_huge_page(hpage, &pagelist);
+	if (isolated && lru)
+		inc_node_page_state(page, NR_ISOLATED_ANON +
+				    page_is_file_lru(page));
+
 	/*
-	 * get_any_page() and isolate_huge_page() takes a refcount each,
-	 * so need to drop one here.
+	 * If we succeed to isolate the page, we grabbed another refcount on
+	 * the page, so we can safely drop the one we got from get_any_pages().
+	 * If we failed to isolate the page, it means that we cannot go further
+	 * and we will return an error, so drop the reference we got from
+	 * get_any_pages() as well.
 	 */
-	put_page(hpage);
-	if (!ret) {
-		pr_info("soft offline: %#lx hugepage failed to isolate\n", pfn);
-		return -EBUSY;
-	}
-
-	ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-				MIGRATE_SYNC, MR_MEMORY_FAILURE);
-	if (ret) {
-		pr_info("soft offline: %#lx: hugepage migration failed %d, type %lx (%pGp)\n",
-			pfn, ret, page->flags, &page->flags);
-		if (!list_empty(&pagelist))
-			putback_movable_pages(&pagelist);
-		if (ret > 0)
-			ret = -EIO;
-	} else {
-		/*
-		 * We set PG_hwpoison only when we were able to take the page
-		 * off the buddy.
-		 */
-		if (!dissolve_free_huge_page(page) && take_page_off_buddy(page))
-			page_handle_poison(page, false);
-		else
-			ret = -EBUSY;
-	}
-	return ret;
+	put_page(page);
+	return isolated;
 }
 
+/*
+ * __soft_offline_page handles hugetlb-pages and non-hugetlb pages.
+ * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
+ * If the page is mapped, it migrates the contents over.
+ */
 static int __soft_offline_page(struct page *page)
 {
-	int ret;
+	int ret = 0;
 	unsigned long pfn = page_to_pfn(page);
+	struct page *hpage = compound_head(page);
+	const char *msg_page[] = {"page", "hugepage"};
+	bool huge = PageHuge(page);
+	LIST_HEAD(pagelist);
 
 	/*
 	 * Check PageHWPoison again inside page lock because PageHWPoison
@@ -1783,98 +1794,74 @@ static int __soft_offline_page(struct page *page)
 	 * so there's no race between soft_offline_page() and memory_failure().
 	 */
 	lock_page(page);
-	wait_on_page_writeback(page);
+	if (!PageHuge(page))
+		wait_on_page_writeback(page);
 	if (PageHWPoison(page)) {
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		return -EBUSY;
 	}
-	/*
-	 * Try to invalidate first. This should work for
-	 * non dirty unmapped page cache pages.
-	 */
-	ret = invalidate_inode_page(page);
+
+	if (!PageHuge(page))
+		/*
+		 * Try to invalidate first. This should work for
+		 * non dirty unmapped page cache pages.
+		 */
+		ret = invalidate_inode_page(page);
 	unlock_page(page);
+
 	/*
 	 * RED-PEN would be better to keep it isolated here, but we
 	 * would need to fix isolation locking first.
 	 */
-	if (ret == 1) {
+	if (ret) {
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
-		page_handle_poison(page, true);
+		page_handle_poison(page, false, true);
 		return 0;
 	}
 
-	/*
-	 * Simple invalidation didn't work.
-	 * Try to migrate to a new page instead. migrate.c
-	 * handles a large number of cases for us.
-	 */
-	if (PageLRU(page))
-		ret = isolate_lru_page(page);
-	else
-		ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
-	/*
-	 * Drop page reference which is came from get_any_page()
-	 * successful isolate_lru_page() already took another one.
-	 */
-	put_page(page);
-	if (!ret) {
-		LIST_HEAD(pagelist);
-		/*
-		 * After isolated lru page, the PageLRU will be cleared,
-		 * so use !__PageMovable instead for LRU page's mapping
-		 * cannot have PAGE_MAPPING_MOVABLE.
-		 */
-		if (!__PageMovable(page))
-			inc_node_page_state(page, NR_ISOLATED_ANON +
-						page_is_file_lru(page));
-		list_add(&page->lru, &pagelist);
+	if (isolate_page(hpage, &pagelist)) {
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
 					MIGRATE_SYNC, MR_MEMORY_FAILURE);
 		if (!ret) {
-			page_handle_poison(page, true);
+			bool release = !huge;
+
+			if (!page_handle_poison(page, true, release))
+				ret = -EBUSY;
 		} else {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
-			pr_info("soft offline: %#lx: migration failed %d, type %lx (%pGp)\n",
-				pfn, ret, page->flags, &page->flags);
+
+			pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
+				pfn, msg_page[huge], ret, page->flags, &page->flags);
 			if (ret > 0)
 				ret = -EIO;
 		}
 	} else {
-		pr_info("soft offline: %#lx: isolation failed: %d, page count %d, type %lx (%pGp)\n",
-			pfn, ret, page_count(page), page->flags, &page->flags);
+		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
+			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
 	}
 	return ret;
 }
 
 static int soft_offline_in_use_page(struct page *page)
 {
-	int ret;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
 		if (try_to_split_thp_page(page, "soft offline") < 0)
 			return -EBUSY;
-
-	if (PageHuge(page))
-		ret = soft_offline_huge_page(page);
-	else
-		ret = __soft_offline_page(page);
-	return ret;
+	return __soft_offline_page(page);
 }
 
 static int soft_offline_free_page(struct page *page)
 {
-	int rc = -EBUSY;
+	int rc = 0;
 
-	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
-		page_handle_poison(page, false);
-		rc = 0;
-	}
+	if (!page_handle_poison(page, true, false))
+		rc = -EBUSY;
 
 	return rc;
 }
-- 
2.17.1

