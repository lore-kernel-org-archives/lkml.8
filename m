Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC5C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A01920753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCWXnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:43:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:40316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCWXm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:42:59 -0400
IronPort-SDR: 4TII6rjMw2CH8kRXiWLqm7JcssNxlUJkHWUiUQI/HxseifN2Ju1tra/NydgBjJnoqDeDU2ZNSE
 MaaXCbJOYYkA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:42:59 -0700
IronPort-SDR: p7wHP0E9cCVis6ujH7VlrAKm8YZPl0C4TIq9c60LiPT3dJzR1QTeK0Fua8V62w6YKfvNaTzfX6
 h1mg9ix2Jfag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419682388"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 16:42:58 -0700
Subject: [PATCH 2/2] mm/madvise: skip MADV_PAGEOUT on shared swap cache pages
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, mhocko@suse.com,
        jannh@google.com, vbabka@suse.cz, minchan@kernel.org,
        dancol@google.com, joel@joelfernandes.org,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 23 Mar 2020 16:41:51 -0700
References: <20200323234147.558EBA81@viggo.jf.intel.com>
In-Reply-To: <20200323234147.558EBA81@viggo.jf.intel.com>
Message-Id: <20200323234151.10AF5617@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

MADV_PAGEOUT might interfere with other processes if it is
allowed to reclaim pages shared with other processses.  A
previous patch tried to avoid this for anonymous pages
which were shared by a fork().  It did this by checking
page_mapcount().

That works great for mapped pages.  But, it can not detect
unmapped swap cache pages.  This has not been a problem,
until the previous patch which added the ability for
MADV_PAGEOUT to *find* swap cache pages.

A process doing MADV_PAGEOUT which finds an unmapped swap
cache page and evicts it might interfere with another process
which had the same page mapped.  But, such a page would have
a page_mapcount() of 1 since the page is only actually mapped
in the *other* process.  The page_mapcount() test would fail
to detect the situation.

Thankfully, there is a reference count for swap entries.
To fix this, simply consult both page_mapcount() and the swap
reference count via page_swapcount().

I rigged up a little test program to try to create these
situations.  Basically, if the parent "reader" RSS changes
in response to MADV_PAGEOUT actions in the child, there is
a problem.

	https://www.sr71.net/~dave/intel/madv-pageout.c

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Daniel Colascione <dancol@google.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

 b/mm/madvise.c |   37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff -puN mm/madvise.c~madv-pageout-ignore-shared-swap-cache mm/madvise.c
--- a/mm/madvise.c~madv-pageout-ignore-shared-swap-cache	2020-03-23 16:30:52.022385888 -0700
+++ b/mm/madvise.c	2020-03-23 16:41:15.448384333 -0700
@@ -261,6 +261,7 @@ static struct page *pte_get_reclaim_page
 {
 	swp_entry_t entry;
 	struct page *page;
+	int nr_page_references = 0;
 
 	/* Totally empty PTE: */
 	if (pte_none(ptent))
@@ -271,7 +272,7 @@ static struct page *pte_get_reclaim_page
 		page = vm_normal_page(vma, addr, ptent);
 		if (page)
 			get_page(page);
-		return page;
+		goto got_page;
 	}
 
 	/*
@@ -292,7 +293,33 @@ static struct page *pte_get_reclaim_page
 	 * The PTE was a true swap entry.  The page may be in
 	 * the swap cache.
 	 */
-	return lookup_swap_cache(entry, vma, addr);
+	page = lookup_swap_cache(entry, vma, addr);
+	if (!page)
+		return NULL;
+got_page:
+	/*
+	 * Account for references to the swap entry.  These
+	 * might be "upgraded" to a normal mapping at any
+	 * time.
+	 */
+	if (PageSwapCache(page))
+		nr_page_references += page_swapcount(page);
+
+	/*
+	 * Account for all mappings of the page, including
+	 * when it is in the swap cache.  This ensures that
+	 * MADV_PAGOUT not interfere with anything shared
+	 * with another process.
+	 */
+	nr_page_references += page_mapcount(page);
+
+	/* Any extra references?  Do not reclaim it. */
+	if (nr_page_references > 1) {
+		put_page(page);
+		return NULL;
+	}
+
+	return page;
 }
 
 /*
@@ -477,12 +504,6 @@ regular_page:
 			continue;
 		}
 
-		/* Do not interfere with other mappings of this page */
-		if (page_mapcount(page) != 1) {
-			put_page(page);
-			continue;
-		}
-
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 
 		if (!is_swap_pte(ptent) && pte_young(ptent)) {
_
