Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09571C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FC5206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGIJk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:40:26 -0400
Received: from foss.arm.com ([217.140.110.172]:46544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGIJkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:40:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D7AE31B;
        Thu,  9 Jul 2020 02:40:24 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.88.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0F333F887;
        Thu,  9 Jul 2020 02:40:19 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4] mm/vmstat: Add events for THP migration without split
Date:   Thu,  9 Jul 2020 15:09:43 +0530
Message-Id: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add following new vmstat events which will help in validating THP migration
without split. Statistics reported through these new VM events will help in
performance debugging.

1. THP_MIGRATION_SUCCESS
2. THP_MIGRATION_FAIL
3. THP_MIGRATION_SPLIT

In addition, these new events also update normal page migration statistics
appropriately via PGMIGRATE_SUCCESS and PGMIGRATE_FAIL. While here, this
updates current trace event 'mm_migrate_pages' to accommodate now available
THP statistics.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Applies on 5.8-rc4.

Changes in V4:

- Changed THP_MIGRATION_FAILURE as THP_MIGRATION_FAIL per John
- Dropped all conditional 'if' blocks in migrate_pages() per Andrew and John
- Updated migration events documentation per John
- Updated thp_nr_pages variable as nr_subpages for an expected merge conflict
- Moved all new THP vmstat events into CONFIG_MIGRATION
- Updated Cc list with Documentation/ and tracing related addresses

Changes in V3: (https://patchwork.kernel.org/patch/11647237/)

- Formatted new events documentation with 'fmt' tool per Matthew
- Made events universally available i.e dropped ARCH_ENABLE_THP_MIGRATION
- Added THP_MIGRATION_SPLIT
- Updated trace_mm_migrate_pages() with THP events
- Made THP events update normal page migration events as well

Changes in V2: (https://patchwork.kernel.org/patch/11586893/)

- Dropped PMD reference both from code and commit message per Matthew
- Added documentation and updated the commit message per Daniel

Changes in V1: (https://patchwork.kernel.org/patch/11564497/)

- Changed function name as thp_pmd_migration_success() per John
- Folded in a fix (https://patchwork.kernel.org/patch/11563009/) from Hugh

Changes in RFC V2: (https://patchwork.kernel.org/patch/11554861/)

- Decopupled and renamed VM events from their implementation per Zi and John
- Added THP_PMD_MIGRATION_FAILURE VM event upon allocation failure and split

Changes in RFC V1: (https://patchwork.kernel.org/patch/11542055/)

 Documentation/vm/page_migration.rst | 27 +++++++++++++++
 include/linux/vm_event_item.h       |  3 ++
 include/trace/events/migrate.h      | 17 ++++++++--
 mm/migrate.c                        | 52 ++++++++++++++++++++++++-----
 mm/vmstat.c                         |  3 ++
 5 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
index 1d6cd7db4e43..68883ac485fa 100644
--- a/Documentation/vm/page_migration.rst
+++ b/Documentation/vm/page_migration.rst
@@ -253,5 +253,32 @@ which are function pointers of struct address_space_operations.
      PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
      for own purpose.
 
+Monitoring Migration
+=====================
+
+The following events (counters) can be used to monitor page migration.
+
+1. PGMIGRATE_SUCCESS: Normal page migration success. Each count means that a
+   page was migrated. If the page was a non-THP page, then this counter is
+   increased by one. If the page was a THP, then this counter is increased by
+   the number of THP subpages. For example, migration of a single 2MB THP that
+   has 4KB-size base pages (subpages) will cause this counter to increase by
+   512.
+
+2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules as for
+   _SUCCESS, above: this will be increased by the number of subpages, if it was
+   a THP.
+
+3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.
+
+4. THP_MIGRATION_FAIL: A THP could not be migrated nor it could be split.
+
+5. THP_MIGRATION_SPLIT: A THP was migrated, but not as such: first, the THP had
+   to be split. After splitting, a migration retry was used for it's sub-pages.
+
+THP_MIGRATION_* events also update the appropriate PGMIGRATE_SUCCESS or
+PGMIGRATE_FAIL events. For example, a THP migration failure will cause both
+THP_MIGRATION_FAIL and PGMIGRATE_FAIL to increase.
+
 Christoph Lameter, May 8, 2006.
 Minchan Kim, Mar 28, 2016.
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 24fc7c3ae7d6..2e6ca53b9bbd 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -56,6 +56,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
+		THP_MIGRATION_SUCCESS,
+		THP_MIGRATION_FAIL,
+		THP_MIGRATION_SPLIT,
 #endif
 #ifdef CONFIG_COMPACTION
 		COMPACTMIGRATE_SCANNED, COMPACTFREE_SCANNED,
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 705b33d1e395..4d434398d64d 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -46,13 +46,18 @@ MIGRATE_REASON
 TRACE_EVENT(mm_migrate_pages,
 
 	TP_PROTO(unsigned long succeeded, unsigned long failed,
-		 enum migrate_mode mode, int reason),
+		 unsigned long thp_succeeded, unsigned long thp_failed,
+		 unsigned long thp_split, enum migrate_mode mode, int reason),
 
-	TP_ARGS(succeeded, failed, mode, reason),
+	TP_ARGS(succeeded, failed, thp_succeeded, thp_failed,
+		thp_split, mode, reason),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,		succeeded)
 		__field(	unsigned long,		failed)
+		__field(	unsigned long,		thp_succeeded)
+		__field(	unsigned long,		thp_failed)
+		__field(	unsigned long,		thp_split)
 		__field(	enum migrate_mode,	mode)
 		__field(	int,			reason)
 	),
@@ -60,13 +65,19 @@ TRACE_EVENT(mm_migrate_pages,
 	TP_fast_assign(
 		__entry->succeeded	= succeeded;
 		__entry->failed		= failed;
+		__entry->thp_succeeded	= thp_succeeded;
+		__entry->thp_failed	= thp_failed;
+		__entry->thp_split	= thp_split;
 		__entry->mode		= mode;
 		__entry->reason		= reason;
 	),
 
-	TP_printk("nr_succeeded=%lu nr_failed=%lu mode=%s reason=%s",
+	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu mode=%s reason=%s",
 		__entry->succeeded,
 		__entry->failed,
+		__entry->thp_succeeded,
+		__entry->thp_failed,
+		__entry->thp_split,
 		__print_symbolic(__entry->mode, MIGRATE_MODE),
 		__print_symbolic(__entry->reason, MIGRATE_REASON))
 );
diff --git a/mm/migrate.c b/mm/migrate.c
index f37729673558..c706e3576cfc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1429,22 +1429,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		enum migrate_mode mode, int reason)
 {
 	int retry = 1;
+	int thp_retry = 1;
 	int nr_failed = 0;
 	int nr_succeeded = 0;
+	int nr_thp_succeeded = 0;
+	int nr_thp_failed = 0;
+	int nr_thp_split = 0;
 	int pass = 0;
+	bool is_thp = false;
 	struct page *page;
 	struct page *page2;
 	int swapwrite = current->flags & PF_SWAPWRITE;
-	int rc;
+	int rc, nr_subpages;
 
 	if (!swapwrite)
 		current->flags |= PF_SWAPWRITE;
 
-	for(pass = 0; pass < 10 && retry; pass++) {
+	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
 		retry = 0;
+		thp_retry = 0;
 
 		list_for_each_entry_safe(page, page2, from, lru) {
 retry:
+			/*
+			 * THP statistics is based on the source huge page.
+			 * Capture required information that might get lost
+			 * during migration.
+			 */
+			is_thp = PageTransHuge(page);
+			nr_subpages = hpage_nr_pages(page);
 			cond_resched();
 
 			if (PageHuge(page))
@@ -1475,15 +1488,30 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					unlock_page(page);
 					if (!rc) {
 						list_safe_reset_next(page, page2, lru);
+						nr_thp_split++;
 						goto retry;
 					}
 				}
+				if (is_thp) {
+					nr_thp_failed++;
+					nr_failed += nr_subpages;
+					goto out;
+				}
 				nr_failed++;
 				goto out;
 			case -EAGAIN:
+				if (is_thp) {
+					thp_retry++;
+					break;
+				}
 				retry++;
 				break;
 			case MIGRATEPAGE_SUCCESS:
+				if (is_thp) {
+					nr_thp_succeeded++;
+					nr_succeeded += nr_subpages;
+					break;
+				}
 				nr_succeeded++;
 				break;
 			default:
@@ -1493,19 +1521,27 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * removed from migration page list and not
 				 * retried in the next outer loop.
 				 */
+				if (is_thp) {
+					nr_thp_failed++;
+					nr_failed += nr_subpages;
+					break;
+				}
 				nr_failed++;
 				break;
 			}
 		}
 	}
-	nr_failed += retry;
+	nr_failed += retry + thp_retry;
+	nr_thp_failed += thp_retry;
 	rc = nr_failed;
 out:
-	if (nr_succeeded)
-		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
-	if (nr_failed)
-		count_vm_events(PGMIGRATE_FAIL, nr_failed);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
+	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
+	count_vm_events(PGMIGRATE_FAIL, nr_failed);
+	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
+	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
+	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
+	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
+			       nr_thp_failed, nr_thp_split, mode, reason);
 
 	if (!swapwrite)
 		current->flags &= ~PF_SWAPWRITE;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3fb23a21f6dd..09914a4bfee4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1234,6 +1234,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
 	"pgmigrate_fail",
+	"thp_migration_success",
+	"thp_migration_fail",
+	"thp_migration_split",
 #endif
 #ifdef CONFIG_COMPACTION
 	"compact_migrate_scanned",
-- 
2.20.1

