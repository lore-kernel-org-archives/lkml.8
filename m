Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86862224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP5znRnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgHFSuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgHFSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24216C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so27431044pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c2Avd1ymuet/tH9gLpxvYhCg3U4qIQ401CWXw7mzKrk=;
        b=lP5znRnSs48Jr045ixAGYtn2xK/GiZjXZl94MmV7kuyp5exJCHElM0MORvJTQRSuB/
         CKqSLJZ49AgIbdLeprP1EtMrMdXwBepaHPSwnBDsIhmwbiKUVTgJGfZrVulrdKM65RVK
         dB3/q90xqRCkSyclslMfMkE9Su/3Leqx8Oj5dP52p/z1MCgQ6XCfJBKwTiJcVMkbUv0C
         Ny3yGwfok7w6IPt080R3wRq4OFw3BxI/aH62v2qj2IHVgoA9UrLmiH012hR668iNlPbr
         uiuwtk/cf6M3JL6Tv8TQxkqDc2fIwbSCuD4npmibQoMpCj2Yll/U4i3UyyANIscqc6Ws
         bqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c2Avd1ymuet/tH9gLpxvYhCg3U4qIQ401CWXw7mzKrk=;
        b=QR8Pp/iUahvH7bsLEvr2ICC/w8jPNnAZRfQkh0+f7eph9BAfFK+iVTz6BmYKxZLtpU
         6Ugtkqg/8QovL9l15+3WsBB88qEmiKD7QoAWBKLEtTPzCFy0A/qZ7sex3JXfE+U25Emw
         f/kIcs+Uds49gjtPt1auNmBDIWezBxAtGaWyLH0oobxOgPq7wH973KU+et4thzDUMsMM
         5f97FPmrmEOUDGprfM0vLbwJn1aA4mXRt/6IZt96HHWSBYySY3TZ6d9vZGZMRdyfvh+9
         2U23/vUyaWmA8gLexF7n5wZgxtbGDupDr+zbCiPRka4xFmfveYTlZoy3p15t6gxjkhXt
         jdRA==
X-Gm-Message-State: AOAM532LymlzLwSXP4IjnBNPy7JnJShH1gQ8fhV3e4ENZZWOnnZl4h83
        i8ZNcXR5exNSbZH3hZlsjA==
X-Google-Smtp-Source: ABdhPJxZ3HPx90oxIcIH1ZufFl69P8/nuFLdp3UnE6QWQUH3yfI1SEa7pGjN1nRAh4hl+FVlUzdqCw==
X-Received: by 2002:a62:7ac2:: with SMTP id v185mr9681664pfc.277.1596739797598;
        Thu, 06 Aug 2020 11:49:57 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:57 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/12] mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
Date:   Thu,  6 Aug 2020 18:49:20 +0000
Message-Id: <20200806184923.7007-10-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
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
 mm/memory-failure.c | 183 ++++++++++++++++++++------------------------
 1 file changed, 83 insertions(+), 100 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 95bf8aa44a9a..3a2cd094b77f 100644
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
@@ -1718,63 +1736,52 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page, int flags)
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
 
-static int __soft_offline_page(struct page *page, int flags)
+/*
+ * __soft_offline_page handles hugetlb-pages and non-hugetlb pages.
+ * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
+ * If the page is mapped, it migrates the contents over.
+ */
+static int __soft_offline_page(struct page *page)
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
@@ -1787,98 +1794,74 @@ static int __soft_offline_page(struct page *page, int flags)
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
 
-static int soft_offline_in_use_page(struct page *page, int flags)
+static int soft_offline_in_use_page(struct page *page)
 {
-	int ret;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
 		if (try_to_split_thp_page(page, "soft offline") < 0)
 			return -EBUSY;
-
-	if (PageHuge(page))
-		ret = soft_offline_huge_page(page, flags);
-	else
-		ret = __soft_offline_page(page, flags);
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
@@ -1929,7 +1912,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	put_online_mems();
 
 	if (ret > 0)
-		ret = soft_offline_in_use_page(page, flags);
+		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
 		ret = soft_offline_free_page(page);
 
-- 
2.17.1

