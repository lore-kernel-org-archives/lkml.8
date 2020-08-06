Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF50C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A364D23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgHFROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:14:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:41168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbgHFRNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:13:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C35CABE9;
        Thu,  6 Aug 2020 11:45:28 +0000 (UTC)
Subject: Re: [PATCH v2] mm, dump_page: do not crash with bad
 compound_mapcount()
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        willy@infradead.org, cai@lca.pw, kirill@shutemov.name,
        rppt@linux.ibm.com, william.kucharski@oracle.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ac97deea-4638-badd-9495-c9ca313837bb@suse.cz>
Date:   Thu, 6 Aug 2020 13:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804214807.169256-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/4/20 11:48 PM, John Hubbard wrote:
> If a compound page is being split while dump_page() is being run on that
> page, we can end up calling compound_mapcount() on a page that is no
> longer compound. This leads to a crash (already seen at least once in
> the field), due to the VM_BUG_ON_PAGE() assertion inside
> compound_mapcount().
> 
> (The above is from Matthew Wilcox's analysis of Qian Cai's bug report.)
> 
> A similar problem is possible, via compound_pincount() instead of
> compound_mapcount().
> 
> In order to avoid this kind of crash, make dump_page() slightly more
> robust, by providing a pair of simpler routines that don't contain
> assertions: head_mapcount() and head_pincount().
> 
> For debug tools, we don't want to go *too* far in this direction, but
> this is a simple small fix, and the crash has already been seen, so it's
> a good trade-off.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Hi,
> 
> I'm assuming that a fix is not required for -stable, but let me know if
> others feel differently. The dump_page() code has changed a lot in that
> area.

I'd say only if we backport all those changes, as most were to avoid similar
kind of crashes?
How about this additional patch now that we have head_mapcoun()? (I wouldn't
go for squashing as the goal and scope is too different).

----8<----
From 3b3d5b4639eea9c0787eed510a32acdc918d569f Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 6 Aug 2020 13:33:58 +0200
Subject: [PATCH] mm, thp: use head_mapcount when we know we have a head page

Patch "mm, dump_page: do not crash with bad compound_mapcount()" has introduced
head_mapcount() to split out the part of compound_mapcount() where we already
know/assume we have a head page. We can use the new function in more places
where we already have a head page, to avoid the overhead of compound_head()
and (with DEBUG_VM) a debug check. This patch does that. There are few more
applicable places, but behind DEBUG_VM so performance is not important, and the
extra debug check in compound_mapcount() could be useful instead.

The bloat-o-meter difference without DEBUG_VM is the following:

add/remove: 0/0 grow/shrink: 1/4 up/down: 32/-56 (-24)
Function                                     old     new   delta
__split_huge_pmd                            2867    2899     +32
shrink_page_list                            3860    3847     -13
reuse_swap_page                              762     748     -14
page_trans_huge_mapcount                     153     139     -14
total_mapcount                               187     172     -15
Total: Before=8687306, After=8687282, chg -0.00%

This just shows that compiler wasn't able to prove we have a head page by
itself. In __split_huge_pmd() the eliminated check probably led to different
optimization decisions thus code size increased.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/huge_memory.c | 6 +++---
 mm/swapfile.c    | 2 +-
 mm/vmscan.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 90733cefa528..5927874b7894 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2125,7 +2125,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * Set PG_double_map before dropping compound_mapcount to avoid
 	 * false-negative page_mapped().
 	 */
-	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
+	if (head_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
 		for (i = 0; i < HPAGE_PMD_NR; i++)
 			atomic_inc(&page[i]._mapcount);
 	}
@@ -2467,7 +2467,7 @@ int total_mapcount(struct page *page)
 	if (likely(!PageCompound(page)))
 		return atomic_read(&page->_mapcount) + 1;
 
-	compound = compound_mapcount(page);
+	compound = head_mapcount(page);
 	if (PageHuge(page))
 		return compound;
 	ret = compound;
@@ -2531,7 +2531,7 @@ int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
 		ret -= 1;
 		_total_mapcount -= HPAGE_PMD_NR;
 	}
-	mapcount = compound_mapcount(page);
+	mapcount = head_mapcount(page);
 	ret += mapcount;
 	_total_mapcount += mapcount;
 	if (total_mapcount)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9ee4211835c6..c5e722de38b8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1673,7 +1673,7 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 		map_swapcount -= 1;
 		_total_mapcount -= HPAGE_PMD_NR;
 	}
-	mapcount = compound_mapcount(page);
+	mapcount = head_mapcount(page);
 	map_swapcount += mapcount;
 	_total_mapcount += mapcount;
 	if (total_mapcount)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a086c104a9a6..72218cdfd902 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1248,7 +1248,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 					 * away. Chances are some or all of the
 					 * tail pages can be freed without IO.
 					 */
-					if (!compound_mapcount(page) &&
+					if (!head_mapcount(page) &&
 					    split_huge_page_to_list(page,
 								    page_list))
 						goto activate_locked;
-- 
2.28.0

