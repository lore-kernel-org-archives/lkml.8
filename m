Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D870FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3272A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hUfQWEmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgHFQ7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgHFQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C599AC0086BD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VooejEMiiERNIvSD+78Gs4QMWsbcw7N6XYDm2HvKjAk=; b=hUfQWEmZNRHztAkj/0dI/iZrwu
        c9B7so/Ldis3BlEoMDm0Y515opkuBc7r+ucHuLt8dduDarly/hHY+5a+JpmfsKAJsy0ozn7l3gH8+
        19eC+u8X8h+4rLPuxfjxiPzeoT71B3X4BZnTPCEGooafuiEjW8OK0iAnZ29j35gawjWiswWdi3/MD
        rcn7x/wI05DTfCnQZiZDHanDAEfNXAVD37jruD0+jQDymXkHcTcDepBnP1bN+o1pBJ5hVplyIoMkB
        zh7dxjF0zeXB0/ZI8ch36IsyoKv5Eizg4As2wA3ykKLFGF7FcvaJl4AxhRhLrYr+qzlYhV88YK/3C
        k1aeINQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3hzW-00009l-Ip; Thu, 06 Aug 2020 15:39:38 +0000
Date:   Thu, 6 Aug 2020 16:39:38 +0100
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
Message-ID: <20200806153938.GO23808@casper.infradead.org>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
 <ac97deea-4638-badd-9495-c9ca313837bb@suse.cz>
 <20200806134851.GN23808@casper.infradead.org>
 <790ae9a4-6874-ac34-d2a2-28a2137335cb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790ae9a4-6874-ac34-d2a2-28a2137335cb@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 05:13:05PM +0200, Vlastimil Babka wrote:
> On 8/6/20 3:48 PM, Matthew Wilcox wrote:
> > On Thu, Aug 06, 2020 at 01:45:11PM +0200, Vlastimil Babka wrote:
> >> How about this additional patch now that we have head_mapcoun()? (I wouldn't
> >> go for squashing as the goal and scope is too different).
> > 
> > I like it.  It bothers me that the compiler doesn't know that
> > compound_head(compound_head(x)) == compound_head(x).  I updated
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=32911 with a request to be
> > able to tell the compiler that compound_head() is idempotent.
> 
> Yeah it would be nice to get the benefits everywhere automatically. But I guess
> the compiler would have to discard the idempotence assumptions if there are
> multiple consecutive (perhaps hidden behind page flag access)
> compound_head(page) from a function, as soon as we modify the struct page somewhere.

The only place where we modify the struct page is the split code, and
I think we're pretty careful to handle the pages appropriately there.
The buddy allocator has its own way of combining pages.

> >> +++ b/mm/huge_memory.c
> >> @@ -2125,7 +2125,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >>  	 * Set PG_double_map before dropping compound_mapcount to avoid
> >>  	 * false-negative page_mapped().
> >>  	 */
> >> -	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> >> +	if (head_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> > 
> > I'm a little nervous about this one.  The page does actually come from
> > pmd_page(), and today that's guaranteed to be a head page.  But I'm
> > not convinced that's going to still be true in twenty years.  With the
> > current THP patchset, I won't allocate pages larger than PMD order, but
> > I can see there being interest in tracking pages in chunks larger than
> > 2MB in the future.  And then pmd_page() might well return a tail page.
> > So it might be a good idea to not convert this one.
> 
> Hmm the function converts the compound mapcount of the whole page to a
> HPAGE_PMD_NR of base pages. If suddenly the compound page was bigger than a pmd,
> then I guess this wouldn't work properly anymore without changes anyway?
> Maybe we could stick something like VM_BUG_ON(PageTransHuge(page)) there as
> "enforced documentation" for now?

I think it would work as-is.  But also I may have totally misunderstood it.
I'll write this declaratively and specifically for x86 (PMD order is 9)
... tell me when I've made a mistake ;-)

This function is for splitting the PMD.  We're leaving the underlying
page intact and just changing the page table.  So if, say, we have an
underlying 4MB page (and maybe the pages are mapped as PMDs in this
process), we might get subpage number 512 of this order-10 page.  We'd
need to check the DoubleMap bit on subpage 1, and the compound_mapcount
also stored in page 1, but we'd only want to spread the mapcount out
over the 512 subpages from 512-1023; we wouldn't want to spread it out
over 0-511 because they aren't affected by this particular PMD.

Having to reason about stuff like this is why I limited the THP code to
stop at PMD order ... I don't want to make my life even more complicated
than I have to!
