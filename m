Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7995C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A92222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a48cfcMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgB0EG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:06:56 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33439 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgB0EG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:06:56 -0500
Received: by mail-pf1-f173.google.com with SMTP id n7so921536pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 20:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=K44v4WdoumEJk1/WBeNAEHkbegFJCvzfu3JNHZN30yk=;
        b=a48cfcMlHVlcHuap8OST8KTBjqWyXyWHF9TwBIjO1ccH6dcND12zVT6ad6wl9X7M0c
         mjfP0mUGYFFN+bnO2/BtKsBVNSEJNrguNrm599Gzo3ZP5spgXEea57lY7dYc1exYY4Yj
         6q5s4GZv0vNDVQK6AFt+s/+yv5FcjES+wLj/hL1+y/E87O65WvU4Tg8m2Yt9qL44XXwN
         gztOmVzpGgEfueou7TCxLr5l8h0y63d8iewzgoAcjl/dDjp8j1Lj2mjSEGcBstQwnZAi
         w/dBtxbydSUXw3FnAeIyIrenA4/b7GJKN1JBt1Acs85wd5oorOqdrMMSh9AJMGj2b13m
         HAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=K44v4WdoumEJk1/WBeNAEHkbegFJCvzfu3JNHZN30yk=;
        b=cICKVaYTIMxsHFQEMF10vGxF/3v2EWjT/o+wZAhAVuibG8WQep4JN8znhfbM8fMZHX
         1QeBafZ8fJa2JV0O3vy8JJ1PJre6FLpdCCofRIwqq3B8rctlrc+r+oB1GUPFfq72jVH8
         RDsQAcuT682HXb5XdBo+mwiOpbLyGWlEqYPb0Tlw0bZCfiFyevfK1okcw0T2e3JzK79T
         lW5iLh07ogrLkNViowP++kvBKRhtR2w52Ej16ZBizTWs8poUKCTUH8qiOFCgdp/frgMi
         GxWWlNG8NSt8W9YaJWEBoKjs3hOgCUs5Z3x5v2ypPtTS7XjJfW6Nq7Nkc7+tu9rsqWTC
         pGmQ==
X-Gm-Message-State: APjAAAVn2F49iCkMZtdbbhCHBStvHX4u7qRdkKOUPZD29ntJP1BRXYCA
        eYEI3wsnm58F6x3CHoXvArMUBg==
X-Google-Smtp-Source: APXvYqyXGkgB1NgAJbGQBgunozIYtHC7RAQ/ZpaOA3sx8UM3+Gxv1O1h5ZvT8tUcaibJ2cInm4Xdkw==
X-Received: by 2002:a63:450b:: with SMTP id s11mr1981040pga.45.1582776412718;
        Wed, 26 Feb 2020 20:06:52 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id z27sm4913806pfj.107.2020.02.26.20.06.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 20:06:51 -0800 (PST)
Date:   Wed, 26 Feb 2020 20:06:33 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] huge tmpfs: try to split_huge_page() when punching hole
Message-ID: <alpine.LSU.2.11.2002261959020.10801@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi writes:

Currently, when truncating a shmem file, if the range is partly in a THP
(start or end is in the middle of THP), the pages actually will just get
cleared rather than being freed, unless the range covers the whole THP.
Even though all the subpages are truncated (randomly or sequentially),
the THP may still be kept in page cache.

This might be fine for some usecases which prefer preserving THP, but
balloon inflation is handled in base page size.  So when using shmem THP
as memory backend, QEMU inflation actually doesn't work as expected since
it doesn't free memory.  But the inflation usecase really needs to get
the memory freed.  (Anonymous THP will also not get freed right away,
but will be freed eventually when all subpages are unmapped: whereas
shmem THP still stays in page cache.)

Split THP right away when doing partial hole punch, and if split fails
just clear the page so that read of the punched area will return zeroes.

Hugh Dickins adds:

Our earlier "team of pages" huge tmpfs implementation worked in the way
that Yang Shi proposes; and we have been using this patch to continue to
split the huge page when hole-punched or truncated, since converting over
to the compound page implementation.  Although huge tmpfs gives out huge
pages when available, if the user specifically asks to truncate or punch
a hole (perhaps to free memory, perhaps to reduce the memcg charge), then
the filesystem should do so as best it can, splitting the huge page.

That is not always possible: any additional reference to the huge page
prevents split_huge_page() from succeeding, so the result can be flaky.
But in practice it works successfully enough that we've not seen any
problem from that.

Add shmem_punch_compound() to encapsulate the decision of when a split
is needed, and doing the split if so.  Using this simplifies the flow in
shmem_undo_range(); and the first (trylock) pass does not need to do any
page clearing on failure, because the second pass will either succeed or
do that clearing.  Following the example of zero_user_segment() when
clearing a partial page, add flush_dcache_page() and set_page_dirty()
when clearing a hole - though I'm not certain that either is needed.

But: split_huge_page() would be sure to fail if shmem_undo_range()'s
pagevec holds further references to the huge page.  The easiest way to
fix that is for find_get_entries() to return early, as soon as it has
put one compound head or tail into the pagevec.  At first this felt
like a hack; but on examination, this convention better suits all its
callers - or will do, if the slight one-page-per-pagevec slowdown in
shmem_unlock_mapping() and shmem_seek_hole_data() is transformed into
a 512-page-per-pagevec speedup by checking for compound pages there.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/filemap.c |   14 ++++++-
 mm/shmem.c   |   98 +++++++++++++++++++++----------------------------
 mm/swap.c    |    4 ++
 3 files changed, 60 insertions(+), 56 deletions(-)

--- 5.6-rc3/mm/filemap.c	2020-02-09 17:36:41.758976480 -0800
+++ linux/mm/filemap.c	2020-02-25 20:08:13.178755732 -0800
@@ -1697,6 +1697,11 @@ EXPORT_SYMBOL(pagecache_get_page);
  * Any shadow entries of evicted pages, or swap entries from
  * shmem/tmpfs, are included in the returned array.
  *
+ * If it finds a Transparent Huge Page, head or tail, find_get_entries()
+ * stops at that page: the caller is likely to have a better way to handle
+ * the compound page as a whole, and then skip its extent, than repeatedly
+ * calling find_get_entries() to return all its tails.
+ *
  * Return: the number of pages and shadow entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping,
@@ -1728,8 +1733,15 @@ unsigned find_get_entries(struct address
 		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
-		page = find_subpage(page, xas.xa_index);
 
+		/*
+		 * Terminate early on finding a THP, to allow the caller to
+		 * handle it all at once; but continue if this is hugetlbfs.
+		 */
+		if (PageTransHuge(page) && !PageHuge(page)) {
+			page = find_subpage(page, xas.xa_index);
+			nr_entries = ret + 1;
+		}
 export:
 		indices[ret] = xas.xa_index;
 		entries[ret] = page;
--- 5.6-rc3/mm/shmem.c	2020-02-09 17:36:41.798976778 -0800
+++ linux/mm/shmem.c	2020-02-25 20:08:13.182755758 -0800
@@ -789,6 +789,32 @@ void shmem_unlock_mapping(struct address
 }
 
 /*
+ * Check whether a hole-punch or truncation needs to split a huge page,
+ * returning true if no split was required, or the split has been successful.
+ *
+ * Eviction (or truncation to 0 size) should never need to split a huge page;
+ * but in rare cases might do so, if shmem_undo_range() failed to trylock on
+ * head, and then succeeded to trylock on tail.
+ *
+ * A split can only succeed when there are no additional references on the
+ * huge page: so the split below relies upon find_get_entries() having stopped
+ * when it found a subpage of the huge page, without getting further references.
+ */
+static bool shmem_punch_compound(struct page *page, pgoff_t start, pgoff_t end)
+{
+	if (!PageTransCompound(page))
+		return true;
+
+	/* Just proceed to delete a huge page wholly within the range punched */
+	if (PageHead(page) &&
+	    page->index >= start && page->index + HPAGE_PMD_NR <= end)
+		return true;
+
+	/* Try to split huge page, so we can truly punch the hole or truncate */
+	return split_huge_page(page) >= 0;
+}
+
+/*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
  */
@@ -838,31 +864,11 @@ static void shmem_undo_range(struct inod
 			if (!trylock_page(page))
 				continue;
 
-			if (PageTransTail(page)) {
-				/* Middle of THP: zero out the page */
-				clear_highpage(page);
-				unlock_page(page);
-				continue;
-			} else if (PageTransHuge(page)) {
-				if (index == round_down(end, HPAGE_PMD_NR)) {
-					/*
-					 * Range ends in the middle of THP:
-					 * zero out the page
-					 */
-					clear_highpage(page);
-					unlock_page(page);
-					continue;
-				}
-				index += HPAGE_PMD_NR - 1;
-				i += HPAGE_PMD_NR - 1;
-			}
-
-			if (!unfalloc || !PageUptodate(page)) {
-				VM_BUG_ON_PAGE(PageTail(page), page);
-				if (page_mapping(page) == mapping) {
-					VM_BUG_ON_PAGE(PageWriteback(page), page);
+			if ((!unfalloc || !PageUptodate(page)) &&
+			    page_mapping(page) == mapping) {
+				VM_BUG_ON_PAGE(PageWriteback(page), page);
+				if (shmem_punch_compound(page, start, end))
 					truncate_inode_page(mapping, page);
-				}
 			}
 			unlock_page(page);
 		}
@@ -936,43 +942,25 @@ static void shmem_undo_range(struct inod
 
 			lock_page(page);
 
-			if (PageTransTail(page)) {
-				/* Middle of THP: zero out the page */
-				clear_highpage(page);
-				unlock_page(page);
-				/*
-				 * Partial thp truncate due 'start' in middle
-				 * of THP: don't need to look on these pages
-				 * again on !pvec.nr restart.
-				 */
-				if (index != round_down(end, HPAGE_PMD_NR))
-					start++;
-				continue;
-			} else if (PageTransHuge(page)) {
-				if (index == round_down(end, HPAGE_PMD_NR)) {
-					/*
-					 * Range ends in the middle of THP:
-					 * zero out the page
-					 */
-					clear_highpage(page);
-					unlock_page(page);
-					continue;
-				}
-				index += HPAGE_PMD_NR - 1;
-				i += HPAGE_PMD_NR - 1;
-			}
-
 			if (!unfalloc || !PageUptodate(page)) {
-				VM_BUG_ON_PAGE(PageTail(page), page);
-				if (page_mapping(page) == mapping) {
-					VM_BUG_ON_PAGE(PageWriteback(page), page);
-					truncate_inode_page(mapping, page);
-				} else {
+				if (page_mapping(page) != mapping) {
 					/* Page was replaced by swap: retry */
 					unlock_page(page);
 					index--;
 					break;
 				}
+				VM_BUG_ON_PAGE(PageWriteback(page), page);
+				if (shmem_punch_compound(page, start, end))
+					truncate_inode_page(mapping, page);
+				else {
+					/* Wipe the page and don't get stuck */
+					clear_highpage(page);
+					flush_dcache_page(page);
+					set_page_dirty(page);
+					if (index <
+					    round_up(start, HPAGE_PMD_NR))
+						start = index + 1;
+				}
 			}
 			unlock_page(page);
 		}
--- 5.6-rc3/mm/swap.c	2020-02-09 17:36:41.806976836 -0800
+++ linux/mm/swap.c	2020-02-25 20:08:13.182755758 -0800
@@ -1005,6 +1005,10 @@ EXPORT_SYMBOL(__pagevec_lru_add);
  * ascending indexes.  There may be holes in the indices due to
  * not-present entries.
  *
+ * Only one subpage of a Transparent Huge Page is returned in one call:
+ * allowing truncate_inode_pages_range() to evict the whole THP without
+ * cycling through a pagevec of extra references.
+ *
  * pagevec_lookup_entries() returns the number of entries which were
  * found.
  */
