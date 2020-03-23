Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FF2206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCWXnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:43:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:29269 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgCWXm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:42:57 -0400
IronPort-SDR: bTKt1x4yX7geieRmCJFywxJqKtmRPXcN/IIE6Ujy7tz8+nTf4AAD012xRuwDPaffjXqq4uJ5BR
 UNLu4D+heUHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:42:57 -0700
IronPort-SDR: qGvNp8CUfHC0zM/w341r3CUy9+naIO/mbxTvZor8nAWzxbgOi3Cr2ufZFwcCfQ5VR/1AoKU9Wk
 WovG6omAx5vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="239600815"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 23 Mar 2020 16:42:56 -0700
Subject: [PATCH 1/2] mm/madvise: help MADV_PAGEOUT to find swap cache pages
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, mhocko@suse.com,
        jannh@google.com, vbabka@suse.cz, minchan@kernel.org,
        dancol@google.com, joel@joelfernandes.org,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 23 Mar 2020 16:41:49 -0700
References: <20200323234147.558EBA81@viggo.jf.intel.com>
In-Reply-To: <20200323234147.558EBA81@viggo.jf.intel.com>
Message-Id: <20200323234149.9FE95081@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

tl;dr: MADV_PAGEOUT ignores unmapped swap cache pages.  Enable
MADV_PAGEOUT to find and reclaim swap cache.

The long story:

Looking for another issue, I wrote a simple test which had two
processes: a parent and a fork()'d child.  The parent reads a
memory buffer shared by the fork() and the child calls
madvise(MADV_PAGEOUT) on the same buffer.

The first call to MADV_PAGEOUT does what is expected: it pages
the memory out and causes faults in the parent.  However, after
that, it does not cause any faults in the parent.  MADV_PAGEOUT
only works once!  This was a surprise.

The PTEs in the shared buffer start out pte_present()==1 in
both parent and child.  The first MADV_PAGEOUT operation replaces
those with pte_present()==0 swap PTEs.  The parent process
quickly faults and recreates pte_present()==1.  However, the
child process (the one calling MADV_PAGEOUT) never touches the
memory and has retained the non-present swap PTEs.

This situation could also happen in the case where a single
process had some of its data placed in the swap cache but where
the memory has not yet been reclaimed.

The MADV_PAGEOUT code has a pte_present()==0 check.  It will
essentially ignore any pte_present()==0 pages.  This essentially
makes unmapped swap cache immune from MADV_PAGEOUT, which is not
very friendly behavior.

Enable MADV_PAGEOUT to find and reclaim swap cache.  Because
swap cache is not pinned by holding the PTE lock, a reference
must be held until the page is isolated, where a second
reference is obtained.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Daniel Colascione <dancol@google.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

 b/mm/madvise.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 11 deletions(-)

diff -puN mm/madvise.c~madv-pageout-find-swap-cache mm/madvise.c
--- a/mm/madvise.c~madv-pageout-find-swap-cache	2020-03-23 16:30:48.505385896 -0700
+++ b/mm/madvise.c	2020-03-23 16:30:48.509385896 -0700
@@ -250,6 +250,52 @@ static void force_shm_swapin_readahead(s
 #endif		/* CONFIG_SWAP */
 
 /*
+ * Given a PTE, find the corresponding 'struct page'
+ * and acquire a reference.  Also handles non-present
+ * swap PTEs.
+ *
+ * Returns NULL when there is no page to reclaim.
+ */
+static struct page *pte_get_reclaim_page(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t ptent)
+{
+	swp_entry_t entry;
+	struct page *page;
+
+	/* Totally empty PTE: */
+	if (pte_none(ptent))
+		return NULL;
+
+	/* Handle present or PROT_NONE ptes: */
+	if (!is_swap_pte(ptent)) {
+		page = vm_normal_page(vma, addr, ptent);
+		if (page)
+			get_page(page);
+		return page;
+	}
+
+	/*
+	 * 'ptent' is now definitely a (non-present) swap
+	 * PTE in this process.  Go look for additional
+	 * references to the swap cache.
+	 */
+
+	/*
+	 * Is it one of the "swap PTEs" that's not really
+	 * swap?  Do not try to reclaim those.
+	 */
+	entry = pte_to_swp_entry(ptent);
+	if (non_swap_entry(entry))
+		return NULL;
+
+	/*
+	 * The PTE was a true swap entry.  The page may be in
+	 * the swap cache.
+	 */
+	return lookup_swap_cache(entry, vma, addr);
+}
+
+/*
  * Schedule all required I/O operations.  Do not wait for completion.
  */
 static long madvise_willneed(struct vm_area_struct *vma,
@@ -398,13 +444,8 @@ regular_page:
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
 
-		if (pte_none(ptent))
-			continue;
-
-		if (!pte_present(ptent))
-			continue;
-
-		page = vm_normal_page(vma, addr, ptent);
+		/* 'page' can be mapped, in the swap cache or both */
+		page = pte_get_reclaim_page(vma, addr, ptent);
 		if (!page)
 			continue;
 
@@ -413,9 +454,10 @@ regular_page:
 		 * are sure it's worth. Split it if we are only owner.
 		 */
 		if (PageTransCompound(page)) {
-			if (page_mapcount(page) != 1)
+			if (page_mapcount(page) != 1) {
+				put_page(page);
 				break;
-			get_page(page);
+			}
 			if (!trylock_page(page)) {
 				put_page(page);
 				break;
@@ -436,12 +478,14 @@ regular_page:
 		}
 
 		/* Do not interfere with other mappings of this page */
-		if (page_mapcount(page) != 1)
+		if (page_mapcount(page) != 1) {
+			put_page(page);
 			continue;
+		}
 
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 
-		if (pte_young(ptent)) {
+		if (!is_swap_pte(ptent) && pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			ptent = pte_mkold(ptent);
@@ -466,6 +510,8 @@ regular_page:
 			}
 		} else
 			deactivate_page(page);
+		/* drop ref acquired in pte_get_reclaim_page() */
+		put_page(page);
 	}
 
 	arch_leave_lazy_mmu_mode();
_
