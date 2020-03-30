Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396DDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C94A2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgC3GwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:52:00 -0400
Received: from foss.arm.com ([217.140.110.172]:45210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbgC3GwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:52:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C581A1FB;
        Sun, 29 Mar 2020 23:51:59 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FA673F71E;
        Sun, 29 Mar 2020 23:56:00 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] mm/page_alloc: Enumerate bad page reasons
Date:   Mon, 30 Mar 2020 12:21:37 +0530
Message-Id: <1585551097-27283-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enumerate all existing bad page reasons which can be used in bad_page() for
reporting via __dump_page(). Unfortunately __dump_page() cannot be changed.
__dump_page() is called from dump_page() that accepts a raw string and is
also an exported symbol that is currently being used from various generic
memory functions and other drivers. This reduces code duplication while
reporting bad pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Boot tested on arm64 and x86 platforms (next-20200327) but has been built
tested on many other platforms.

 include/linux/memory.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c        | 40 ++++++++++++++++++++--------------------
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index 7914b0dbd4bb..b2fb90fda537 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -82,6 +82,42 @@ struct memory_notify {
 struct notifier_block;
 struct mem_section;
 
+/*
+ * Bad page reasons
+ */
+enum page_bad_reason {
+	PAGE_BAD_NONZERO_MAPCOUNT,
+	PAGE_BAD_NONZERO_REFCOUNT,
+	PAGE_BAD_NONNULL_MAPPING,
+	PAGE_BAD_FREE_FLAGS,
+	PAGE_BAD_PREP_FLAGS,
+	PAGE_BAD_CGROUP_CHARGED,
+	PAGE_BAD_HWPOISON,
+	PAGE_BAD_TAIL_CORRUPTED,
+	PAGE_BAD_TAIL_NOT_SET,
+	PAGE_BAD_COMPOUND_HEAD,
+	PAGE_BAD_COMPOUND_MAPCOUNT,
+};
+
+static const char *const page_bad_names[] = {
+	[PAGE_BAD_NONZERO_MAPCOUNT]  = "non-zero mapcout",
+	[PAGE_BAD_NONZERO_REFCOUNT]  = "non-zero _refcount",
+	[PAGE_BAD_NONNULL_MAPPING]   = "non-NULL mapping",
+	[PAGE_BAD_FREE_FLAGS]        = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set",
+	[PAGE_BAD_PREP_FLAGS]        = "PAGE_FLAGS_CHECK_AT_PREP flag(s) set",
+	[PAGE_BAD_CGROUP_CHARGED]    = "page still charged to cgroup",
+	[PAGE_BAD_HWPOISON]          = "HWPoisoned (hardware-corrupted)",
+	[PAGE_BAD_TAIL_CORRUPTED]    = "corrupted mapping in tail page",
+	[PAGE_BAD_TAIL_NOT_SET]      = "PageTail not set",
+	[PAGE_BAD_COMPOUND_HEAD]     = "compound_head not consistent",
+	[PAGE_BAD_COMPOUND_MAPCOUNT] = "non-zero compound_mapcount",
+};
+
+static inline const char *get_page_bad(int reason)
+{
+	return page_bad_names[reason];
+}
+
 /*
  * Priorities for the hotplug memory callback routines (stored in decreasing
  * order in the callback chain)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ca1453204e66..0f05da0fdc9a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -68,6 +68,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/memory.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -609,7 +610,7 @@ static inline int __maybe_unused bad_range(struct zone *zone, struct page *page)
 }
 #endif
 
-static void bad_page(struct page *page, const char *reason,
+static void bad_page(struct page *page, int reason,
 		unsigned long bad_flags)
 {
 	static unsigned long resume;
@@ -638,7 +639,7 @@ static void bad_page(struct page *page, const char *reason,
 
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
 		current->comm, page_to_pfn(page));
-	__dump_page(page, reason);
+	__dump_page(page, get_page_bad(reason));
 	bad_flags &= page->flags;
 	if (bad_flags)
 		pr_alert("bad because of flags: %#lx(%pGp)\n",
@@ -1079,25 +1080,24 @@ static inline bool page_expected_state(struct page *page,
 
 static void free_pages_check_bad(struct page *page)
 {
-	const char *bad_reason;
+	int bad_reason;
 	unsigned long bad_flags;
 
-	bad_reason = NULL;
 	bad_flags = 0;
 
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
-		bad_reason = "nonzero mapcount";
+		bad_reason = PAGE_BAD_NONZERO_MAPCOUNT;
 	if (unlikely(page->mapping != NULL))
-		bad_reason = "non-NULL mapping";
+		bad_reason = PAGE_BAD_NONNULL_MAPPING;
 	if (unlikely(page_ref_count(page) != 0))
-		bad_reason = "nonzero _refcount";
+		bad_reason = PAGE_BAD_NONZERO_REFCOUNT;
 	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
-		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
+		bad_reason = PAGE_BAD_FREE_FLAGS;
 		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
 	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
-		bad_reason = "page still charged to cgroup";
+		bad_reason = PAGE_BAD_CGROUP_CHARGED;
 #endif
 	bad_page(page, bad_reason, bad_flags);
 }
@@ -1130,7 +1130,7 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 	case 1:
 		/* the first tail page: ->mapping may be compound_mapcount() */
 		if (unlikely(compound_mapcount(page))) {
-			bad_page(page, "nonzero compound_mapcount", 0);
+			bad_page(page, PAGE_BAD_COMPOUND_MAPCOUNT, 0);
 			goto out;
 		}
 		break;
@@ -1142,17 +1142,17 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 		break;
 	default:
 		if (page->mapping != TAIL_MAPPING) {
-			bad_page(page, "corrupted mapping in tail page", 0);
+			bad_page(page, PAGE_BAD_TAIL_CORRUPTED, 0);
 			goto out;
 		}
 		break;
 	}
 	if (unlikely(!PageTail(page))) {
-		bad_page(page, "PageTail not set", 0);
+		bad_page(page, PAGE_BAD_TAIL_NOT_SET, 0);
 		goto out;
 	}
 	if (unlikely(compound_head(page) != head_page)) {
-		bad_page(page, "compound_head not consistent", 0);
+		bad_page(page, PAGE_BAD_COMPOUND_HEAD, 0);
 		goto out;
 	}
 	ret = 0;
@@ -2110,29 +2110,29 @@ static inline void expand(struct zone *zone, struct page *page,
 
 static void check_new_page_bad(struct page *page)
 {
-	const char *bad_reason = NULL;
+	int bad_reason;
 	unsigned long bad_flags = 0;
 
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
-		bad_reason = "nonzero mapcount";
+		bad_reason = PAGE_BAD_NONZERO_MAPCOUNT;
 	if (unlikely(page->mapping != NULL))
-		bad_reason = "non-NULL mapping";
+		bad_reason = PAGE_BAD_NONNULL_MAPPING;
 	if (unlikely(page_ref_count(page) != 0))
-		bad_reason = "nonzero _refcount";
+		bad_reason = PAGE_BAD_NONZERO_REFCOUNT;
 	if (unlikely(page->flags & __PG_HWPOISON)) {
-		bad_reason = "HWPoisoned (hardware-corrupted)";
+		bad_reason = PAGE_BAD_HWPOISON;
 		bad_flags = __PG_HWPOISON;
 		/* Don't complain about hwpoisoned pages */
 		page_mapcount_reset(page); /* remove PageBuddy */
 		return;
 	}
 	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_PREP)) {
-		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
+		bad_reason = PAGE_BAD_PREP_FLAGS;
 		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
 	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
-		bad_reason = "page still charged to cgroup";
+		bad_reason = PAGE_BAD_CGROUP_CHARGED;
 #endif
 	bad_page(page, bad_reason, bad_flags);
 }
-- 
2.20.1

