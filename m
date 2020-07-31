Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1682087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB3ceEtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbgGaMWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733250AbgGaMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C5AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t15so7649239pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QPlYUvjeWvVBL7eDA2nj80d0sGUhuKmjuwt8TTwVLow=;
        b=XB3ceEtKeY5H0BjkXQ37Y9Hzzljzt+occHiPIBtgviD9f36lJftXuB8XwjANaqvQuk
         oSw005EB2A29R1jpV2j+vMFVukOI+3ZkqHoWqtHW1UN6M0WyWmHajr2JIcGmCbCwf626
         QP2V0UKtQfe4GZUT5zQzziOU3krN5Q/NDnaahCa9nl6tkvOKOiKs56WdBBrffyJzCPbJ
         Rr5rnskzsjTWAhJTeqTl0JmIU3BdIx/8siQ88ygwNA9Z5dk6eGJBKa9SpnFQXrmAbuCG
         A6Kdb3ncSplGXAQCqoAL0UVVzMsMq6cwdvGLON6+KVC5uDAVSv/O7L6LWRo/eBo4CxoT
         sa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QPlYUvjeWvVBL7eDA2nj80d0sGUhuKmjuwt8TTwVLow=;
        b=fy29EpF+UKS+6w44fikYpyR+IjM5WQ0mxEsKVi5VF2Ssg08KzujyKf2RiuR8sTudxO
         6Uy88NGtYF2P4v1dnNS9kpAVQ6wg11Mnl4fR1Qr3Bu3Xu49doQ5DDLCf14T5BS6/btdH
         xtBdtJhpFHPEOYuvT0DL26d2L7KufgGNjkRyjA2Navhu7oQ3ZHAIuWt4ZlR83RuOrN8s
         seBnTMD7evn4sunf8HO1buSts2KXvcJC6ivpY08Y530QVRlvwFFSWXfuHyQcQHPlCCPF
         c86ius858srA9ZfuX44V4i6+SQR0nlCDzSdJrvx63Kd+NpYVALWzd9LjmqdwqjsA96H6
         Meeg==
X-Gm-Message-State: AOAM533PL1Z5HYr55CMbs8sfbcM8i1N73KvGCSBovGAmMBTHbjYFz2Jb
        BFqWqSqZVAiqyrtFJNTZcQ==
X-Google-Smtp-Source: ABdhPJzCgOZxNhkOz6v7ITO/5ijG4IHOgYTdeRbIc4Ulqfc5wi7veJkR1RGeu/hjJORoAogP7ZH0UA==
X-Received: by 2002:a17:90b:11c4:: with SMTP id gv4mr3769770pjb.198.1596198118096;
        Fri, 31 Jul 2020 05:21:58 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:57 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/16] mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
Date:   Fri, 31 Jul 2020 12:21:09 +0000
Message-Id: <20200731122112.11263-14-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
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
ChangeLog v4 -> v5:
- use "char const *msg_page[]" instead of "const char *msg_page[]"
- move adding drain_all_pages() to 12/16

ChangeLog v2 -> v3:
- use page_is_file_lru() instead of page_is_file_cache(),
- add description about put_page() and drain_all_pages().
- fix coding style warnings by checkpatch.pl
---
 mm/memory-failure.c | 177 ++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 97 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 291084e27ead..904dec64da6b 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -65,15 +65,33 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
-static void page_handle_poison(struct page *page, bool release)
+static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
 {
 	if (release) {
 		put_page(page);
 		drain_all_pages(page_zone(page));
 	}
+
+	if (hugepage_or_freepage) {
+		/*
+		 * Doing this check for free pages is also fine since dissolve_free_huge_page
+		 * returns 0 for non-hugetlb pages as well.
+		 */
+		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
+			/*
+			 * We could fail to take off the target page from buddy
+			 * for example due to racy page allocaiton, but that's
+			 * acceptable because soft-offlined page is not broken
+			 * and if someone really want to use it, they should
+			 * take it.
+			 */
+			return false;
+	}
+
 	SetPageHWPoison(page);
 	page_ref_inc(page);
 	num_poisoned_pages_inc();
+	return true;
 }
 
 #if defined(CONFIG_HWPOISON_INJECT) || defined(CONFIG_HWPOISON_INJECT_MODULE)
@@ -1712,63 +1730,52 @@ static int get_any_page(struct page *page, unsigned long pfn)
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
+	char const *msg_page[] = {"page", "hugepage"};
+	bool huge = PageHuge(page);
+	LIST_HEAD(pagelist);
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
@@ -1781,98 +1788,74 @@ static int __soft_offline_page(struct page *page)
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
 		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
 			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
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

