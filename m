Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89ABC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809742073A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581614679;
	bh=0Bm+bM9rH0vjd2eKc1aAlBAp3tlybTBpl0E38lcmg10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sohb1/SIS8Bn6eSBP/5gf0zqVjC51ribgRmlkA8yuWrMxYXu+dudd5NLN9NMJ0HlY
	 IK14bi1NLpMDVMsaMROPbSdbTzqKkfSWnIV6ClxzlQ5yvW73yqbrKuTJUZawm1M6uD
	 ZDXtcc0ZmAlHnOgX+sYfatbkgE9dGSlxs4InwIaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgBMRYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:24:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38115 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgBMRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:24:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so3451130pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aUJjzOFyqoJgGu/aUV0v4zoM5d+uLVh/RXoN2w0FGqA=;
        b=XwIzwICFLr5KzUBIzDh5ojLZHFmfSYrhCpdc3uUwbCRAwlgFCsnHC47Ny+q1igbFlX
         OXlDptyLHpQqb8eXlDLO3sNndVkRPvqYY24pH5CNj94uilJ14XPSXa1x3/soUsOYIdpj
         L4V6GN27GHg+JwR1McpX/IWwxS9jR7k90DsUOvtJslheE55R/mRUcpZ3XLoFRb45BWNG
         /P3Ga5erhPPhRnYbomYv+UMyFvf0szC3k40gR8QrIZ3WhcEwyy0KerKYweZNKuTHCwOY
         QPDz8wy9LBeNTk3SS3tFZ/oA/oFBC8IkdW+jWGOgJNW0VYG1jtG4bReck6moVAdvA9LP
         MPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aUJjzOFyqoJgGu/aUV0v4zoM5d+uLVh/RXoN2w0FGqA=;
        b=XLuCgay/5gxdPStfs/mBS0jT8jGYnKAcP41Dwq429M9nprx5Wxtc76IIWrhlfMJv5b
         QKcuwuXGVBC9ysMq/rkH6FmCPMKXNvgxdOdJCma0zAoSHnnI30grpKn0yprgW9EvAOs5
         +daSzD8Ukd20zoOU+4MfP/DL8BD639HYm/S/v/994FcOdndawB8k8CRDfLM7GFp1k1DP
         NpwQRBpa4rSC5mdJfAzSrgXwZrjzClqee09HdtM1H3sv4dc4w2nyELUdo9/QWpKvipWB
         RO4hT9dJNncCg3S6eNRwVcPFwTlwAuBI6UQZuSTbuHdHWbWlpEp5gMvwjeA4Ov9oln0l
         5P3w==
X-Gm-Message-State: APjAAAXSzl8g0B1buF5LPD4w+DfXfVIzIk6NxPQRNU93A/FwDC2xrz6V
        Sr41WBKdBNdNmjN/NmGIPGF9BjSH
X-Google-Smtp-Source: APXvYqy7GDm3fyn/RtGNy9meK9jffkJeMSMAeBdDnkSNJJWP/+cFZRVSqHixTk+PmnN6Jwyd0Uum4w==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr16120428pgi.374.1581614677564;
        Thu, 13 Feb 2020 09:24:37 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d24sm3935975pfq.75.2020.02.13.09.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:24:35 -0800 (PST)
Date:   Thu, 13 Feb 2020 09:24:34 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200213172434.GB41717@google.com>
References: <20200211163404.GC242563@google.com>
 <20200211172803.GA7778@bombadil.infradead.org>
 <20200211175731.GA185752@google.com>
 <20200212101804.GD25573@quack2.suse.cz>
 <20200212174015.GB93795@google.com>
 <20200212182851.GG7778@bombadil.infradead.org>
 <20200212195322.GA83146@google.com>
 <20200212142435.0b7e938fe8112fa35fcbcc71@linux-foundation.org>
 <20200212231210.GA233109@google.com>
 <20200212180030.a89da9c4cf2b9d11efcc25db@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212180030.a89da9c4cf2b9d11efcc25db@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Feb 12, 2020 at 06:00:30PM -0800, Andrew Morton wrote:
> On Wed, 12 Feb 2020 15:12:10 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > On Wed, Feb 12, 2020 at 02:24:35PM -0800, Andrew Morton wrote:
> > > On Wed, 12 Feb 2020 11:53:22 -0800 Minchan Kim <minchan@kernel.org> wrote:
> > > 
> > > > > That's definitely wrong.  It'll clear PageReclaim and then pretend it did
> > > > > nothing wrong.
> > > > > 
> > > > > 	return !PageWriteback(page) ||
> > > > > 		test_and_clear_bit(PG_reclaim, &page->flags);
> > > > > 
> > > > 
> > > > Much better, Thanks for the review, Matthew!
> > > > If there is no objection, I will send two patches to Andrew.
> > > > One is PageReadahead strict, the other is limit retry from mm_populate.
> > > 
> > > With much more detailed changelogs, please!
> > > 
> > > This all seems rather screwy.  if a page is under writeback then it is
> > > uptodate and we should be able to fault it in immediately.
> > 
> > Hi Andrew,
> > 
> > This description in cover-letter will work? If so, I will add each part
> > below in each patch.
> > 
> > Subject: [PATCH 0/3] fixing mm_populate long stall
> > 
> > I got several reports major page fault takes several seconds sometime.
> > When I review drop mmap_sem in page fault hanlder, I found several bugs.
> > 
> >    CPU 1							CPU 2
> > mm_populate
> >  for ()
> >    ..
> >    ret = populate_vma_page_range
> >      __get_user_pages
> >        faultin_page
> >          handle_mm_fault
> > 	   filemap_fault
> > 	     do_async_mmap_readahead
> > 	     						shrink_page_list
> > 							  pageout
> > 							    SetPageReclaim(=SetPageReadahead)
> > 							      writepage
> > 							        SetPageWriteback
> > 	       if (PageReadahead(page))
> > 	         maybe_unlock_mmap_for_io
> > 		   up_read(mmap_sem)
> > 		 page_cache_async_readahead()
> > 		   if (PageWriteback(page))
> > 		     return;
> > 
> >     here, since ret from populate_vma_page_range is zero,
> >     the loop continue to run with same address with previous
> >     iteration. It will repeat the loop until the page's
> >     writeout is done(ie, PG_writeback or PG_reclaim clear).
> 
> The populate_vma_page_range() kerneldoc is wrong.  "return 0 on
> success, negative error code on error".  Care to fix that please?

Sure.

> 
> > We could fix the above specific case via adding PageWriteback. IOW,
> > 
> >    ret = populate_vma_page_range
> >    	   ...
> > 	   ...
> > 	   filemap_fault
> > 	     do_async_mmap_readahead
> > 	       if (!PageWriteback(page) && PageReadahead(page))
> > 	         maybe_unlock_mmap_for_io
> > 		   up_read(mmap_sem)
> > 		 page_cache_async_readahead()
> > 		   if (PageWriteback(page))
> > 		     return;
> 
> Well yes, but the testing of PageWriteback() is a hack added in
> fe3cba17c49471 to permit the sharing of PG_reclaim and PG_readahead. 
> If we didn't need that hack then we could avoid adding new hacks to
> hack around the old hack :(.  Have you considered anything along those
> lines?  Rework how we handle PG_reclaim/PG_readahead?

https://lore.kernel.org/linux-mm/20200211175731.GA185752@google.com/
"
My point is why we couldn't do readahead if the marker page is under PG_writeback.
It was there for a long time and you were adding one more so I was curious what's
reasoning comes from. Let me find why PageWriteback check in
page_cache_async_readahead from the beginning.

	fe3cba17c4947, mm: share PG_readahead and PG_reclaim

The reason comes from the description

    b) clear PG_readahead => implicit clear of PG_reclaim
            one(and only one) page will not be reclaimed in time
            it can be avoided by checking PageWriteback(page) in readahead first

The goal was to avoid delay freeing of the page by clearing PG_reclaim.
I'm saying that I feel it's over optimization. IOW, it would be okay to
lose a page to be accelerated reclaim.
"

I wanted to remove PageWriteback check in page_cache_async_readahead
but didn't hear feedback and reveiwers wanted to add PageWriteback check
along with PageReadahead. That's why [2/3] was born.

> 
> > That's a thing [3/3] is fixing here. Even though it could fix the
> > problem effectively, it has still livelock problem theoretically
> > because the page of faulty address could be reclaimed and then
> > allocated/become readahead marker on other CPUs during faulty
> > process is retrying in mm_populate's loop.
> 
> Really?  filemap_fault()'s
> 
> 	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
> 		goto out_retry;
> 
> 	/* Did it get truncated? */
> 	if (unlikely(compound_head(page)->mapping != mapping)) {
> 		unlock_page(page);
> 		put_page(page);
> 		goto retry_find;
> 	}
> 
> should handle such cases?

I don't think so because once we release mmap_sem, we start fault handling
from the beginning again and page we found in new iteration is newly
allocated valid page but has same situation(e.g., PG_readahead) which could
reprouce same condition like previous iteration.

> 
> > [2/3] is fixing the
> > such livelock via limiting retry count.
> 
> I wouldn't call that "fixing" :(

If I was not wrong, it's fixing. :)

Furthermore, please consider ra_pages dancing via parallel fadvise attack
to make ra_pges zero suddency by the race.

> 
> > There is another hole for the livelock or hang of the process as well
> > as ageWriteback - ra_pages.
> > 
> > mm_populate
> >  for ()
> >    ..
> >    ret = populate_vma_page_range
> >      __get_user_pages
> >        faultin_page
> >          handle_mm_fault
> > 	   filemap_fault
> > 	     do_async_mmap_readahead
> > 	       if (PageReadahead(page))
> > 	         maybe_unlock_mmap_for_io
> > 		   up_read(mmap_sem)
> > 		 page_cache_async_readahead()
> > 		   if (!ra->ra_pages)
> > 		     return;
> > 
> > It will repeat the loop until ra->ra_pages become non-zero.
> > [1/3] is fixing the problem.
> > 
> 
