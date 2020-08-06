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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9E322D07
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dag3wQDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgHFSt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgHFStz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3757C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so17607411pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iOnU5DPTFBCJZrA4qYHBhE1N2Tyk26DBmuGxhFL9n1g=;
        b=Dag3wQDFd+V8irlHhdwBYMJYcyJMuI37lHSRSLvaxjHpwKtmho7dSkKdTg749ieFjj
         4fWWddqSv+QxU4JnoI+c7m847PsEn1+CdNnqnPk2py55YDzW/R3KXsmQ+/LTy/wbJhWb
         COeVSbisnMV1uywrKpNn4Rz6Rer/DZNHnHCnHKPahAhp2ul5k3oMxkde8ZE0oRe/aeJx
         YbPt9zBv/mmztlIP+WJ5NliJiGJzeVjCMAdM08crWVLJEiOBh4nsaZqf4ZQpgGJlm9qo
         5JB2yDRY5M+4QHjalTdEHFElzXw8e9qRA7msU3Y50rwvLguG1wYIATPyr7NWi5EaRod0
         0zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iOnU5DPTFBCJZrA4qYHBhE1N2Tyk26DBmuGxhFL9n1g=;
        b=ikHhICGpdI6DLSDfGLvghHHGKqkGgOxU2dpaPtmPZA44n93kLJUD5D2cS2RKsNa+1b
         QMT2USk/++KJ0CrbYIiU28islTJ5dE5o8bdwJOsdTGWSjd8QTXx4MszIavrCCRw/eLR5
         lHFEpu8JCgL6khtDdDsGamXOF/dqBvJJidlNg1jiyP9XASQLnhug811SBXQmuZhq0Cc1
         FPevaIG7kUnDHtUZsi6SFskIncCjbMnxFO1qE8OpaWBDnBYqUPVvcA6PNcK74SZroie1
         sYVW2J+X8u8/YD45cxiuEGuNubRdLwQDEYD8VDapPJpPHwimqAEvJafHN1Y3TGFZU/hD
         aidg==
X-Gm-Message-State: AOAM530W6kAMa9nMJkE0w1OZiDsm1PO/WOWCkGxLdrxBouAZatsuYX19
        zVWDBBAClXrU+NgZ6TZyOg==
X-Google-Smtp-Source: ABdhPJw4YUpZ0RT9qBcliQ2izOnsbFPf8GMpwdFvZDBi6HblTGsyJ/O/36XXVEg1clIuKrmT01apzQ==
X-Received: by 2002:a17:90a:b24:: with SMTP id 33mr1965843pjq.123.1596739794337;
        Thu, 06 Aug 2020 11:49:54 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:53 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/12] mm,hwpoison: Rework soft offline for in-use pages
Date:   Thu,  6 Aug 2020 18:49:19 +0000
Message-Id: <20200806184923.7007-9-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patch changes the way we set and handle in-use poisoned pages.
Until now, poisoned pages were released to the buddy allocator, trusting
that the checks that take place prior to hand the page would act as a
safe net and would skip that page.

This has proved to be wrong, as we got some pfn walkers out there, like
compaction, that all they care is the page to be PageBuddy and be in a
freelist.
Although this might not be the only user, having poisoned pages
in the buddy allocator seems a bad idea as we should only have
free pages that are ready and meant to be used as such.

Before explaining the taken approach, let us break down the kind
of pages we can soft offline.

- Anonymous THP (after the split, they end up being 4K pages)
- Hugetlb
- Order-0 pages (that can be either migrated or invalited)

* Normal pages (order-0 and anon-THP)

  - If they are clean and unmapped page cache pages, we invalidate
    then by means of invalidate_inode_page().
  - If they are mapped/dirty, we do the isolate-and-migrate dance.

  Either way, do not call put_page directly from those paths.
  Instead, we keep the page and send it to page_set_poison to perform the
  right handling.

  page_set_poison sets the HWPoison flag and does the last put_page.
  This call to put_page is mainly to be able to call __page_cache_release,
  since this function is not exported.

  Down the chain, we placed a check for HWPoison page in
  free_pages_prepare, that just skips any poisoned page, so those pages
  do not end up in any pcplist/freelist.

  After that, we set the refcount on the page to 1 and we increment
  the poisoned pages counter.

  We could do as we do for free pages:
  1) wait until the page hits buddy's freelists
  2) take it off
  3) flag it

  The problem is that we could race with an allocation, so by the time we
  want to take the page off the buddy, the page is already allocated, so we
  cannot soft-offline it.
  This is not fatal of course, but if it is better if we can close the race
  as does not require a lot of code.

* Hugetlb pages

  - We isolate-and-migrate them

  After the migration has been successful, we call dissolve_free_huge_page,
  and we set HWPoison on the page if we succeed.
  Hugetlb has a slightly different handling though.

  While for non-hugetlb pages we cared about closing the race with an
  allocation, doing so for hugetlb pages requires quite some additional
  code (we would need to hook in free_huge_page and some other places).
  So I decided to not make the code overly complicated and just fail
  normally if the page we allocated in the meantime.

Because of the way we handle now in-use pages, we no longer need the
put-as-isolation-migratetype dance, that was guarding for poisoned pages
to end up in pcplists.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/page-flags.h |  5 -----
 mm/memory-failure.c        | 45 ++++++++++++++------------------------
 mm/migrate.c               | 11 +++-------
 mm/page_alloc.c            | 28 ------------------------
 4 files changed, 19 insertions(+), 70 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/page-flags.h v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/page-flags.h
index 9fa5d4e2d69a..d1df51ed6eeb 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/page-flags.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/page-flags.h
@@ -422,14 +422,9 @@ PAGEFLAG_FALSE(Uncached)
 PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
-extern bool set_hwpoison_free_buddy_page(struct page *page);
 extern bool take_page_off_buddy(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
-static inline bool set_hwpoison_free_buddy_page(struct page *page)
-{
-	return 0;
-}
 #define __PG_HWPOISON 0
 #endif
 
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 0e619012e050..95bf8aa44a9a 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -65,8 +65,12 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
-static void page_handle_poison(struct page *page)
+static void page_handle_poison(struct page *page, bool release)
 {
+	if (release) {
+		put_page(page);
+		drain_all_pages(page_zone(page));
+	}
 	SetPageHWPoison(page);
 	page_ref_inc(page);
 	num_poisoned_pages_inc();
@@ -1756,19 +1760,13 @@ static int soft_offline_huge_page(struct page *page, int flags)
 			ret = -EIO;
 	} else {
 		/*
-		 * We set PG_hwpoison only when the migration source hugepage
-		 * was successfully dissolved, because otherwise hwpoisoned
-		 * hugepage remains on free hugepage list, then userspace will
-		 * find it as SIGBUS by allocation failure. That's not expected
-		 * in soft-offlining.
+		 * We set PG_hwpoison only when we were able to take the page
+		 * off the buddy.
 		 */
-		ret = dissolve_free_huge_page(page);
-		if (!ret) {
-			if (set_hwpoison_free_buddy_page(page))
-				num_poisoned_pages_inc();
-			else
-				ret = -EBUSY;
-		}
+		if (!dissolve_free_huge_page(page) && take_page_off_buddy(page))
+			page_handle_poison(page, false);
+		else
+			ret = -EBUSY;
 	}
 	return ret;
 }
@@ -1807,10 +1805,8 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * would need to fix isolation locking first.
 	 */
 	if (ret == 1) {
-		put_page(page);
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
-		SetPageHWPoison(page);
-		num_poisoned_pages_inc();
+		page_handle_poison(page, true);
 		return 0;
 	}
 
@@ -1841,7 +1837,9 @@ static int __soft_offline_page(struct page *page, int flags)
 		list_add(&page->lru, &pagelist);
 		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
 			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
-		if (ret) {
+		if (!ret) {
+			page_handle_poison(page, true);
+		} else {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
@@ -1860,27 +1858,16 @@ static int __soft_offline_page(struct page *page, int flags)
 static int soft_offline_in_use_page(struct page *page, int flags)
 {
 	int ret;
-	int mt;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
 		if (try_to_split_thp_page(page, "soft offline") < 0)
 			return -EBUSY;
 
-	/*
-	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
-	 * to free list immediately (not via pcplist) when released after
-	 * successful page migration. Otherwise we can't guarantee that the
-	 * page is really free after put_page() returns, so
-	 * set_hwpoison_free_buddy_page() highly likely fails.
-	 */
-	mt = get_pageblock_migratetype(page);
-	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
 		ret = soft_offline_huge_page(page, flags);
 	else
 		ret = __soft_offline_page(page, flags);
-	set_pageblock_migratetype(page, mt);
 	return ret;
 }
 
@@ -1889,7 +1876,7 @@ static int soft_offline_free_page(struct page *page)
 	int rc = -EBUSY;
 
 	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
-		page_handle_poison(page);
+		page_handle_poison(page, false);
 		rc = 0;
 	}
 
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/migrate.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/migrate.c
index 2c809ffcf0e1..d7a9379c343b 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/migrate.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/migrate.c
@@ -1222,16 +1222,11 @@ static int unmap_and_move(new_page_t get_new_page,
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		put_page(page);
-		if (reason == MR_MEMORY_FAILURE) {
+		if (reason != MR_MEMORY_FAILURE)
 			/*
-			 * Set PG_HWPoison on just freed page
-			 * intentionally. Although it's rather weird,
-			 * it's how HWPoison flag works at the moment.
+			 * We release the page in page_handle_poison.
 			 */
-			if (set_hwpoison_free_buddy_page(page))
-				num_poisoned_pages_inc();
-		}
+			put_page(page);
 	} else {
 		if (rc != -EAGAIN) {
 			if (likely(!__PageMovable(page))) {
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/page_alloc.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/page_alloc.c
index aab89f7db4ac..e4896e674594 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/page_alloc.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/page_alloc.c
@@ -8843,32 +8843,4 @@ bool take_page_off_buddy(struct page *page)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
-
-/*
- * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
- * test is performed under the zone lock to prevent a race against page
- * allocation.
- */
-bool set_hwpoison_free_buddy_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-	unsigned long pfn = page_to_pfn(page);
-	unsigned long flags;
-	unsigned int order;
-	bool hwpoisoned = false;
-
-	spin_lock_irqsave(&zone->lock, flags);
-	for (order = 0; order < MAX_ORDER; order++) {
-		struct page *page_head = page - (pfn & ((1 << order) - 1));
-
-		if (PageBuddy(page_head) && page_order(page_head) >= order) {
-			if (!TestSetPageHWPoison(page))
-				hwpoisoned = true;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&zone->lock, flags);
-
-	return hwpoisoned;
-}
 #endif
-- 
2.17.1

