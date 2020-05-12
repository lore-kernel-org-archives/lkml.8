Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A612CC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F7020643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgELEXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 00:23:49 -0400
Received: from foss.arm.com ([217.140.110.172]:46176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgELEXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 00:23:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74F8130E;
        Mon, 11 May 2020 21:23:48 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 354403F71E;
        Mon, 11 May 2020 21:23:43 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [RFC] mm/vmstat: Add events for THP migration without split
Date:   Tue, 12 May 2020 09:52:52 +0530
Message-Id: <1589257372-29576-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following new trace events which will help in validating migration
events involving PMD based THP pages.

1. THP_PMD_MIGRATION_ENTRY_SET
2. THP_PMD_MIGRATION_ENTRY_REMOVE

There are no clear method to confirm whether a THP migration happened with
out involving it's split. These trace events along with PGMIGRATE_SUCCESS
and PGMIGRATE_FAILURE will provide additional insights. After this change,

A single 2M THP (2K base page) when migrated

1. Without split

................
pgmigrate_success 1
pgmigrate_fail 0
................
thp_pmd_migration_entry_set 1
thp_pmd_migration_entry_remove 1
................

2. With split

................
pgmigrate_success 512
pgmigrate_fail 0
................
thp_pmd_migration_entry_set 0
thp_pmd_migration_entry_remove 0
................

pgmigrate_success as 1 instead of 512, provides a hint for possible THP
migration event. But then it gets mixed with normal page migrations over
time. These additional trace events provide required co-relation.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This is an indirect way for counting PMD migrations without split. Is there
a better method possible ? Just request for comments at the moment.

 include/linux/vm_event_item.h | 4 ++++
 mm/migrate.c                  | 1 +
 mm/rmap.c                     | 1 +
 mm/vmstat.c                   | 4 ++++
 4 files changed, 10 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index ffef0f279747..4b25102cf3ad 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -91,6 +91,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
 		THP_SWPOUT_FALLBACK,
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+		THP_PMD_MIGRATION_ENTRY_SET,
+		THP_PMD_MIGRATION_ENTRY_REMOVE,
+#endif
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 		BALLOON_INFLATE,
diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..8d50d55cbe97 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -228,6 +228,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		if (!pvmw.pte) {
 			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
 			remove_migration_pmd(&pvmw, new);
+			count_vm_event(THP_PMD_MIGRATION_ENTRY_REMOVE);
 			continue;
 		}
 #endif
diff --git a/mm/rmap.c b/mm/rmap.c
index f79a206b271a..3c1fe3f45cb5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1418,6 +1418,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
 
 			set_pmd_migration_entry(&pvmw, page);
+			count_vm_event(THP_PMD_MIGRATION_ENTRY_SET);
 			continue;
 		}
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 96d21a792b57..a5254b7ee531 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1274,6 +1274,10 @@ const char * const vmstat_text[] = {
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
 	"thp_swpout_fallback",
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+	"thp_pmd_migration_entry_set",
+	"thp_pmd_migration_entry_remove",
+#endif
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 	"balloon_inflate",
-- 
2.20.1

