Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E48C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D07520679
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgFDECE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:02:04 -0400
Received: from foss.arm.com ([217.140.110.172]:39950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgFDECE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:02:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F2D55D;
        Wed,  3 Jun 2020 21:02:03 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.78.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCBF03F6CF;
        Wed,  3 Jun 2020 21:01:59 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     hughd@google.com, daniel.m.jordan@oracle.com, willy@infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/vmstat: Add events for THP migration without split
Date:   Thu,  4 Jun 2020 09:30:45 +0530
Message-Id: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following new VM events which will help in validating THP migration
without split. Statistics reported through these new events will help in
performance debugging.

1. THP_MIGRATION_SUCCESS
2. THP_MIGRATION_FAILURE

THP_MIGRATION_FAILURE in particular represents an event when a THP could
not be migrated as a single entity following an allocation failure and
ended up getting split into constituent normal pages before being retried.
This event, along with PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in
quantifying and analyzing THP migration events including both success and
failure cases.

Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
[hughd: fixed oops on NULL newpage]
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Dropped PMD reference both from code and commit message per Matthew
- Added documentation and updated the commit message per Daniel

Changes in V1: (https://patchwork.kernel.org/patch/11564497/)

- Changed function name as thp_pmd_migration_success() per John
- Folded in a fix (https://patchwork.kernel.org/patch/11563009/) from Hugh

Changes in RFC V2: (https://patchwork.kernel.org/patch/11554861/)

- Decopupled and renamed VM events from their implementation per Zi and John
- Added THP_PMD_MIGRATION_FAILURE VM event upon allocation failure and split

Changes in RFC V1: (https://patchwork.kernel.org/patch/11542055/)

 Documentation/vm/page_migration.rst | 15 +++++++++++++++
 include/linux/vm_event_item.h       |  4 ++++
 mm/migrate.c                        | 23 +++++++++++++++++++++++
 mm/vmstat.c                         |  4 ++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
index 1d6cd7db4e43..67e9b067fed7 100644
--- a/Documentation/vm/page_migration.rst
+++ b/Documentation/vm/page_migration.rst
@@ -253,5 +253,20 @@ which are function pointers of struct address_space_operations.
      PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
      for own purpose.
 
+Quantifying Migration
+=====================
+Following events can be used to quantify page migration.
+
+- PGMIGRATE_SUCCESS
+- PGMIGRATE_FAIL
+- THP_MIGRATION_SUCCESS
+- THP_MIGRATION_FAILURE
+
+THP_MIGRATION_FAILURE in particular represents an event when a THP could not be
+migrated as a single entity following an allocation failure and ended up getting
+split into constituent normal pages before being retried. This event, along with
+PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and analyzing THP
+migration events including both success and failure cases.
+
 Christoph Lameter, May 8, 2006.
 Minchan Kim, Mar 28, 2016.
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index ffef0f279747..6459265461df 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -91,6 +91,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
 		THP_SWPOUT_FALLBACK,
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+		THP_MIGRATION_SUCCESS,
+		THP_MIGRATION_FAILURE,
+#endif
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 		BALLOON_INFLATE,
diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..0bb1dbb891bb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1170,6 +1170,20 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 #define ICE_noinline
 #endif
 
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+static inline void thp_migration_success(bool success)
+{
+	if (success)
+		count_vm_event(THP_MIGRATION_SUCCESS);
+	else
+		count_vm_event(THP_MIGRATION_FAILURE);
+}
+#else
+static inline void thp_migration_success(bool success)
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
+			thp_migration_success(true);
 		put_page(page);
 		if (reason == MR_MEMORY_FAILURE) {
 			/*
@@ -1474,6 +1496,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					unlock_page(page);
 					if (!rc) {
 						list_safe_reset_next(page, page2, lru);
+						thp_migration_success(false);
 						goto retry;
 					}
 				}
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 96d21a792b57..4ce1ab2e9704 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1274,6 +1274,10 @@ const char * const vmstat_text[] = {
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
 	"thp_swpout_fallback",
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+	"thp_migration_success",
+	"thp_migration_failure",
+#endif
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 	"balloon_inflate",
-- 
2.20.1

