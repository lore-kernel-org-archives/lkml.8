Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2951CC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B3C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IeCjs878"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgBKR2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:28:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBKR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y/1okny0VePHyoAJzMRYVsHHPu38TK+N4jnvS6Wtx0M=; b=IeCjs878c3YJEgecyvTjbm4GMS
        F6W3BR+opYpShaCzFOABn4eP/1L1N2Q34a5pcCgKU92dVu5WfzhQYFJh+1PVdb9F3OKZog707eVE4
        S22Tbk0Q4TcW/ajRWm2xOeYwINPE2IIbsWG5aNOt5rQq48p/MqL5rEpEDXOAjYgvCT03SioVVq4gb
        FHu7L36oWnolgIqnWtSoOgsAC1Hxx7aDdZvWzO90kWSig7W9au+8X4FY8J4quli/8OVHSkZrw0IfL
        PxWrBg2Abz3wW0CbqqQ0eT88I527MesK+oEZAz07xMNA2NyijoTn0D7Xata5N65mBjhFGyKW1UyuX
        88yhC0Kg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1ZKN-0008Ou-Ni; Tue, 11 Feb 2020 17:28:03 +0000
Date:   Tue, 11 Feb 2020 09:28:03 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200211172803.GA7778@bombadil.infradead.org>
References: <20200211001958.170261-1-minchan@kernel.org>
 <20200211011021.GP8731@bombadil.infradead.org>
 <20200211035004.GA242563@google.com>
 <20200211035412.GR8731@bombadil.infradead.org>
 <20200211042536.GB242563@google.com>
 <20200211122323.GS8731@bombadil.infradead.org>
 <20200211163404.GC242563@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211163404.GC242563@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:34:04AM -0800, Minchan Kim wrote:
> On Tue, Feb 11, 2020 at 04:23:23AM -0800, Matthew Wilcox wrote:
> > On Mon, Feb 10, 2020 at 08:25:36PM -0800, Minchan Kim wrote:
> > > On Mon, Feb 10, 2020 at 07:54:12PM -0800, Matthew Wilcox wrote:
> > > > On Mon, Feb 10, 2020 at 07:50:04PM -0800, Minchan Kim wrote:
> > > > > On Mon, Feb 10, 2020 at 05:10:21PM -0800, Matthew Wilcox wrote:
> > > > > > On Mon, Feb 10, 2020 at 04:19:58PM -0800, Minchan Kim wrote:
> > > > > > >       filemap_fault
> > > > > > >         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> > > > > > 
> > > > > > Uh ... That shouldn't be possible.
> > > > > 
> > > > > Please see shrink_page_list. Vmscan uses PG_reclaim to accelerate
> > > > > page reclaim when the writeback is done so the page will have both
> > > > > flags at the same time and the PG reclaim could be regarded as
> > > > > PG_readahead in fault conext.
> > > > 
> > > > What part of fault context can make that mistake?  The snippet I quoted
> > > > below is from page_cache_async_readahead() where it will clearly not
> > > > make that mistake.  There's a lot of code here; please don't presume I
> > > > know all the areas you're talking about.
> > > 
> > > Sorry about being not clear. I am saying  filemap_fault ->
> > > do_async_mmap_readahead
> > > 
> > > Let's assume the page is hit in page cache and vmf->flags is !FAULT_FLAG
> > > TRIED so it calls do_async_mmap_readahead. Since the page has PG_reclaim
> > > and PG_writeback by shrink_page_list, it goes to 
> > > 
> > > do_async_mmap_readahead
> > >   if (PageReadahead(page))
> > >     fpin = maybe_unlock_mmap_for_io();
> > >     page_cache_async_readahead
> > >       if (PageWriteback(page))
> > >         return;
> > >       ClearPageReadahead(page); <- doesn't reach here until the writeback is clear
> > >       
> > > So, mm_populate will repeat the loop until the writeback is done.
> > > It's my just theory but didn't comfirm it by the testing.
> > > If I miss something clear, let me know it.
> > 
> > Ah!  Surely the right way to fix this is ...
> 
> I'm not sure it's right fix. Actually, I wanted to remove PageWriteback check
> in page_cache_async_readahead because I don't see corelation. Why couldn't we
> do readahead if the marker page is PG_readahead|PG_writeback design PoV?
> Only reason I can think of is it makes *a page* will be delayed for freeing
> since we removed PG_reclaim bit, which would be over-optimization for me.

You're confused.  Because we have a shortage of bits in the page flags,
we use the same bit for both PageReadahead and PageReclaim.  That doesn't
mean that a page marked as PageReclaim should be treated as PageReadahead.

> Other concern is isn't it's racy? IOW, page was !PG_writeback at the check below
> in your snippet but it was under PG_writeback in page_cache_async_readahead and
> then the IO was done before refault reaching the code again. It could be repeated
> *theoretically* even though it's very hard to happen in real practice.
> Thus, I think it would be better to remove PageWriteback check from
> page_cache_async_readahead if we really want to go the approach.

PageReclaim is always cleared before PageWriteback.  eg here:

void end_page_writeback(struct page *page)
...
        if (PageReclaim(page)) {
                ClearPageReclaim(page);
                rotate_reclaimable_page(page);
        }

        if (!test_clear_page_writeback(page))
                BUG();

so if PageWriteback is clear, PageReclaim must already be observable as clear.

