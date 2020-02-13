Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735A3C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4289B21739
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581559234;
	bh=1SwzLLEyuLUC0YcReqmRfMKXlXhD3aV8WxBnviIaFfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mdj2te9FM6FSVFADXuc0URcgCNdSd96c3TooTjZeQWxh1RPFF1zO7+vS9+QieqvKJ
	 B3QceEXXiSwT7wdCcMvpsQ+uZlVTlP+zGT4rP11f/9s7tD6r3OJfWDRrvJ9stnIw2F
	 aR+EMoasBBME3S5w8ythdKOSzraXHZGTY9Ccar/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgBMCAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbgBMCAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:00:33 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6D220659;
        Thu, 13 Feb 2020 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581559231;
        bh=1SwzLLEyuLUC0YcReqmRfMKXlXhD3aV8WxBnviIaFfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ji9FsdzXaPsvVFPj+2xKMPRNsik5cVbQqgjM0tqJzbEPtUxtKWB6/YouFDGKbnSnB
         U2Va2Xn6MjTKeCaGxqfCT9iOOZq5kE8Fj30hFCyyND00SKiKNzpq40WquOzTfYBXn5
         uFxCx+xit6Vc0I+VmJzv1HtXyJpVsIC2KqXvLuoU=
Date:   Wed, 12 Feb 2020 18:00:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-Id: <20200212180030.a89da9c4cf2b9d11efcc25db@linux-foundation.org>
In-Reply-To: <20200212231210.GA233109@google.com>
References: <20200211042536.GB242563@google.com>
        <20200211122323.GS8731@bombadil.infradead.org>
        <20200211163404.GC242563@google.com>
        <20200211172803.GA7778@bombadil.infradead.org>
        <20200211175731.GA185752@google.com>
        <20200212101804.GD25573@quack2.suse.cz>
        <20200212174015.GB93795@google.com>
        <20200212182851.GG7778@bombadil.infradead.org>
        <20200212195322.GA83146@google.com>
        <20200212142435.0b7e938fe8112fa35fcbcc71@linux-foundation.org>
        <20200212231210.GA233109@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 15:12:10 -0800 Minchan Kim <minchan@kernel.org> wrote:

> On Wed, Feb 12, 2020 at 02:24:35PM -0800, Andrew Morton wrote:
> > On Wed, 12 Feb 2020 11:53:22 -0800 Minchan Kim <minchan@kernel.org> wrote:
> > 
> > > > That's definitely wrong.  It'll clear PageReclaim and then pretend it did
> > > > nothing wrong.
> > > > 
> > > > 	return !PageWriteback(page) ||
> > > > 		test_and_clear_bit(PG_reclaim, &page->flags);
> > > > 
> > > 
> > > Much better, Thanks for the review, Matthew!
> > > If there is no objection, I will send two patches to Andrew.
> > > One is PageReadahead strict, the other is limit retry from mm_populate.
> > 
> > With much more detailed changelogs, please!
> > 
> > This all seems rather screwy.  if a page is under writeback then it is
> > uptodate and we should be able to fault it in immediately.
> 
> Hi Andrew,
> 
> This description in cover-letter will work? If so, I will add each part
> below in each patch.
> 
> Subject: [PATCH 0/3] fixing mm_populate long stall
> 
> I got several reports major page fault takes several seconds sometime.
> When I review drop mmap_sem in page fault hanlder, I found several bugs.
> 
>    CPU 1							CPU 2
> mm_populate
>  for ()
>    ..
>    ret = populate_vma_page_range
>      __get_user_pages
>        faultin_page
>          handle_mm_fault
> 	   filemap_fault
> 	     do_async_mmap_readahead
> 	     						shrink_page_list
> 							  pageout
> 							    SetPageReclaim(=SetPageReadahead)
> 							      writepage
> 							        SetPageWriteback
> 	       if (PageReadahead(page))
> 	         maybe_unlock_mmap_for_io
> 		   up_read(mmap_sem)
> 		 page_cache_async_readahead()
> 		   if (PageWriteback(page))
> 		     return;
> 
>     here, since ret from populate_vma_page_range is zero,
>     the loop continue to run with same address with previous
>     iteration. It will repeat the loop until the page's
>     writeout is done(ie, PG_writeback or PG_reclaim clear).

The populate_vma_page_range() kerneldoc is wrong.  "return 0 on
success, negative error code on error".  Care to fix that please?

> We could fix the above specific case via adding PageWriteback. IOW,
> 
>    ret = populate_vma_page_range
>    	   ...
> 	   ...
> 	   filemap_fault
> 	     do_async_mmap_readahead
> 	       if (!PageWriteback(page) && PageReadahead(page))
> 	         maybe_unlock_mmap_for_io
> 		   up_read(mmap_sem)
> 		 page_cache_async_readahead()
> 		   if (PageWriteback(page))
> 		     return;

Well yes, but the testing of PageWriteback() is a hack added in
fe3cba17c49471 to permit the sharing of PG_reclaim and PG_readahead. 
If we didn't need that hack then we could avoid adding new hacks to
hack around the old hack :(.  Have you considered anything along those
lines?  Rework how we handle PG_reclaim/PG_readahead?

> That's a thing [3/3] is fixing here. Even though it could fix the
> problem effectively, it has still livelock problem theoretically
> because the page of faulty address could be reclaimed and then
> allocated/become readahead marker on other CPUs during faulty
> process is retrying in mm_populate's loop.

Really?  filemap_fault()'s

	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
		goto out_retry;

	/* Did it get truncated? */
	if (unlikely(compound_head(page)->mapping != mapping)) {
		unlock_page(page);
		put_page(page);
		goto retry_find;
	}

should handle such cases?

> [2/3] is fixing the
> such livelock via limiting retry count.

I wouldn't call that "fixing" :(

> There is another hole for the livelock or hang of the process as well
> as ageWriteback - ra_pages.
> 
> mm_populate
>  for ()
>    ..
>    ret = populate_vma_page_range
>      __get_user_pages
>        faultin_page
>          handle_mm_fault
> 	   filemap_fault
> 	     do_async_mmap_readahead
> 	       if (PageReadahead(page))
> 	         maybe_unlock_mmap_for_io
> 		   up_read(mmap_sem)
> 		 page_cache_async_readahead()
> 		   if (!ra->ra_pages)
> 		     return;
> 
> It will repeat the loop until ra->ra_pages become non-zero.
> [1/3] is fixing the problem.
> 

