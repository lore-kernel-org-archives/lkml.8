Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8340C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941FE20748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgEVDet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:34:49 -0400
Received: from foss.arm.com ([217.140.110.172]:57226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgEVDet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:34:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B827431B;
        Thu, 21 May 2020 20:34:48 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.76.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 447883F305;
        Thu, 21 May 2020 20:34:46 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     hughd@google.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmstat: Add events for PMD based THP migration without split
Date:   Fri, 22 May 2020 09:04:04 +0530
Message-Id: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following two new VM events which will help in validating PMD
based THP migration without split. Statistics reported through these events
will help in performance debugging.

1. THP_PMD_MIGRATION_SUCCESS
2. THP_PMD_MIGRATION_FAILURE

Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
[hughd: fixed oops on NULL newpage]
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V1:

- Changed function name as thp_pmd_migration_success() per John
- Folded in a fix (https://patchwork.kernel.org/patch/11563009/) from Hugh

Changes in RFC V2: (https://patchwork.kernel.org/patch/11554861/)

- Decopupled and renamed VM events from their implementation per Zi and John
- Added THP_PMD_MIGRATION_FAILURE VM event upon allocation failure and split

Changes in RFC V1: (https://patchwork.kernel.org/patch/11542055/)

 include/linux/vm_event_item.h |  4 ++++
 mm/migrate.c                  | 23 +++++++++++++++++++++++
 mm/vmstat.c                   |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index ffef0f279747..23d8f9884c2b 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -91,6 +91,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
 		THP_SWPOUT_FALLBACK,
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+		THP_PMD_MIGRATION_SUCCESS,
+		THP_PMD_MIGRATION_FAILURE,
+#endif
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 		BALLOON_INFLATE,
diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..37f30bcfd628 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1170,6 +1170,20 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 #define ICE_noinline
 #endif
 
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+static inline void thp_pmd_migration_success(bool success)
+{
+	if (success)
+		count_vm_event(THP_PMD_MIGRATION_SUCCESS);
+	else
+		count_vm_event(THP_PMD_MIGRATION_FAILURE);
+}
+#else
+static inline void thp_pmd_migration_success(bool success)
+{
+}
+#endif
+
 /*
  * Obtain the lock on page, remove all ptes and migrate the page
  * to the newly allocated page in newpage.
@@ -1232,6 +1246,14 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
+		/*
+		 * When the page to be migrated has been freed from under
+		 * us, that is considered a MIGRATEPAGE_SUCCESS, but no
+		 * newpage has been allocated. It should not be counted
+		 * as a successful THP migration.
+		 */
+		if (newpage && PageTransHuge(newpage))
+			thp_pmd_migration_success(true);
 		put_page(page);
 		if (reason == MR_MEMORY_FAILURE) {
 			/*
@@ -1474,6 +1496,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					unlock_page(page);
 					if (!rc) {
 						list_safe_reset_next(page, page2, lru);
+						thp_pmd_migration_success(false);
 						goto retry;
 					}
 				}
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 96d21a792b57..e258c782fd3a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1274,6 +1274,10 @@ const char * const vmstat_text[] = {
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
 	"thp_swpout_fallback",
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+	"thp_pmd_migration_success",
+	"thp_pmd_migration_failure",
+#endif
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 	"balloon_inflate",
-- 
2.20.1

