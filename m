Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8055E23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="huHb36wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgHFRZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgHFRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:03:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6C6C08ED2B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nr6d4+1/21dKoRr3pOwdT2uZTauWD92kHkuX5AwgccU=; b=huHb36wxaS7Dp9fcrj+YWMJBxo
        O3j3zRijlfzgS7PhyYwDday3McecnS578tCKGg/WqybGs2nKgw8RGAzm+oscg5tSXBDhOpt1KWm08
        4P+8qoUuG2kAYUxOAb3sQY6URsu032mSHv8Q6rJ0aS2pxwH7LpgB3tWbu/WcPS4tOBZtMa2f7i0UL
        ZxlaSQ+ue4TpWleXRBNIIJbFfhsUBxO2yJJvmLgdt28HxxAsXSyxw2mivohA4kjbAn87WC8cPLBz3
        NcVmgaWY3uWrMdkD+Toix1aaUlPj6DfhzLuyEO5f0WIhVlhwK4DVi/R3pOiQvDM2K69LHjsYOXVhk
        70s4Jebg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3gGJ-00043r-Gv; Thu, 06 Aug 2020 13:48:51 +0000
Date:   Thu, 6 Aug 2020 14:48:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        cai@lca.pw, kirill@shutemov.name, rppt@linux.ibm.com,
        william.kucharski@oracle.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm, dump_page: do not crash with bad
 compound_mapcount()
Message-ID: <20200806134851.GN23808@casper.infradead.org>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
 <ac97deea-4638-badd-9495-c9ca313837bb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac97deea-4638-badd-9495-c9ca313837bb@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:45:11PM +0200, Vlastimil Babka wrote:
> How about this additional patch now that we have head_mapcoun()? (I wouldn't
> go for squashing as the goal and scope is too different).

I like it.  It bothers me that the compiler doesn't know that
compound_head(compound_head(x)) == compound_head(x).  I updated
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=32911 with a request to be
able to tell the compiler that compound_head() is idempotent.

> The bloat-o-meter difference without DEBUG_VM is the following:
> 
> add/remove: 0/0 grow/shrink: 1/4 up/down: 32/-56 (-24)
> Function                                     old     new   delta
> __split_huge_pmd                            2867    2899     +32
> shrink_page_list                            3860    3847     -13
> reuse_swap_page                              762     748     -14
> page_trans_huge_mapcount                     153     139     -14
> total_mapcount                               187     172     -15
> Total: Before=8687306, After=8687282, chg -0.00%

That's great.  I'm expecting improvements from my thp_head() macro when
that lands (currently in Andrew's tree).  I have been reluctant to replace
current callers of compound_head() with thp_head(), but I suspect PF_HEAD
could use thp_head() and save a few bytes on a tinyconfig build.

> +++ b/mm/huge_memory.c
> @@ -2125,7 +2125,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	 * Set PG_double_map before dropping compound_mapcount to avoid
>  	 * false-negative page_mapped().
>  	 */
> -	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> +	if (head_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {

I'm a little nervous about this one.  The page does actually come from
pmd_page(), and today that's guaranteed to be a head page.  But I'm
not convinced that's going to still be true in twenty years.  With the
current THP patchset, I won't allocate pages larger than PMD order, but
I can see there being interest in tracking pages in chunks larger than
2MB in the future.  And then pmd_page() might well return a tail page.
So it might be a good idea to not convert this one.

> @@ -2467,7 +2467,7 @@ int total_mapcount(struct page *page)
>  	if (likely(!PageCompound(page)))
>  		return atomic_read(&page->_mapcount) + 1;
>  
> -	compound = compound_mapcount(page);
> +	compound = head_mapcount(page);
>  	if (PageHuge(page))
>  		return compound;
>  	ret = compound;

Yes.  This function is a little confusing because it uses PageCompound()
all the way through when it really should be using PageHead ... because
the opening line of the function is: VM_BUG_ON_PAGE(PageTail(page), page);

> @@ -2531,7 +2531,7 @@ int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
>  		ret -= 1;
>  		_total_mapcount -= HPAGE_PMD_NR;
>  	}
> -	mapcount = compound_mapcount(page);
> +	mapcount = head_mapcount(page);
>  	ret += mapcount;
>  	_total_mapcount += mapcount;
>  	if (total_mapcount)

Yes, we called compound_head() earlier in the function.  Safe.

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9ee4211835c6..c5e722de38b8 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1673,7 +1673,7 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
>  		map_swapcount -= 1;
>  		_total_mapcount -= HPAGE_PMD_NR;
>  	}
> -	mapcount = compound_mapcount(page);
> +	mapcount = head_mapcount(page);
>  	map_swapcount += mapcount;
>  	_total_mapcount += mapcount;
>  	if (total_mapcount)

Yes.  page is a head page at this point.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a086c104a9a6..72218cdfd902 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1248,7 +1248,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  					 * away. Chances are some or all of the
>  					 * tail pages can be freed without IO.
>  					 */
> -					if (!compound_mapcount(page) &&
> +					if (!head_mapcount(page) &&
>  					    split_huge_page_to_list(page,
>  								    page_list))
>  						goto activate_locked;

Yes.  We don't put (can't put!) tail pages on the lists, so this must be a
head page.
