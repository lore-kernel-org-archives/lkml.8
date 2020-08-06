Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33A423119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cmrZQ8Yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgHFRPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbgHFRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:15:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC8C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XxaSeZ8vU13ipKwWzVxowozt5SCaySmLqUJlyGW8WBI=; b=cmrZQ8YvjWkEmDNcAnsrELEWBy
        +U/oGZ90fBu3UCq1CEVkLZ8pQXNZz/HX9XtdneThVBn8S+5rR7beEskioaQxUwouXGRCImpAbOLUg
        IvIh3MD/OTU10pRzBM2HG8ypZ0FianKgzTtevdllZhIe/BkaCEpQGY6KrlGv1SFM8eQsgsX0cZiaS
        1Q9hwQk9NaT839uWgfXwv/Lg3ghYyYsi3b13RJyS+MbQwfglYT54wN9v2nrDnRc/isnCEwZK+V8KU
        7jOeRrsVSiyYdxtkxFXhUgjpZL0UGtWy5iNixC/W4kW1o3tD98QhRnD3yUuh+tMvSOG8hE9Gi8aiP
        X5NTaawA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3jTp-00050N-0D; Thu, 06 Aug 2020 17:15:01 +0000
Date:   Thu, 6 Aug 2020 18:15:00 +0100
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
Message-ID: <20200806171500.GA17456@casper.infradead.org>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
 <ac97deea-4638-badd-9495-c9ca313837bb@suse.cz>
 <20200806134851.GN23808@casper.infradead.org>
 <790ae9a4-6874-ac34-d2a2-28a2137335cb@suse.cz>
 <20200806153938.GO23808@casper.infradead.org>
 <da00f435-a867-0108-8855-872019d85d44@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da00f435-a867-0108-8855-872019d85d44@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 05:53:10PM +0200, Vlastimil Babka wrote:
> On 8/6/20 5:39 PM, Matthew Wilcox wrote:
> >> >> +++ b/mm/huge_memory.c
> >> >> @@ -2125,7 +2125,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >> >>  	 * Set PG_double_map before dropping compound_mapcount to avoid
> >> >>  	 * false-negative page_mapped().
> >> >>  	 */
> >> >> -	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> >> >> +	if (head_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> >> > 
> >> > I'm a little nervous about this one.  The page does actually come from
> >> > pmd_page(), and today that's guaranteed to be a head page.  But I'm
> >> > not convinced that's going to still be true in twenty years.  With the
> >> > current THP patchset, I won't allocate pages larger than PMD order, but
> >> > I can see there being interest in tracking pages in chunks larger than
> >> > 2MB in the future.  And then pmd_page() might well return a tail page.
> >> > So it might be a good idea to not convert this one.
> >> 
> >> Hmm the function converts the compound mapcount of the whole page to a
> >> HPAGE_PMD_NR of base pages. If suddenly the compound page was bigger than a pmd,
> >> then I guess this wouldn't work properly anymore without changes anyway?
> >> Maybe we could stick something like VM_BUG_ON(PageTransHuge(page)) there as
> >> "enforced documentation" for now?
> > 
> > I think it would work as-is.  But also I may have totally misunderstood it.
> > I'll write this declaratively and specifically for x86 (PMD order is 9)
> > ... tell me when I've made a mistake ;-)
> > 
> > This function is for splitting the PMD.  We're leaving the underlying
> > page intact and just changing the page table.  So if, say, we have an
> > underlying 4MB page (and maybe the pages are mapped as PMDs in this
> > process), we might get subpage number 512 of this order-10 page.  We'd
> > need to check the DoubleMap bit on subpage 1, and the compound_mapcount
> > also stored in page 1, but we'd only want to spread the mapcount out
> > over the 512 subpages from 512-1023; we wouldn't want to spread it out
> > over 0-511 because they aren't affected by this particular PMD.
> 
> Yeah, and then we decrease the compound mapcount, which is a counter of "how
> many times is this compound page mapped as a whole". But we only removed (the
> second) half of the compound mapping, so imho that would be wrong?

I'd expect that count to be incremented by 1 for each PMD that it's
mapped to?  ie change the definition of that counter slightly.

> > Having to reason about stuff like this is why I limited the THP code to
> > stop at PMD order ... I don't want to make my life even more complicated
> > than I have to!
> 
> Kirill might correct me but I'd expect the THP code right now has baked in many
> assumptions about THP pages being exactly HPAGE_PMD_ORDER large?

There are somewhat fewer places that make that assumption after applying
the ~80 patches here ... http://git.infradead.org/users/willy/pagecache.git

I have mostly not touched the anonymous THPs (obviously some of the code
paths are shared), although both Kirill & I think there's a win to be
had there too.
