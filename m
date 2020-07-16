Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AAAC43457
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F267207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGPMjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:39:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:35962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgGPMie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46831B941;
        Thu, 16 Jul 2020 12:38:37 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, mike.kravetz@oracle.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.com>
Subject: [PATCH v4 09/15] mm,hwpoison: remove flag argument from soft offline functions
Date:   Thu, 16 Jul 2020 14:38:03 +0200
Message-Id: <20200716123810.25292-10-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200716123810.25292-1-osalvador@suse.de>
References: <20200716123810.25292-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

The argument @flag no longer affects the behavior of soft_offline_page()
and its variants, so let's remove them.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.com>
---
 drivers/base/memory.c |  2 +-
 include/linux/mm.h    |  2 +-
 mm/madvise.c          |  2 +-
 mm/memory-failure.c   | 27 +++++++++++++--------------
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 2b09b68b9f78..20664f279c99 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -463,7 +463,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	ret = soft_offline_page(pfn, 0);
+	ret = soft_offline_page(pfn);
 	return ret == 0 ? count : ret;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e2ce2f05fa49..8f6a45165ec8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3011,7 +3011,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(unsigned long pfn, int flags);
+extern int soft_offline_page(unsigned long pfn);
 
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index dd2173d8f4e5..226f0fcf0828 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -927,7 +927,7 @@ static int madvise_inject_error(int behavior,
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
 
-			ret = soft_offline_page(pfn, 0);
+			ret = soft_offline_page(pfn);
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 15b8e7fd94ed..03d3aae77f89 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1502,7 +1502,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(entry.pfn, entry.flags);
+			soft_offline_page(entry.pfn);
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1648,7 +1648,7 @@ static struct page *new_page(struct page *p, unsigned long private)
  * that is not free, and 1 for any other page type.
  * For 1 the page is returned with increased page count, otherwise not.
  */
-static int __get_any_page(struct page *p, unsigned long pfn, int flags)
+static int __get_any_page(struct page *p, unsigned long pfn)
 {
 	int ret;
 
@@ -1675,9 +1675,9 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int get_any_page(struct page *page, unsigned long pfn, int flags)
+static int get_any_page(struct page *page, unsigned long pfn)
 {
-	int ret = __get_any_page(page, pfn, flags);
+	int ret = __get_any_page(page, pfn);
 
 	if (ret == 1 && !PageHuge(page) &&
 	    !PageLRU(page) && !__PageMovable(page)) {
@@ -1690,7 +1690,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		/*
 		 * Did it turn free?
 		 */
-		ret = __get_any_page(page, pfn, 0);
+		ret = __get_any_page(page, pfn);
 		if (ret == 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
 			put_page(page);
@@ -1702,7 +1702,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page, int flags)
+static int soft_offline_huge_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1761,7 +1761,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	return ret;
 }
 
-static int __soft_offline_page(struct page *page, int flags)
+static int __soft_offline_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1841,7 +1841,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	return ret;
 }
 
-static int soft_offline_in_use_page(struct page *page, int flags)
+static int soft_offline_in_use_page(struct page *page)
 {
 	int ret;
 	int mt;
@@ -1871,9 +1871,9 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 	mt = get_pageblock_migratetype(page);
 	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
-		ret = soft_offline_huge_page(page, flags);
+		ret = soft_offline_huge_page(page);
 	else
-		ret = __soft_offline_page(page, flags);
+		ret = __soft_offline_page(page);
 	set_pageblock_migratetype(page, mt);
 	return ret;
 }
@@ -1894,7 +1894,6 @@ static int soft_offline_free_page(struct page *page)
 /**
  * soft_offline_page - Soft offline a page.
  * @pfn: pfn to soft-offline
- * @flags: flags. Same as memory_failure().
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1913,7 +1912,7 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(unsigned long pfn, int flags)
+int soft_offline_page(unsigned long pfn)
 {
 	int ret;
 	struct page *page;
@@ -1931,11 +1930,11 @@ int soft_offline_page(unsigned long pfn, int flags)
 	}
 
 	get_online_mems();
-	ret = get_any_page(page, pfn, flags);
+	ret = get_any_page(page, pfn);
 	put_online_mems();
 
 	if (ret > 0)
-		ret = soft_offline_in_use_page(page, flags);
+		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
 		ret = soft_offline_free_page(page);
 
-- 
2.26.2

