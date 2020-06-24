Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D23C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F32206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaLRGFBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404246AbgFXPCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404232AbgFXPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261BBC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so1165066plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GUNynxl8EV7sXCufCcmxBHs/J/t13PuDOABln2FP2HY=;
        b=QaLRGFBOpYLfo3KElRWDb/N+ZUOYT4JiTTQhQOp4UTbfOflbSHQqPwcS9I4EOVTs4G
         IUEaKFXTFCMnMbELCfL847hSUmfheSlrn5s9LKtNAmqVz9h1BYA+XRAufX67buBfRxkg
         NPI89RvIQb2BeudSjfAJB0SSznTuspk/iYVpH2HU4JZJ4Yy5cGPo+znfyPEPb9cvSz2n
         aiUhBmtNRwxHn59N3P6E+7UTN/4XBcFx8FWOQsRr1+Sb6/9WrGrhSZCOjDvI4repjLiG
         jRM+s4HSJ2GsID+YKnVCYuaB6xtTVthLNUeitf+T4/tLXNuiXeYeQqTbkDhn4zuDugU4
         LDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GUNynxl8EV7sXCufCcmxBHs/J/t13PuDOABln2FP2HY=;
        b=uB5upP/EU6UUpeQiY8fyC46fuuYmmYbKCkX0KRoaPoQ+pGyv2DWqGiyTJ+xxCREMWz
         HwEmbnYmln7zohkoC04xqcaNv+L09MFRswOHZ/OdD9q1+DVX0O7JZinfCZC96oang76h
         qoD8qHhH2vyBsPRDsK2MRGh96t9u8wWIsvoW136yN/hNyrs/oFLp+L7ho0/NFFiKj29N
         8AHR6+duG+w/VXpOqaNR7ZuG4O3RvYyYdAltqt6BykQ0DNIRS/UJRSL64UWVfFauUik3
         86fQxBcR2n8/Eo0Ljnj7Sgq2Drcd2umVADeyqdkny5VV6aZZejjPdmxn28Q2idOTumdS
         ZdcQ==
X-Gm-Message-State: AOAM532LSXLqT8rneag0ZgylapMrZgvEM/IVwCD2a2G9ZQ4pHlYiETay
        SdHfiKDUWofOd4ryCRvGQw==
X-Google-Smtp-Source: ABdhPJyTloXvGWvJr8+6caJEix7U+ixydVE9Wei2bf+99EFnkVXi+PNL0DCIucJrHmvE5Lq6WT3Kxw==
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr27771463pjz.106.1593010939488;
        Wed, 24 Jun 2020 08:02:19 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:18 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/15] mm,hwpoison: Rework soft offline for in-use pages
Date:   Wed, 24 Jun 2020 15:01:34 +0000
Message-Id: <20200624150137.7052-13-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
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
 mm/memory-failure.c        | 44 +++++++++++++-------------------------
 mm/migrate.c               | 11 +++-------
 mm/page_alloc.c            | 31 +++------------------------
 4 files changed, 21 insertions(+), 70 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/include/linux/page-flags.h v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/page-flags.h
index 9fa5d4e2d69a..d1df51ed6eeb 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/include/linux/page-flags.h
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/page-flags.h
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
 
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index d79e756a97be..f744eb90c15c 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -78,9 +78,12 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_dev_minor);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_mask);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
 
-static void page_handle_poison(struct page *page)
+static void page_handle_poison(struct page *page, bool release)
 {
+
 	SetPageHWPoison(page);
+	if (release)
+		put_page(page);
 	page_ref_inc(page);
 	num_poisoned_pages_inc();
 }
@@ -1757,19 +1760,13 @@ static int soft_offline_huge_page(struct page *page)
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
@@ -1804,10 +1801,8 @@ static int __soft_offline_page(struct page *page)
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
 
@@ -1838,7 +1833,9 @@ static int __soft_offline_page(struct page *page)
 		list_add(&page->lru, &pagelist);
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
 					MIGRATE_SYNC, MR_MEMORY_FAILURE);
-		if (ret) {
+		if (!ret) {
+			page_handle_poison(page, true);
+		} else {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
@@ -1857,27 +1854,16 @@ static int __soft_offline_page(struct page *page)
 static int soft_offline_in_use_page(struct page *page)
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
 		ret = soft_offline_huge_page(page);
 	else
 		ret = __soft_offline_page(page);
-	set_pageblock_migratetype(page, mt);
 	return ret;
 }
 
@@ -1886,7 +1872,7 @@ static int soft_offline_free_page(struct page *page)
 	int rc = -EBUSY;
 
 	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
-		page_handle_poison(page);
+		page_handle_poison(page, false);
 		rc = 0;
 	}
 
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/migrate.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/migrate.c
index c95912f74fe2..4381f76becee 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/migrate.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/migrate.c
@@ -1255,16 +1255,11 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		 */
 		if (newpage && PageTransHuge(newpage))
 			thp_pmd_migration_success(true);
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
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/page_alloc.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/page_alloc.c
index 3b145bceb477..5fbd28d63d60 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/page_alloc.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/page_alloc.c
@@ -1175,6 +1175,9 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
+	if (unlikely(PageHWPoison(page)) && !order)
+		return false;
+
 	trace_mm_page_free(page, order);
 
 	/*
@@ -8848,32 +8851,4 @@ bool take_page_off_buddy(struct page *page)
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

